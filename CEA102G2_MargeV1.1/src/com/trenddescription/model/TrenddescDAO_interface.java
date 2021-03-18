package com.trenddescription.model;

import java.util.List;
import java.util.Set;



public interface TrenddescDAO_interface {
	
	public void insert(TrenddescVO tredVO);

	public void update(TrenddescVO tredVO);

	public void delete(Integer treNo);
	
	public Set<Integer> findByPostNo(Integer postNo);

	public List<TrenddescVO>  getAll();

}
