package com.trenddescription.model;

import java.util.List;



public interface TrenddescDAO_interface {
	
	public void insert(TrenddescVO tredVO);

	public void update(TrenddescVO tredVO);

	public void delete(Integer treNo,Integer postNo);
	
	public void delete(Integer treNo);

	public List<TrenddescVO> findByPrimaryKey(Integer treNo);
	
	public List<TrenddescVO>  findByPrimaryKey2(Integer postNo);
	
	public List<TrenddescVO>  getAll();

}
