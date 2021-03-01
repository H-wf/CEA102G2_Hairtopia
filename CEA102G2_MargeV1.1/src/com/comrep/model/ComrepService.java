package com.comrep.model;

import java.util.List;


public class ComrepService {
	ComrepDAO_Interface dao;
	
	public ComrepService() {
		dao = new ComrepDAO();
	}
	
	public ComrepVO addComrep(Integer comNo,Integer memNo, String crepCon) {
		ComrepVO comrepVo = new ComrepVO();
		
		comrepVo.setComNo(comNo);
		comrepVo.setMemNo(memNo);
		comrepVo.setCrepCon(crepCon);
		
		dao.insert(comrepVo);
		
		return comrepVo;
	}
	
	public List<ComrepVO> getAll() {
		return dao.getAll();
	}
}
