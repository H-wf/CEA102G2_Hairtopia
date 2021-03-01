package com.cospost.model;
import java.sql.Timestamp;

public class CospostVO implements java.io.Serializable{
		private Integer cosPubNo;
		private Integer cosNo;
		private String cosPubCon;
		private Timestamp cosPubTime;
		
		public Integer getCosPubNo() {
			return cosPubNo;
		}
		public void setCosPubNo(Integer cosPubNo) {
			this.cosPubNo = cosPubNo;
		}
		public Integer getCosNo() {
			return cosNo;
		}
		public void setCosNo(Integer cosNo) {
			this.cosNo = cosNo;
		}
		public String getCosPubCon() {
			return cosPubCon;
		}
		public void setCosPubCon(String cosPubCon) {
			this.cosPubCon = cosPubCon;
		}
		public Timestamp getCosPubTime() {
			return cosPubTime;
		}
		public void setCosPubTime(Timestamp cosPubTime) {
			this.cosPubTime = cosPubTime;
		}
		
		
	}

