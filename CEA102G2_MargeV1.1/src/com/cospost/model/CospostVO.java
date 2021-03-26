package com.cospost.model;
import java.sql.Timestamp;

public class CospostVO implements java.io.Serializable{
		private Integer cosPubNo;
		private Integer cosNo;
		private String cosPubCon;
		private Timestamp cosPubTime;
//		chatBox會來找這個參數發生衝突不知道為什麼，所以加這個
		private String chatText ;

		
		
		public String getChatText() {
			return chatText;
		}

		public void setChatText(String chatText) {
			this.chatText = chatText;
		}
	//end chatText
		
		public Integer getCosPubNo() {
			return cosPubNo;
		}
		public void setCosPubNo(Integer cosPubNo) {
			this.cosPubNo = cosPubNo;
		}
		public Integer getCosNo() {
			return cosNo;
		}
		public void setCosNo(Integer cosNo) {
			this.cosNo = cosNo;
		}
		public String getCosPubCon() {
			return cosPubCon;
		}
		public void setCosPubCon(String cosPubCon) {
			this.cosPubCon = cosPubCon;
		}
		public Timestamp getCosPubTime() {
			return cosPubTime;
		}
		public void setCosPubTime(Timestamp cosPubTime) {
			this.cosPubTime = cosPubTime;
		}
		
		
	}

