package com.brand.model;

public class BrandVO implements java.io.Serializable{
	private Integer braNo;
	private String braName;
	private byte[] braLogo;
	private String braIntro;
	
	public Integer getBraNo() {
		return braNo;
	}
	public void setBraNo(Integer braNo) {
		this.braNo = braNo;
	}
	public String getBraName() {
		return braName;
	}
	public void setBraName(String braName) {
		this.braName = braName;
	}
	public byte[] getBraLogo() {
		return braLogo;
	}
	public void setBraLogo(byte[] braLogo) {
		this.braLogo = braLogo;
	}
	public String getBraIntro() {
		return braIntro;
	}
	public void setBraIntro(String braIntro) {
		this.braIntro = braIntro;
	}
}
