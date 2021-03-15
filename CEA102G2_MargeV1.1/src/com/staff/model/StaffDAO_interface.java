package com.staff.model;

import java.util.List;
import java.util.Set;

import com.authority.model.AuthorityVO;



public interface StaffDAO_interface {
	public Object insert(StaffVO staVO);

	public void update(StaffVO staVO);

	public void delete(Integer staNo);

	public StaffVO findByPrimaryKey(Integer staNo);
	
	public StaffVO findByAcctAndPwsd(String staAcct,String staPswd);

	public List<StaffVO> getAll();
	
//	 public Set<AuthorityVO> getAuthorByStaNo(Integer staNo);
	

}
