package com.coudet.model;

import java.lang.String;

public class CosdetVO  implements java.io.Serializable{
	private Integer cosNo;
	private Integer memNo;
	private Integer cosComment;
	private Integer cosDetailPrice;
//	chatBox會來找這個參數發生衝突不知道為什麼，所以加這個
	private String chatText ;

	
	
	public String getChatText() {
		return chatText;
	}

	public void setChatText(String chatText) {
		this.chatText = chatText;
	}
//end chatText

	public Integer getCosNo() {
		return cosNo;
	}

	public void setCosNo(Integer cosNo) {
		this.cosNo = cosNo;
	}

	public Integer getMemNo() {
		return memNo;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((cosComment == null) ? 0 : cosComment.hashCode());
		result = prime * result + ((cosDetailPrice == null) ? 0 : cosDetailPrice.hashCode());
		result = prime * result + ((cosNo == null) ? 0 : cosNo.hashCode());
		result = prime * result + ((memNo == null) ? 0 : memNo.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CosdetVO other = (CosdetVO) obj;
		if (cosComment == null) {
			if (other.cosComment != null)
				return false;
		} else if (!cosComment.equals(other.cosComment))
			return false;
		if (cosDetailPrice == null) {
			if (other.cosDetailPrice != null)
				return false;
		} else if (!cosDetailPrice.equals(other.cosDetailPrice))
			return false;
		if (cosNo == null) {
			if (other.cosNo != null)
				return false;
		} else if (!cosNo.equals(other.cosNo))
			return false;
		if (memNo == null) {
			if (other.memNo != null)
				return false;
		} else if (!memNo.equals(other.memNo))
			return false;
		return true;
	}

	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}

	public Integer getCosDetailPrice() {
		return cosDetailPrice;
	}

	public void setCosDetailPrice(Integer cosDetailPrice) {
		this.cosDetailPrice = cosDetailPrice;
	}
	
	public Integer getCosComment() {
		return cosComment;
	}

	public void setCosComment(Integer cosComment) {
		this.cosComment = cosComment;
	}
}