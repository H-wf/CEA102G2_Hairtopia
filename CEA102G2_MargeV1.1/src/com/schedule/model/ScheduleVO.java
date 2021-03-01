package com.schedule.model;

import java.sql.Date;

public class ScheduleVO implements java.io.Serializable{
	private Integer schNo;
	private Integer desNo;
	private Date  schDate;
	private String  schStatus;
	
	
	public ScheduleVO () {}
	
	
	public Integer getSchNo() {
		return schNo;
	}
	public void setSchNo(Integer schNo) {
		this.schNo = schNo;
	}
	public Integer getDesNo() {
		return desNo;
	}
	public void setDesNo(Integer desNo) {
		this.desNo = desNo;
	}
	public Date getSchDate() {
		return schDate;
	}
	public void setSchDate(java.sql.Date schDate) {
		this.schDate = schDate;
	}
	public String getSchStatus() {
		return schStatus;
	}
	public void setSchStatus(String schStatus) {
		this.schStatus = schStatus;
	}

}
