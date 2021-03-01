package com.reservation.model;

import java.util.List;

import com.reservation.model.ResVO;

public interface ResDAO_interface {
	
	public void insert(ResVO resVO);//
	
	public void update(ResVO resVO);
	public void updateConfirm(ResVO resVO);
	public void updateCancel(ResVO resVO);
	public void updateStatus(ResVO resVO);
	public void updateCom(ResVO resVO);
	
	public void delete(Integer resNo);
	
	public ResVO findByPrimaryKeyResNo(Integer resNo);
	public List<ResVO> findByPrimaryKeyDesNo(Integer desNo);
	public List<ResVO> findByPrimaryKeyMemNo(Integer memNo);
	public List<ResVO> getAll();

}
