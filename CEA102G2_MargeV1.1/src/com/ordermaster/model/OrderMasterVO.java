package com.ordermaster.model;

import java.sql.Timestamp;

public class OrderMasterVO {
	private Integer ordNo;
	private Integer memNo;
	private Timestamp ordDate;
	private Integer ordStatus;
	private Integer ordAmt;
	
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
	
}
