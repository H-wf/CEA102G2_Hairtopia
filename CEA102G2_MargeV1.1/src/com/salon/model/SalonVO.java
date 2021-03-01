package com.salon.model;

import java.io.Serializable;

public class SalonVO implements Serializable{
	
	private Integer salNo;
	private String salName;
	private String salAdd;
	private String salTime;
	private String salPhone;
	private Integer salStatus;
	
	public SalonVO() {
	}

	public Integer getSalNo() {
		return salNo;
	}

	public void setSalNo(Integer salNo) {
		this.salNo = salNo;
	}

	public String getSalName() {
		return salName;
	}

	public void setSalName(String salName) {
		this.salName = salName;
	}

	public String getSalAdd() {
		return salAdd;
	}

	public void setSalAdd(String salAdd) {
		this.salAdd = salAdd;
	}

	public String getSalTime() {
		return salTime;
	}

	public void setSalTime(String salTime) {
		this.salTime = salTime;
	}

	public String getSalPhone() {
		return salPhone;
	}

	public void setSalPhone(String salPhone) {
		this.salPhone = salPhone;
	}

	public Integer getSalStatus() {
		return salStatus;
	}

	public void setSalStatus(Integer salStatus) {
		this.salStatus = salStatus;
	};
	
	
	

}
