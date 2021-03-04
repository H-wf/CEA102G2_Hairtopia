package com.staff.model;

import java.util.List;



public interface StaffDAO_interface {
	public void insert(StaffVO staVO);

	public void update(StaffVO staVO);

	public void delete(Integer staNo);

	public StaffVO findByPrimaryKey(Integer staNo);

	public List<StaffVO> getAll();
	
	public StaffVO validate(String staAcct, String staPswd);
	
}
