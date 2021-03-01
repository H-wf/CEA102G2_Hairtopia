package com.staff.model;

public class StaffVO implements java.io.Serializable{
	private Integer staNo;
	private String  staAcct;
	private String  staPswd;
	private String  staName;
	
	
	public StaffVO () {}
	
	public Integer getStaNo() {
		return staNo;
	}
	public void setStaNo(Integer staNo) {
		this.staNo = staNo;
	}
	public String getStaAcct() {
		return staAcct;
	}
	public void setStaAcct(String staAcct) {
		this.staAcct = staAcct;
	}
	public String getStaPswd() {
		return staPswd;
	}
	public void setStaPswd(String staPswd) {
		this.staPswd = staPswd;
	}
	public String getStaName() {
		return staName;
	}
	public void setStaName(String staName) {
		this.staName = staName;
	}
	

	

	
	
}
