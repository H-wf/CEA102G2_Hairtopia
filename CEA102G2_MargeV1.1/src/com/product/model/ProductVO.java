package com.product.model;

import java.sql.Timestamp;

public class ProductVO {
	private Integer proNo;
	private Integer ptypeNo;
	private Integer braNo;
	private String proName;
	private boolean proStatus;
	private Integer proPrice;
	private byte[] proMpic;
	private byte[] proPic;
	private String proDesc;
	private Timestamp proDate;
	
	public Integer getProNo() {
		return proNo;
	}
	public void setProNo(Integer proNo) {
		this.proNo = proNo;
	}
	public Integer getPtypeNo() {
		return ptypeNo;
	}
	public void setPtypeNo(Integer ptypeNo) {
		this.ptypeNo = ptypeNo;
	}
	public Integer getBraNo() {
		return braNo;
	}
	public void setBraNo(Integer braNo) {
		this.braNo = braNo;
	}
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	public boolean isProStatus() {
		return proStatus;
	}
	public void setProStatus(boolean proStatus) {
		this.proStatus = proStatus;
	}
	public Integer getProPrice() {
		return proPrice;
	}
	public void setProPrice(Integer proPrice) {
		this.proPrice = proPrice;
	}
	public byte[] getProMpic() {
		return proMpic;
	}
	public void setProMpic(byte[] proMpic) {
		this.proMpic = proMpic;
	}
	public byte[] getProPic() {
		return proPic;
	}
	public void setProPic(byte[] proPic) {
		this.proPic = proPic;
	}
	public String getProDesc() {
		return proDesc;
	}
	public void setProDesc(String proDesc) {
		this.proDesc = proDesc;
	}
	public Timestamp getProDate() {
		return proDate;
	}
	public void setProDate(Timestamp proDate) {
		this.proDate = proDate;
	}

}
