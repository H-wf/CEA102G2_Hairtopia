package com.authority.model;

import java.util.List;


public interface AuthorityDAO_interface {
	public void insert(AuthorityVO authVO);

	public void update(AuthorityVO authVO);

	public void delete(Integer staNo,Integer funcNo);
	
	public void delete(Integer staNo);

	public List<AuthorityVO> findByPrimaryKey(Integer staNo);
	
	public List<AuthorityVO>  findByPrimaryKey2(Integer funcNo);
	
	public List<AuthorityVO>  getAll();

	

}
