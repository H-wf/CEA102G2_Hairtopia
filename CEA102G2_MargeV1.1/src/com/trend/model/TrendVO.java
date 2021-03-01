package com.trend.model;

import java.sql.Timestamp;

public class TrendVO implements java.io.Serializable{
	private Integer treNo;
	private String treTitle;
	private String treCon;
	private Timestamp treTime;
	
	public TrendVO () {}
	
	public Integer getTreNo() {
		return treNo;
	}
	public void setTreNo(Integer treNo) {
		this.treNo = treNo;
	}
	public String getTreTitle() {
		return treTitle;
	}
	public void setTreTitle(String treTitle) {
		this.treTitle = treTitle;
	}
	public String getTreCon() {
		return treCon;
	}
	public void setTreCon(String treCon) {
		this.treCon = treCon;
	}
	public Timestamp getTreTime() {
		return treTime;
	}
	public void setTreTime(Timestamp treTime) {
		this.treTime = treTime;
	}

}
