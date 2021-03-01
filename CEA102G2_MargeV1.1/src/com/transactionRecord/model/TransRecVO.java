package com.transactionRecord.model;

import java.io.Serializable;

public class TransRecVO implements Serializable{
	private Integer traNo;
	private Integer memNo;
	private java.sql.Date traTime;
	private Integer traDes;
	private Integer traPri;
	private Integer traBal;
	
	public TransRecVO() {
	}

	public Integer getTraNo() {
		return traNo;
	}

	public void setTraNo(Integer traNo) {
		this.traNo = traNo;
	}

	public Integer getMemNo() {
		return memNo;
	}

	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}

	public java.sql.Date getTraTime() {
		return traTime;
	}

	public void setTraTime(java.sql.Date traTime) {
		this.traTime = traTime;
	}

	public Integer getTraDes() {
		return traDes;
	}

	public void setTraDes(Integer traDes) {
		this.traDes = traDes;
	}

	public Integer getTraPri() {
		return traPri;
	}

	public void setTraPri(Integer traPri) {
		this.traPri = traPri;
	}

	public Integer getTraBal() {
		return traBal;
	}

	public void setTraBal(Integer traBal) {
		this.traBal = traBal;
	}
}
