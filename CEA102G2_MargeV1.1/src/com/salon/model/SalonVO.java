package com.salon.model;

import java.io.Serializable;

public class SalonVO implements Serializable{
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((salAdd == null) ? 0 : salAdd.hashCode());
		result = prime * result + ((salLat == null) ? 0 : salLat.hashCode());
		result = prime * result + ((salLng == null) ? 0 : salLng.hashCode());
		result = prime * result + ((salName == null) ? 0 : salName.hashCode());
		result = prime * result + ((salNo == null) ? 0 : salNo.hashCode());
		result = prime * result + ((salPhone == null) ? 0 : salPhone.hashCode());
		result = prime * result + ((salStatus == null) ? 0 : salStatus.hashCode());
		result = prime * result + ((salTime == null) ? 0 : salTime.hashCode());
		return result;
	}
	//index需要複寫 0320
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SalonVO other = (SalonVO) obj;
		if (salAdd == null) {
			if (other.salAdd != null)
				return false;
		} else if (!salAdd.equals(other.salAdd))
			return false;
		if (salLat == null) {
			if (other.salLat != null)
				return false;
		} else if (!salLat.equals(other.salLat))
			return false;
		if (salLng == null) {
			if (other.salLng != null)
				return false;
		} else if (!salLng.equals(other.salLng))
			return false;
		if (salName == null) {
			if (other.salName != null)
				return false;
		} else if (!salName.equals(other.salName))
			return false;
		if (salNo == null) {
			if (other.salNo != null)
				return false;
		} else if (!salNo.equals(other.salNo))
			return false;
		if (salPhone == null) {
			if (other.salPhone != null)
				return false;
		} else if (!salPhone.equals(other.salPhone))
			return false;
		if (salStatus == null) {
			if (other.salStatus != null)
				return false;
		} else if (!salStatus.equals(other.salStatus))
			return false;
		if (salTime == null) {
			if (other.salTime != null)
				return false;
		} else if (!salTime.equals(other.salTime))
			return false;
		return true;
	}
	private Integer salNo;
	private String salName;
	private String salAdd;
	private String salTime;
	private String salPhone;
	private Integer salStatus;
	private String  salLat;
	private String  salLng;
	
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
	}

	
	public String getSalLat() {
		return salLat;
	}
	
	public void setSalLat(String salLat) {
		this.salLat = salLat;
	}
	
	public String getSalLng() {
		return salLng;
	}
	public void setSalLng(String salLng) {
		this.salLng = salLng;
	}
	
	
	
}

	