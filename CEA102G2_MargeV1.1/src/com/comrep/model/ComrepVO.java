package com.comrep.model;

public class ComrepVO implements java.io.Serializable{
	private Integer crepNo;
	private Integer comNo;
	private Integer memNo;
	private String crepCon;
	private java.sql.Date crepTime;
	private Integer crepStatus;
	
	
	public Integer getCrepNo() {
		return crepNo;
	}
	public void setCrepNo(Integer crepNo) {
		this.crepNo = crepNo;
	}
	public Integer getComNo() {
		return comNo;
	}
	public void setComNo(Integer comNo) {
		this.comNo = comNo;
	}
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	public String getCrepCon() {
		return crepCon;
	}
	public void setCrepCon(String crepCon) {
		this.crepCon = crepCon;
	}
	public java.sql.Date getCrepTime() {
		return crepTime;
	}
	public void setCrepTime(java.sql.Date crepTime) {
		this.crepTime = crepTime;
	}
	public Integer getCrepStatus() {
		return crepStatus;
	}
	public void setCrepStatus(Integer crepStatus) {
		this.crepStatus = crepStatus;
	}
	
}
