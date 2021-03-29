package com.websocketchat.jedis;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.ScanParams;
import redis.clients.jedis.ScanResult;

public class JedisHandleMessage {
	// 此範例key的設計為(發送者名稱:接收者名稱)，實際應採用(發送者會員編號:接收者會員編號)

	private static JedisPool pool = JedisPoolUtil.getJedisPool();

	public static List<String> getHistoryMsg(String sender, String receiver) {
		String key = new StringBuilder(sender).append(":").append(receiver).toString();
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		List<String> historyData = jedis.lrange(key, 0, -1);
		jedis.close();
		return historyData;
	}

	public static void saveChatMessage(String sender, String receiver, String message) {
		// 對雙方來說，都要各存著歷史聊天記錄
		String senderKey = new StringBuilder(sender).append(":").append(receiver).toString();
		String receiverKey = new StringBuilder(receiver).append(":").append(sender).toString();
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
		jedis.rpush(senderKey, message);
		jedis.rpush(receiverKey, message);

		jedis.close();
	}

	public static void saveAuthenticationCode(String memEmail, String VerificationCode) {
		String key = new StringBuilder(memEmail).append(":").append("AuthenticationCode").toString();
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
		
		jedis.select(1);
		jedis.set(key, VerificationCode);
		jedis.expire(key, 1800);
		
		jedis.close();		
	}
	public static String verifyAuthenticationCode(String memEmail) {
		String key = new StringBuilder(memEmail).append(":").append("AuthenticationCode").toString();
		String AuthenticationCode = null;
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
		jedis.select(1);
		AuthenticationCode = jedis.get(key);
		
		jedis.close();	
		return AuthenticationCode;
	}
	
	public static  List<String> getLastMessageList(String user){
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
		List<String> historyList = new ArrayList<String>();
		
		String cursor = ScanParams.SCAN_POINTER_START;
	    String key = user + ":" + "*";
	    ScanParams scanParams = new ScanParams();
	    scanParams.match(key);// 匹配以 test:xttblog:* 为前缀的 key
	    scanParams.count(1000);
	     
	    while (true){
	        //使用scan命令获取500条数据，使用cursor游标记录位置，下次循环使用
	        ScanResult<String> scanResult = jedis.scan(cursor, scanParams);
	        cursor = scanResult.getStringCursor();// 返回0 说明遍历完成
	        List<String> list = scanResult.getResult();
	        long t1 = System.currentTimeMillis();
	        for(int i = 0;i < list.size();i++){
	            String mapentry = list.get(i);
	            List<String> historyData = jedis.lrange(mapentry, -1, -1);
	            for(int j = 0; j < historyData.size(); j++) {
	            	
	            	historyList.add(historyData.get(j));
	            }
	        }
	        long t2 = System.currentTimeMillis();
	        if ("0".equals(cursor)){
	            break;
	        }
	        
	    }
	    jedis.close();	
		return historyList;
	}
	
	public static void main(String[] args) {
		List<String> list = JedisHandleMessage.getLastMessageList("Aragaki Yui");
		for(int i = 0; i < list.size(); i++ ) {
			System.out.println(list.get(i));
		}
	}
}
