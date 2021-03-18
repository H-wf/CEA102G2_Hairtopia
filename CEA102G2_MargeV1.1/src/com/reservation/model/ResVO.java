package com.reservation.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

import com.member.model.MemService;
import com.service.model.ServiceService;

public class ResVO implements Serializable{
	
	private Integer resNo;
	private Integer memNo;
	private Integer serNo;
	private Integer desNo;	
	private Timestamp resProDate;
	private Date resDate;
	private Integer resTime;
	private Integer resStatus;
	private Integer resCom;
	private String resCode;
	private Integer resPrice;
	
	public ResVO() {
	}

	public Integer getResNo() {
		return resNo;
	}

	public void setResNo(Integer resNo) {
		this.resNo = resNo;
	}

	public Integer getMemNo() {
		return memNo;
	}

	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
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

	public Timestamp getResProDate() {
		return resProDate;
	}

	public void setResProDate(Timestamp resProDate) {
		this.resProDate = resProDate;
	}

	public Date getResDate() {
		return resDate;
	}

	public void setResDate(Date resDate) {
		this.resDate = resDate;
	}

	public Integer getResTime() {
		return resTime;
	}

	public void setResTime(Integer resTime) {
		this.resTime = resTime;
	}

	public Integer getResStatus() {
		return resStatus;
	}

	public void setResStatus(Integer resStatus) {
		this.resStatus = resStatus;
	}

	public Integer getResCom() {
		return resCom;
	}

	public void setResCom(Integer resCom) {
		this.resCom = resCom;
	}

	public String getResCode() {
		return resCode;
	}

	public void setResCode(String resCode) {
		this.resCode = resCode;
	}

	public Integer getResPrice() {
		return resPrice;
	}

	public void setResPrice(Integer resPrice) {
		this.resPrice = resPrice;
	}

	public String getMemName() {
		return new MemService().getOneMemName(memNo);
	}

	public String getSerName() {
		return new ServiceService().getSerName(serNo);
	}
	
	public Integer getSerTime() {
		return new ServiceService().getSerTime(serNo);
	}
	

}
