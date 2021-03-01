package com.postrep.model;

public class PostrepVO implements java.io.Serializable{

	private Integer prepNo;
	private Integer postNo;
	private Integer memNo;
	private String postRepCon;
	private java.sql.Date postRepTime;
	private Integer postRepStatus;
	
	public Integer getPrepNo() {
		return prepNo;
	}
	public void setPrepNo(Integer prepNo) {
		this.prepNo = prepNo;
	}
	public Integer getPostNo() {
		return postNo;
	}
	public void setPostNo(Integer postNo) {
		this.postNo = postNo;
	}
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	public String getPostRepCon() {
		return postRepCon;
	}
	public void setPostRepCon(String postRepCon) {
		this.postRepCon = postRepCon;
	}
	public java.sql.Date getPostRepTime() {
		return postRepTime;
	}
	public void setPostRepTime(java.sql.Date postRepTime) {
		this.postRepTime = postRepTime;
	}
	public Integer getPostRepStatus() {
		return postRepStatus;
	}
	public void setPostRepStatus(Integer postRepStatus) {
		this.postRepStatus = postRepStatus;
	}
	
	
}
