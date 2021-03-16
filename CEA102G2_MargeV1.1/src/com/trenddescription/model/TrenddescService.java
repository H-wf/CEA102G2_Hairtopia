package com.trenddescription.model;

import java.util.List;
import java.util.Set;

public class TrenddescService {
	TrenddescDAO_interface dao;
	
	public TrenddescService() {
		dao = new TrenddescDAO();
	}
	
	
	public TrenddescVO addTrenddesc(Integer treNo,Integer postNo) {
		TrenddescVO trenddescVo = new TrenddescVO();
		
		trenddescVo.setTreNo(treNo);
		trenddescVo.setPostNo(postNo);
		
		dao.insert(trenddescVo);
		
		return trenddescVo;
	}
	
	public TrenddescVO addTrenddesc(TrenddescVO trenddescVo) {
		dao.insert(trenddescVo);
		return trenddescVo;
	}
	
	public List<TrenddescVO> getAll() {
		return dao.getAll();
	}
	
	public Set<Integer> getTreNo(Integer postNo){
		return dao.findByPostNo(postNo);
	}

}
