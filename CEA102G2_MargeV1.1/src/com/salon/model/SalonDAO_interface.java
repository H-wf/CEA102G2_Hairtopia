package com.salon.model;

import java.util.List;

import com.designer.model.DesignerVO;

public interface SalonDAO_interface {
	
	public void insert(SalonVO salonVO);
	public void update(SalonVO salonVO);
	public void delete(Integer salNo);
	public SalonVO findByPrimaryKey(Integer salNo);
	public List<SalonVO> getAll();
	public void insertWithDes(SalonVO salonVO, List<DesignerVO> list);
	public List<SalonVO> getAllByAjax(String keyword);
	public SalonVO findBySalName(String salName);
 
}
