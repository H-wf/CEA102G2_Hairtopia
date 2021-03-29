package com.coutype.model;

import java.lang.String;

public class CostypeVO  implements java.io.Serializable{
	private Integer cosTypeNo;
	private String cosTypeName;
	private String cosTypeIntro;
//	chatBox會來找這個參數發生衝突不知道為什麼，所以加這個
	private String chatText ;

	
	
	public String getChatText() {
		return chatText;
	}

	public void setChatText(String chatText) {
		this.chatText = chatText;
	}
//end chatText
	/**
	 * @return the cosTypeNo
	 */
	public Integer getCosTypeNo() {
		return cosTypeNo;
	}
	/**
	 * @param cosTypeNo the cosTypeNo to set
	 */
	public void setCosTypeNo(Integer cosTypeNo) {
		this.cosTypeNo = cosTypeNo;
	}
	/**
	 * @return the cosTypeName
	 */
	public String getCosTypeName() {
		return cosTypeName;
	}
	/**
	 * @param cosTypeName the cosTypeName to set
	 */
	public void setCosTypeName(String cosTypeName) {
		this.cosTypeName = cosTypeName;
	}
	/**
	 * @return the cosTypeIntro
	 */
	public String getCosTypeIntro() {
		return cosTypeIntro;
	}
	/**
	 * @param cosTypeIntro the cosTypeIntro to set
	 */
	public void setCosTypeIntro(String cosTypeIntro) {
		this.cosTypeIntro = cosTypeIntro;
	}
	
}
	