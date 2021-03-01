package com.chat.model;


public class ChatVO implements java.io.Serializable{
	
	private Integer chatNo;
	private Integer chatSender;
	private Integer chatReceiver;
	private String chatText;
	private java.sql.Timestamp chatTime;
	private Boolean chatIsRead;
	private byte[] chatPic;
	
	public ChatVO() {
	}

	public Integer getChatNo() {
		return chatNo;
	}

	public void setChatNo(Integer chatNo) {
		this.chatNo = chatNo;
	}

	public Integer getChatSender() {
		return chatSender;
	}

	public void setChatSender(Integer chatSender) {
		this.chatSender = chatSender;
	}

	public Integer getChatReceiver() {
		return chatReceiver;
	}

	public void setChatReceiver(Integer chatReceiver) {
		this.chatReceiver = chatReceiver;
	}

	public String getChatText() {
		return chatText;
	}

	public void setChatText(String chatText) {
		this.chatText = chatText;
	}

	public java.sql.Timestamp getChatTime() {
		return chatTime;
	}

	public void setChatTime(java.sql.Timestamp chatTime) {
		this.chatTime = chatTime;
	}

	public Boolean getChatIsRead() {
		return chatIsRead;
	}

	public void setChatIsRead(Boolean chatIsRead) {
		this.chatIsRead = chatIsRead;
	}

	public byte[] getChatPic() {
		return chatPic;
	}

	public void setChatPic(byte[] chatPic) {
		this.chatPic = chatPic;
	}
	
	
}
