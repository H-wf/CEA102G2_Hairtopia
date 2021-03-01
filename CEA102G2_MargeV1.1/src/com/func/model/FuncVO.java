package com.func.model;

public class FuncVO implements java.io.Serializable{
	private Integer funcNo;
	private String  funcName;
	
	public FuncVO () {}
	public Integer getFuncNo() {
		return funcNo;
	}
	public void setFuncNo(Integer funcNo) {
		this.funcNo = funcNo;
	}
	public String getFuncName() {
		return funcName;
	}
	public void setFuncName(String funcName) {
		this.funcName = funcName;
	}
	
	

}
