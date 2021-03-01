package com.news.model;

import java.io.Serializable;

public class NewsVO implements Serializable{
	private Integer newsNo;

	private java.sql.Date newsTime;
	private String newsTitle;
	private String newsCon;
	private byte[] newsPic;

	public NewsVO() {
	}

	public Integer getNewsNo() {
		return newsNo;
	}

	public void setNewsNo(Integer newsNo) {
		this.newsNo = newsNo;
	}

	public java.sql.Date getNewsTime() {
		return newsTime;
	}

	public void setNewsTime(java.sql.Date newsTime) {
		this.newsTime = newsTime;
	}

	public String getNewsTitle() {
		return newsTitle;
	}

	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}

	public String getNewsCon() {
		return newsCon;
	}

	public void setNewsCon(String newsCon) {
		this.newsCon = newsCon;
	}

	public byte[] getNewsPic() {
		return newsPic;
	}

	public void setNewsPic(byte[] newsPic) {
		this.newsPic = newsPic;
	}
	
	
}
