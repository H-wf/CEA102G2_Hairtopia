package com.ordermaster.model;

import java.sql.Timestamp;

public class OrderMasterVO implements java.io.Serializable {
	private Integer ordNo;
	private Integer memNo;
	private Timestamp ordDate;
	private Integer ordStatus;
	private Integer ordAmt;
	private String ordName;
	private String ordEmail;
	private String ordPhone;
	private String ordAddr;
		
	public Integer getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(Integer ordNo) {
		this.ordNo = ordNo;
	}
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	public Timestamp getOrdDate() {
		return ordDate;
	}
	public void setOrdDate(Timestamp ordDate) {
		this.ordDate = ordDate;
	}
	public Integer getOrdStatus() {
		return ordStatus;
	}
	public void setOrdStatus(Integer ordStatus) {
		this.ordStatus = ordStatus;
	}
	public Integer getOrdAmt() {
		return ordAmt;
	}
	public void setOrdAmt(Integer ordAmt) {
		this.ordAmt = ordAmt;
	}
	public String getOrdName() {
		return ordName;
	}
	public void setOrdName(String ordName) {
		this.ordName = ordName;
	}
	public String getOrdEmail() {
		return ordEmail;
	}
	public void setOrdEmail(String ordEmail) {
		this.ordEmail = ordEmail;
	}
	public String getOrdPhone() {
		return ordPhone;
	}
	public void setOrdPhone(String ordPhone) {
		this.ordPhone = ordPhone;
	}
	public String getOrdAddr() {
		return ordAddr;
	}
	public void setOrdAddr(String ordAddr) {
		this.ordAddr = ordAddr;
	}
}
