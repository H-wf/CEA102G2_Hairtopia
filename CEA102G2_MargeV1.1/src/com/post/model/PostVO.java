package com.post.model;

public class PostVO implements java.io.Serializable{
	private Integer postNo;
	private Integer desNo;
	private String postCon;
	private byte[] postPic1;
	private byte[] postPic2;
	private byte[] postPic3;
	private java.sql.Timestamp postTime;
	private Integer postStatus;	//
	private boolean postPror;
	
	public Integer getPostNo() {
		return postNo;
	}
	public void setPostNo(Integer postNo) {
		this.postNo = postNo;
	}
	public Integer getDesNo() {
		return desNo;
	}
	public void setDesNo(Integer desNo) {
		this.desNo = desNo;
	}
	public String getPostCon() {
		return postCon;
	}
	public void setPostCon(String postCon) {
		this.postCon = postCon;
	}
	public byte[] getPostPic1() {
		return postPic1;
	}
	public void setPostPic1(byte[] postPic1) {
		this.postPic1 = postPic1;
	}
	public byte[] getPostPic2() {
		return postPic2;
	}
	public void setPostPic2(byte[] postPic2) {
		this.postPic2 = postPic2;
	}
	public byte[] getPostPic3() {
		return postPic3;
	}
	public void setPostPic3(byte[] postPic3) {
		this.postPic3 = postPic3;
	}
	public java.sql.Timestamp getPostTime() {
		return postTime;
	}
	public void setPostTime(java.sql.Timestamp postTime) {
		this.postTime = postTime;
	}
	public Integer getPostStatus() {
		return postStatus;
	}
	public void setPostStatus(Integer postStatus) {
		this.postStatus = postStatus;
	}
	public boolean isPostPror() {
		return postPror;
	}
	public void setPostPror(boolean postPror) {
		this.postPror = postPror;
	}
	
	
}
