package com.websocketchat.controller;

import java.io.IOException;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;
import javax.websocket.CloseReason;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.member.model.MemVO;
import com.websocketchat.jedis.JedisHandleMessage;
import com.websocketchat.model.ChatMessage;
import com.websocketchat.model.State;
import com.chat.model.*;

@ServerEndpoint(value="/FriendWS/{userName}")
public class FriendWS {
	private static Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	Gson gson = new Gson();


	@OnOpen
	public void onOpen(@PathParam("userName") String userName, Session userSession, EndpointConfig config) throws IOException {

//		MemVO user = (MemVO)httpSession.getAttribute("userSession");
//		System.out.println(user.getMemName());
		
		/* save the new user in the map */
		sessionsMap.put(userName, userSession);
		/* Sends all the connected users to the new user */
		Set<String> userNames = sessionsMap.keySet();
		State stateMessage = new State("open", userName, userNames);
		String stateMessageJson = gson.toJson(stateMessage);
		Collection<Session> sessions = sessionsMap.values();
		for (Session session : sessions) {
			if (session.isOpen()) {
				session.getAsyncRemote().sendText(stateMessageJson);
			}
		}

		String text = String.format("Session ID = %s, connected; userName = %s%nusers: %s", userSession.getId(),
				userName, userNames);
		System.out.println(text);
	}

	@OnMessage
	public void onMessage(Session userSession, String message) {
		ChatMessage chatMessage = gson.fromJson(message, ChatMessage.class);
		String sender = chatMessage.getSender();
		String receiver = chatMessage.getReceiver();
		String timestamp = chatMessage.getTimstamp();
		
		if ("history".equals(chatMessage.getType())) {
			//從jedis取得歷史資料
			List<String> historyData = JedisHandleMessage.getHistoryMsg(sender, receiver);
			//轉型成JSON檔案，作為傳送
			String historyMsg = gson.toJson(historyData);
			//產生message格式的物件
			ChatMessage cmHistory = new ChatMessage("history", sender, receiver, historyMsg, timestamp);
			//確認連線是否正常，再進行傳送
			if (userSession != null && userSession.isOpen()) {
				userSession.getAsyncRemote().sendText(gson.toJson(cmHistory));
				System.out.println("history = " + gson.toJson(cmHistory));
				return;
			}
		}else if("image".equals(chatMessage.getType())) {
			System.out.println(chatMessage.getMessage());
			userSession.getAsyncRemote().sendText(message);
			return;
		}else if("chat".equals(chatMessage.getType())) {
			Session receiverSession = sessionsMap.get(receiver);
			//不管對方在不在線上，接回傳給自己以及存進Redis，下次對方上線存取的為最新資料就會包含新的內容
			userSession.getAsyncRemote().sendText(message);
			JedisHandleMessage.saveChatMessage(sender, receiver, message);
			//對方在線的話，再發送新的資料給他
			if (receiverSession != null && receiverSession.isOpen()) {
				receiverSession.getAsyncRemote().sendText(message);
//				userSession.getAsyncRemote().sendText(message);
//				JedisHandleMessage.saveChatMessage(sender, receiver, message);
			}
			System.out.println("Message received: " + message);
		}else if("notification".equals(chatMessage.getType())) {
			//從jedis取得歷史資料
			List<String> notificationData = JedisHandleMessage.getLastMessageList(sender);
			//轉型成JSON檔案，作為傳送
			String notificationMsg = gson.toJson(notificationData);
			//產生message格式的物件
			ChatMessage cmHistory = new ChatMessage("notification", sender, receiver, notificationMsg, timestamp);
			//確認連線是否正常，再進行傳送
			if (userSession != null && userSession.isOpen()) {
				userSession.getAsyncRemote().sendText(gson.toJson(cmHistory));
				System.out.println("notification = " + gson.toJson(cmHistory));
				return;
			}
			
		}
		
		
		
	}

	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		String userNameClose = null;
		Set<String> userNames = sessionsMap.keySet();
		for (String userName : userNames) {
			if (sessionsMap.get(userName).equals(userSession)) {
				userNameClose = userName;
				sessionsMap.remove(userName);
				break;
			}
		}

		if (userNameClose != null) {
			State stateMessage = new State("close", userNameClose, userNames);
			String stateMessageJson = gson.toJson(stateMessage);
			Collection<Session> sessions = sessionsMap.values();
			for (Session session : sessions) {
				session.getAsyncRemote().sendText(stateMessageJson);
			}
		}

		String text = String.format("session ID = %s, disconnected; close code = %d%nusers: %s", userSession.getId(),
				reason.getCloseCode().getCode(), userNames);
		System.out.println(text);
	}
}
