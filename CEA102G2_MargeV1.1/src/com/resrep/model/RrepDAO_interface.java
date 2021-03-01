package com.resrep.model;

import java.util.List;

public interface RrepDAO_interface {
	
	public void insert(RrepVO rrepVO);
	public void update(RrepVO rrepVO);
	public void updateStatus(RrepVO rrepVO);	
	public void delete(Integer rrepNo);
	public RrepVO findByPrimaryKey(Integer rrepNo);
	public List<RrepVO> getAll();

}
