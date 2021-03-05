package com.designer.model;

import java.util.List;


public interface DesignerDAO_interface {

	public void insert(DesignerVO designerVO);
	
	public void update(DesignerVO designerVO);
	public void updateWithoutPic(DesignerVO designerVO);
	public void updateOneStatus(DesignerVO designerVO);
	public void updateScore(DesignerVO designerVO);
	
	public void delete(Integer desNo);
	
	
	public DesignerVO findByMemNo(Integer memNo);
	public DesignerVO findByDesNo(Integer desNo);
	public List<DesignerVO> getAll();
	

}
