package com.resrep.model;

import java.io.Serializable;
import java.sql.Date;

public class RrepVO implements Serializable{
	
	private Integer rrepNo;
	private Integer resNo;
	private Integer desNo;
	private String rrepCon;
	private Date rrepTime;
	private Integer rrepStatus;
	
	public RrepVO() {}

	public Integer getRrepNo() {
		return rrepNo;
	}

	public void setRrepNo(Integer rrepNo) {
		this.rrepNo = rrepNo;
	}

	public Integer getResNo() {
		return resNo;
	}

	public void setResNo(Integer resNo) {
		this.resNo = resNo;
	}

	public Integer getDesNo() {
		return desNo;
	}

	public void setDesNo(Integer desNo) {
		this.desNo = desNo;
	}

	public String getRrepCon() {
		return rrepCon;
	}

	public void setRrepCon(String rrepCon) {
		this.rrepCon = rrepCon;
	}

	public Date getRrepTime() {
		return rrepTime;
	}

	public void setRrepTime(Date rrepTime) {
		this.rrepTime = rrepTime;
	}

	public Integer getRrepStatus() {
		return rrepStatus;
	}

	public void setRrepStatus(Integer rrepStatus) {
		this.rrepStatus = rrepStatus;
	};
	
	

}
