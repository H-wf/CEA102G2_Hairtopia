package com.notification.model;

public class NotiVO implements java.io.Serializable{
	private Integer notiNo;
	private Integer memNo;
	private String notiText;
	private java.sql.Timestamp notiTime;
	private Boolean notiIsRead;
	
	public NotiVO() {
	}
	public Integer getNotiNo() {
		return notiNo;
	}
	public void setNotiNo(Integer notiNo) {
		this.notiNo = notiNo;
	}
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	public String getNotiText() {
		return notiText;
	}
	public void setNotiText(String notiText) {
		this.notiText = notiText;
	}
	public java.sql.Timestamp getNotiTime() {
		return notiTime;
	}
	public void setNotiTime(java.sql.Timestamp notiTime) {
		this.notiTime = notiTime;
	}
	public Boolean getNotiIsRead() {
		return notiIsRead;
	}
	public void setNotiIsRead(Boolean notiIsRead) {
		this.notiIsRead = notiIsRead;
	}
	
}
