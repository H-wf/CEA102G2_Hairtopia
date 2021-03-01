package com.func.model;

import java.util.List;

public interface FuncDAO_interface {
	public void insert(FuncVO funcVO);

	public void update(FuncVO funcVO);

	public void delete(Integer funcNo);

	public FuncVO findByPrimaryKey(Integer funcNo);

	public List<FuncVO> getAll();
	

}
