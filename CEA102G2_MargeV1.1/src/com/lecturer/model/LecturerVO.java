package com.lecturer.model;

public class LecturerVO implements java.io.Serializable {
	private Integer lecNo;
	private String lecName;
	private byte[] lecPic;
	private String lecIntro ;
	private Integer lecStatus ;
	private Integer staNo;

	
	public LecturerVO () {}


	public Integer getLecNo() {
		return lecNo;
	}


	public void setLecNo(Integer lecNo) {
		this.lecNo = lecNo;
	}


	public String getLecName() {
		return lecName;
	}


	public void setLecName(String lecName) {
		this.lecName = lecName;
	}


	public byte[] getLecPic() {
		return lecPic;
	}


	public void setLecPic(byte[] lecPic) {
		this.lecPic = lecPic;
	}


	public String getLecIntro() {
		return lecIntro;
	}


	public void setLecIntro(String lecIntro) {
		this.lecIntro = lecIntro;
	}


	public Integer getLecStatus() {
		return lecStatus;
	}


	public void setLecStatus(Integer lecStatus) {
		this.lecStatus = lecStatus;
	}


	public Integer getStaNo() {
		return staNo;
	}


	public void setStaNo(Integer staNo) {
		this.staNo = staNo;
	}
	

}
