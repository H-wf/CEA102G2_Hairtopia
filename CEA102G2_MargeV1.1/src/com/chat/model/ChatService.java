package com.chat.model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public class ChatService {
	private ChatDAO_interface dao;
	
	public ChatService() {
		dao = new ChatHibernateDAO();
	}
	
	public ChatVO addChat(Integer chatSender, Integer chatReceiver, String chatText, byte[] chatPic) {
		ChatVO chatVO = new ChatVO();
		
		chatVO.setChatSender(chatSender);
		chatVO.setChatReceiver(chatReceiver);
		chatVO.setChatText(chatText);
		chatVO.setChatPic(chatPic);
		chatVO.setChatTime(new Timestamp(new Date().getTime()));
		
		dao.insert(chatVO);
		
		return chatVO;
	}
	
	public ChatVO updateChat(Integer chatNo, Integer chatSender, Integer chatReceiver, String chatText, byte[] chatPic) {
		
		ChatVO chatVO = dao.findByPrimaryKey(chatNo);
		chatVO.setChatNo(chatNo);
		chatVO.setChatSender(chatSender);
		chatVO.setChatReceiver(chatReceiver);
		chatVO.setChatText(chatText);
		chatVO.setChatPic(chatPic);
		
		dao.update(chatVO);
		
		return chatVO;
	}
	
	public void deleteChat(Integer chatNo) {
		dao.delete(chatNo);
	}
	
	public ChatVO getOneChat(Integer chatNo) {
		return dao.findByPrimaryKey(chatNo);
	}
	
	public List<ChatVO> getAll() {
		return dao.getAll();
	}
		
}
