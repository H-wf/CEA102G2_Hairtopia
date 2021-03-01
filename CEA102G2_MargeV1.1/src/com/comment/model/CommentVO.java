package com.comment.model;

public class CommentVO implements java.io.Serializable{
	private Integer comNo;
	private Integer postNo;
	private Integer memNo;
	private String comCon;
	private java.sql.Date comTime;
	private boolean comStatus;
	
	
	public Integer getComNo() {
		return comNo;
	}
	public void setComNo(Integer comNo) {
		this.comNo = comNo;
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
	public void setMemNo(Integer memNO) {
		this.memNo = memNO;
	}
	public String getComCon() {
		return comCon;
	}
	public void setComCon(String comCon) {
		this.comCon = comCon;
	}
	public java.sql.Date getComTime() {
		return comTime;
	}
	public void setComTime(java.sql.Date comTime) {
		this.comTime = comTime;
	}
	public boolean isComStatus() {
		return comStatus;
	}
	public void setComStatus(boolean comStatus) {
		this.comStatus = comStatus;
	}
	
	

}
