package com.func.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity 
@Table(name = "func")
public class FuncVO implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer funcNo;
	private String  funcName;
	
	public FuncVO () {}
	
	
	
	@Id 
	@Column(name = "funcNo")
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	public Integer getFuncNo() {
		return funcNo;
	}
	public void setFuncNo(Integer funcNo) {
		this.funcNo = funcNo;
	}
	
	@Column(name = "funcName")
	public String getFuncName() {
		return funcName;
	}
	public void setFuncName(String funcName) {
		this.funcName = funcName;
	}
	
	

}
