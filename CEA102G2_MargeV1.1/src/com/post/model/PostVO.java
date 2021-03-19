package com.post.model;

import java.util.Arrays;

public class PostVO implements java.io.Serializable{
	private Integer postNo;
	private Integer desNo;
	private String postCon;
	private byte[] postPic1;
	private byte[] postPic2;
	private byte[] postPic3;
	private java.sql.Timestamp postTime;
	private Integer postStatus;	//
	private boolean postPror;
	private String desName;
	
	public Integer getPostNo() {
		return postNo;
	}
	public void setPostNo(Integer postNo) {
		this.postNo = postNo;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((desName == null) ? 0 : desName.hashCode());
		result = prime * result + ((desNo == null) ? 0 : desNo.hashCode());
		result = prime * result + ((postCon == null) ? 0 : postCon.hashCode());
		result = prime * result + ((postNo == null) ? 0 : postNo.hashCode());
		result = prime * result + Arrays.hashCode(postPic1);
		result = prime * result + Arrays.hashCode(postPic2);
		result = prime * result + Arrays.hashCode(postPic3);
		result = prime * result + (postPror ? 1231 : 1237);
		result = prime * result + ((postStatus == null) ? 0 : postStatus.hashCode());
		result = prime * result + ((postTime == null) ? 0 : postTime.hashCode());
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
		PostVO other = (PostVO) obj;
		if (desName == null) {
			if (other.desName != null)
				return false;
		} else if (!desName.equals(other.desName))
			return false;
		if (desNo == null) {
			if (other.desNo != null)
				return false;
		} else if (!desNo.equals(other.desNo))
			return false;
		if (postCon == null) {
			if (other.postCon != null)
				return false;
		} else if (!postCon.equals(other.postCon))
			return false;
		if (postNo == null) {
			if (other.postNo != null)
				return false;
		} else if (!postNo.equals(other.postNo))
			return false;
		if (!Arrays.equals(postPic1, other.postPic1))
			return false;
		if (!Arrays.equals(postPic2, other.postPic2))
			return false;
		if (!Arrays.equals(postPic3, other.postPic3))
			return false;
		if (postPror != other.postPror)
			return false;
		if (postStatus == null) {
			if (other.postStatus != null)
				return false;
		} else if (!postStatus.equals(other.postStatus))
			return false;
		if (postTime == null) {
			if (other.postTime != null)
				return false;
		} else if (!postTime.equals(other.postTime))
			return false;
		return true;
	}
	public Integer getDesNo() {
		return desNo;
	}
	public void setDesNo(Integer desNo) {
		this.desNo = desNo;
	}
	public String getPostCon() {
		return postCon;
	}
	public void setPostCon(String postCon) {
		this.postCon = postCon;
	}
	public byte[] getPostPic1() {
		return postPic1;
	}
	public void setPostPic1(byte[] postPic1) {
		this.postPic1 = postPic1;
	}
	public byte[] getPostPic2() {
		return postPic2;
	}
	public void setPostPic2(byte[] postPic2) {
		this.postPic2 = postPic2;
	}
	public byte[] getPostPic3() {
		return postPic3;
	}
	public void setPostPic3(byte[] postPic3) {
		this.postPic3 = postPic3;
	}
	public java.sql.Timestamp getPostTime() {
		return postTime;
	}
	public void setPostTime(java.sql.Timestamp postTime) {
		this.postTime = postTime;
	}
	public Integer getPostStatus() {
		return postStatus;
	}
	public void setPostStatus(Integer postStatus) {
		this.postStatus = postStatus;
	}
	public boolean isPostPror() {
		return postPror;
	}
	public void setPostPror(boolean postPror) {
		this.postPror = postPror;
	}
	public String getDesName() {
		return desName;
	}
	public void setDesName(String desName) {
		this.desName = desName;
	}
	
	
}
