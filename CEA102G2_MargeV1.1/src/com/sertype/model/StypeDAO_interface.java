package com.sertype.model;

import java.util.List;

import com.sertype.model.StypeVO;

public interface StypeDAO_interface {
	
	public void insert(StypeVO stypeVO);
	public void update(StypeVO stypeVO);
	public void delete(Integer stypeNo);
	public StypeVO findByPrimaryKey(Integer stypeNo);
	public List<StypeVO> getAll();

}
