package com.salon.model;

import java.util.List;

public interface SalonDAO_interface {
	
	public void insert(SalonVO salonVO);
	public void update(SalonVO salonVO);
	public void delete(Integer salNo);
	public SalonVO findByPrimaryKey(Integer salNo);
	public List<SalonVO> getAll();
	public List<String> getSalAJAX(String keyword);
 
}
