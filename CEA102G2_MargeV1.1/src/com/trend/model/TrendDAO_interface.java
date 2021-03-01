package com.trend.model;

import java.util.List;



public interface TrendDAO_interface {
	public void insert(TrendVO treVO);

	public void update(TrendVO treVO);

	public void delete(Integer treNo);

	public TrendVO findByPrimaryKey(Integer treNo);

	public List<TrendVO> getAll();
	
	

}
