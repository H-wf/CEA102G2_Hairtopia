package com.cos.model;

import java.sql.Timestamp;
import java.lang.String;

public class CosVO implements java.io.Serializable{
	private Integer cosNo;
	private Integer lecNo;
	private Integer cosTypeNo;
	private Timestamp cosFrom;
	private Timestamp cosTo;
	private String cosIntro;
	private byte[] cosPic;
	private String cosAdd;
	private Integer cosCount;
	private Integer cosRate;
	private boolean cosStatus;
	private Integer cosMinCount;
	private Integer cosMaxCount;
	private Integer cosPrice;
	private Timestamp cosApplyFrom;
	private Timestamp cosApplyTo;
	private String cosName;
	
	
	private String lecName;
	private byte[] lecPic;
	private String lecIntro ;
	private Integer lecStatus ;
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
	 * @return the lecName
	 */
	public String getLecName() {
		return lecName;
	}

	/**
	 * @param lecName the lecName to set
	 */
	public void setLecName(String lecName) {
		this.lecName = lecName;
	}

	/**
	 * @return the lecPic
	 */
	public byte[] getLecPic() {
		return lecPic;
	}

	/**
	 * @param lecPic the lecPic to set
	 */
	public void setLecPic(byte[] lecPic) {
		this.lecPic = lecPic;
	}

	/**
	 * @return the lecIntro
	 */
	public String getLecIntro() {
		return lecIntro;
	}

	/**
	 * @param lecIntro the lecIntro to set
	 */
	public void setLecIntro(String lecIntro) {
		this.lecIntro = lecIntro;
	}

	/**
	 * @return the lecStatus
	 */
	public Integer getLecStatus() {
		return lecStatus;
	}

	/**
	 * @param lecStatus the lecStatus to set
	 */
	public void setLecStatus(Integer lecStatus) {
		this.lecStatus = lecStatus;
	}

	public Integer getCosNo() {
		return cosNo;
	}

	public void setCosNo(Integer cosNo) {
		this.cosNo = cosNo;
	}

	public Integer getLecNo() {
		return lecNo;
	}

	public void setLecNo(Integer lecNo) {
		this.lecNo = lecNo;
	}

	public Integer getCosTypeNo() {
		return cosTypeNo;
	}

	public void setCosTypeNo(Integer cosTypeNo) {
		this.cosTypeNo = cosTypeNo;
	}

	public Timestamp getCosFrom() {
		return cosFrom;
	}

	public void setCosFrom(Timestamp cosFrom) {
		this.cosFrom = cosFrom;
	}

	public Timestamp getCosTo() {
		return cosTo;
	}

	public void setCosTo(Timestamp cosTo) {
		this.cosTo = cosTo;
	}

	public String getCosIntro() {
		return cosIntro;
	}

	public void setCosIntro(String cosIntro) {
		this.cosIntro = cosIntro;
	}

	public byte[] getCosPic() {
		return cosPic;
	}

	public void setCosPic(byte[] cosPic) {
		this.cosPic = cosPic;
	}

	public String getCosAdd() {
		return cosAdd;
	}

	public void setCosAdd(String cosAdd) {
		this.cosAdd = cosAdd;
	}

	public Integer getCosCount() {
		return cosCount;
	}

	public void setCosCount(Integer cosCount) {
		this.cosCount = cosCount;
	}

	public Integer getCosRate() {
		return cosRate;
	}

	public void setCosRate(Integer cosRate) {
		this.cosRate = cosRate;
	}

	public boolean isCosStatus() {
		return cosStatus;
	}

	public void setCosStatus(boolean cosStatus) {
		this.cosStatus = cosStatus;
	}

	public Integer getCosMinCount() {
		return cosMinCount;
	}

	public void setCosMinCount(Integer cosMinCount) {
		this.cosMinCount = cosMinCount;
	}

	public Integer getCosMaxCount() {
		return cosMaxCount;
	}

	public void setCosMaxCount(Integer cosMaxCount) {
		this.cosMaxCount = cosMaxCount;
	}

	public Integer getCosPrice() {
		return cosPrice;
	}

	public void setCosPrice(Integer cosPrice) {
		this.cosPrice = cosPrice;
	}

	public Timestamp getCosApplyFrom() {
		return cosApplyFrom;
	}

	public void setCosApplyFrom(Timestamp cosApplyFrom) {
		this.cosApplyFrom = cosApplyFrom;
	}

	public Timestamp getCosApplyTo() {
		return cosApplyTo;
	}

	public void setCosApplyTo(Timestamp cosApplyTo) {
		this.cosApplyTo = cosApplyTo;
	}

	public String getCosName() {
		return cosName;
	}

	public void setCosName(String cosName) {
		this.cosName = cosName;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
