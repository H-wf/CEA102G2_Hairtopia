package com.service.model;

import java.io.Serializable;

public class ServiceVO implements Serializable{
	
	private Integer serNo;
	private Integer desNo;
	private Integer stypeNo;
	private String serName;
	private Integer serPrice;
	private Integer serTime;
	private String serDesc;
	private Integer serStatus;
	
	public ServiceVO() {
	}
	
	public Integer getSerNo() {
		return serNo;
	}
	
	public void setSerNo(Integer serNo) {
		this.serNo = serNo;
	}
	
	public Integer getDesNo() {
		return desNo;
	}
	
	public void setDesNo(Integer desNo) {
		this.desNo = desNo;
	}
	
	public Integer getStypeNo() {
		return stypeNo;
	}
	
	public void setStypeNo(Integer stypeNo) {
		this.stypeNo = stypeNo;
	}
	
	public String getSerName() {
		return serName;
	}
	
	public void setSerName(String serName) {
		this.serName = serName;
	}
	
	public Integer getSerPrice() {
		return serPrice;
	}
	
	public void setSerPrice(Integer serPrice) {
		this.serPrice = serPrice;
	}
	
	public Integer getSerTime() {
		return serTime;
	}
	
	public void setSerTime(Integer serTime) {
		this.serTime = serTime;
	}
	
	public String getSerDesc() {
		return serDesc;
	}
	
	public void setSerDesc(String serDesc) {
		this.serDesc = serDesc;
	}
	
	public Integer getSerStatus() {
		return serStatus;
	}
	
	public void setSerStatus(Integer serStatus) {
		this.serStatus = serStatus;
	}
	
	

}
