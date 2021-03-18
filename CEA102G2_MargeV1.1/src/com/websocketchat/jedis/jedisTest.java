package com.websocketchat.jedis;

import java.util.List;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class jedisTest {

	private static JedisPool pool = JedisPoolUtil.getJedisPool();
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String key = new StringBuilder("123").append(":").append("1231").toString();
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		List<String> historyData = jedis.lrange("KING10:*", 0, -1);
		
		for(String str: historyData) {
			System.out.println(str);
		}
		jedis.close();
	}

}
