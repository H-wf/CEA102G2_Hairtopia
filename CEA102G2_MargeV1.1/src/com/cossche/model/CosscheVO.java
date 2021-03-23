package com.cossche.model;

import java.sql.Timestamp;
import java.lang.String;

public class CosscheVO  implements java.io.Serializable{
	private Integer cosNo;
	private Integer cosStatus;

	public Integer getCosNo() {
		return cosNo;
	}

	public void setCosNo(Integer cosNo) {
		this.cosNo = cosNo;
	}

	public Integer getCosStatus() {
		return cosStatus;
	}

	public void setCosStatus(Integer cosStatus) {
		this.cosStatus = cosStatus;
	}
	
}