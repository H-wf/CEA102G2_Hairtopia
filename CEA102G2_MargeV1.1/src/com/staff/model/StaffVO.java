package com.staff.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.authority.model.AuthorityVO;

@Entity 
@Table(name = "staff")
public class StaffVO implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer staNo;
	private String  staAcct;
	private String  staPswd;
	private String  staName;


	public StaffVO () {}
	
	@Id 
	@Column(name = "staNo")
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	public Integer getStaNo() {
		return staNo;
	}
	public void setStaNo(Integer staNo) {
		this.staNo = staNo;
	}
	
	@Column(name = "staAcct")
	public String getStaAcct() {
		return staAcct;
	}
	public void setStaAcct(String staAcct) {
		this.staAcct = staAcct;
	}
	
	@Column(name = "staPswd")
	public String getStaPswd() {
		return staPswd;
	}
	public void setStaPswd(String staPswd) {
		this.staPswd = staPswd;
	}
	@Column(name = "staName")
	public String getStaName() {
		return staName;
	}
	public void setStaName(String staName) {
		this.staName = staName;
	}
	

	

	
	
}
