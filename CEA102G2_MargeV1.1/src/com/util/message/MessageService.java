package com.util.message;

import java.io.IOException;
import java.net.URLEncoder;

import org.apache.http.HttpEntity;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

public class MessageService {
	
	public static void sendSms(String phone,String msg) {
		try (CloseableHttpClient httpclient = HttpClients.createDefault()) {
        	String url = "http://api.message.net.tw/send.php?longsms=1&id=0981069319&"
        			   + "password=Cea1020404&mtype=G&encoding=urlencode_utf8";
        	//這是api的網址還有帳號跟密碼 免費coda大概有100封  可以再去註冊http://www.message.com.tw/modules/tadnews/index.php?nsn=85
        	//id為網站帳號  password為服務的密碼
        	String tel = "&tel=";
        	String msgp = "&msg=";
        	//api必要串接項目 主要就是走get方法串接
        	
            HttpGet httpget = new HttpGet(url+ tel + phone + msgp + msg);
            System.out.println("Executing request " + httpget.getRequestLine());

            // Create a custom response handler
            ResponseHandler<String> responseHandler = response -> {
                int status = response.getStatusLine().getStatusCode();
                if (status >= 200 && status < 300) {
                    HttpEntity entity = response.getEntity();
                    return entity != null ? EntityUtils.toString(entity) : null;
                } else {
                    throw new ClientProtocolException("Unexpected response status: " + status);
                }
            };
            String responseBody = httpclient.execute(httpget, responseHandler);
            System.out.println("----------------------------------------");
            System.out.println(responseBody);
        } catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}

}
