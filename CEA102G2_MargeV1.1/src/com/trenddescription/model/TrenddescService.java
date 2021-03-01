package com.trenddescription.model;

import java.util.List;



public class TrenddescService {
private TrenddescDAO_interface dao;
	
	
	public TrenddescService() {
		dao = new TrenddescDAO();
	}
	
	
	public TrenddescVO addTrenddesc(Integer treNo,Integer postNo) {
		TrenddescVO tredVO = new TrenddescVO();

		tredVO.setTreNo(treNo);
		tredVO.setPostNo(postNo);
		

		dao.insert(tredVO);

		return tredVO;

	}
	
	public void deleteTrenddesc(Integer treNo) {
		dao.delete(treNo);
	}
	
	public void deleteTrenddesc(Integer treNo,Integer postNo) {
		dao.delete(treNo,postNo);
	}
	
	public List<TrenddescVO> getAllByTreNo(Integer treNo) {

		return dao.findByPrimaryKey(treNo);
	}
	
	public List<TrenddescVO> getAllByPostNo(Integer postNo) {

		return dao.findByPrimaryKey2(postNo);
	}
	public List<TrenddescVO> getAll() {

		return dao.getAll();
	}
	

}
