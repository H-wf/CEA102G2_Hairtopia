package com.designer.model;

import java.io.Serializable;
import java.sql.Date;

public class DesignerVO implements Serializable{
	
	private Integer desNo;
	private Integer memNo;
	private Integer salNo;
	private String desName;
	private String desInfor;
	private Date desEndDate;
	private Integer desCount;
	private Integer desTolScore;
	private Integer desStatus;
	private String desSchedule;
	private byte[] desPic;
	
	public DesignerVO() {};
	
	public Integer getDesNo() {
		return desNo;
	}
	public void setDesNo(Integer desNo) {
		this.desNo = desNo;
	}
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	public Integer getSalNo() {
		return salNo;
	}
	public void setSalNo(Integer salNo) {
		this.salNo = salNo;
	}
	public String getDesInfor() {
		return desInfor;
	}
	public void setDesInfor(String desInfor) {
		this.desInfor = desInfor;
	}
	public Date getDesEndDate() {
		return desEndDate;
	}
	public void setDesEndDate(Date desEndDate) {
		this.desEndDate = desEndDate;
	}
	public Integer getDesCount() {
		return desCount;
	}
	public void setDesCount(Integer desCount) {
		this.desCount = desCount;
	}
	public Integer getDesTolScore() {
		return desTolScore;
	}
	public void setDesTolScore(Integer desTolScore) {
		this.desTolScore = desTolScore;
	}
	public Integer getDesStatus() {
		return desStatus;
	}
	public void setDesStatus(Integer desStatus) {
		this.desStatus = desStatus;
	}
	public String getDesSchedule() {
		return desSchedule;
	}
	public void setDesSchedule(String desSchedule) {
		this.desSchedule = desSchedule;
	}
	public byte[] getDesPic() {
		return desPic;
	}
	public void setDesPic(byte[] desPic) {
		this.desPic = desPic;
	}
	public String getDesName() {
		return desName;
	}
	public void setDesName(String desName) {
		this.desName = desName;
	}
	
	

}
