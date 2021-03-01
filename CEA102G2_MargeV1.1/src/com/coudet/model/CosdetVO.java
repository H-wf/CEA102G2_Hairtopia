package com.coudet.model;

import java.lang.String;

public class CosdetVO  implements java.io.Serializable{
	private Integer cosNo;
	private Integer memNo;
	private String cosComment;
	private Integer cosDetailPrice;
	/**
	 * @return the cosNo
	 */
	public Integer getCosNo() {
		return cosNo;
	}
	/**
	 * @param cosNo the cosNo to set
	 */
	public void setCosNo(Integer cosNo) {
		this.cosNo = cosNo;
	}
	/**
	 * @return the memNo
	 */
	public Integer getMemNo() {
		return memNo;
	}
	/**
	 * @param memNo the memNo to set
	 */
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	/**
	 * @return the cosComment
	 */
	public String getCosComment() {
		return cosComment;
	}
	/**
	 * @param cosComment the cosComment to set
	 */
	public void setCosComment(String cosComment) {
		this.cosComment = cosComment;
	}
	/**
	 * @return the cosDetailPrice
	 */
	public Integer getCosDetailPrice() {
		return cosDetailPrice;
	}
	/**
	 * @param cosDetailPrice the cosDetailPrice to set
	 */
	public void setCosDetailPrice(Integer cosDetailPrice) {
		this.cosDetailPrice = cosDetailPrice;
	}
	
}