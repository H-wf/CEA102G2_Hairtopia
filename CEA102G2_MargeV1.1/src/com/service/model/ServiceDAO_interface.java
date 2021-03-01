package com.service.model;

import java.util.List;

public interface ServiceDAO_interface {
	
	public void insert(ServiceVO serviceVO);
	
	public void update(ServiceVO serviceVO);
	public void updateSerStatus(ServiceVO serviceVO);	
	
	public void delete(Integer serNo);
	
	public ServiceVO findByPrimaryKeySerNo(Integer serNo);
	public List<ServiceVO> findByPrimaryKeyDesNo(Integer desNo);
	public List<ServiceVO> findByPrimaryKeyStypeNo(Integer stypeNo);
	
	public List<ServiceVO> getAll();

}
