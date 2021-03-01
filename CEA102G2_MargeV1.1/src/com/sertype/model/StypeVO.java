package com.sertype.model;

import java.io.Serializable;

public class StypeVO implements Serializable{
	
	private Integer stypeNo;
	private String stypeName;
	
	public StypeVO() {}

	public Integer getStypeNo() {
		return stypeNo;
	}

	public void setStypeNo(Integer stypeNo) {
		this.stypeNo = stypeNo;
	}

	public String getStypeName() {
		return stypeName;
	}

	public void setStypeName(String stypeName) {
		this.stypeName = stypeName;
	};
	
	

}
