package com.resrep.model;

import java.sql.Date;
import java.util.List;

import com.resrep.model.RrepVO;

public class RrepService {

private RrepDAO_interface dao;
	
	public RrepService() {
		dao = new RrepDAO();
	}
	
	public RrepVO addRrep(Integer resNo, Integer desNo, String rrepCon, Date rrepTime,
			Integer rrepStatus) {

		RrepVO rrepVO = new RrepVO();

		rrepVO.setResNo(resNo);
		rrepVO.setDesNo(desNo);
		rrepVO.setRrepCon(rrepCon);
		rrepVO.setRrepTime(rrepTime);
		rrepVO.setRrepStatus(rrepStatus);
		dao.insert(rrepVO);

		return rrepVO;
	}
	
	public RrepVO updateRrep(String rrepCon, Integer rrepNo) {

		RrepVO rrepVO = new RrepVO();
		
		rrepVO.setRrepCon(rrepCon);
		rrepVO.setRrepNo(rrepNo);
		dao.update(rrepVO);

		return rrepVO;
	}
	
	public RrepVO updateRrepStatus(Integer rrepStatus, Integer rrepNo) {
		
		RrepVO rrepVO = new RrepVO();
		
		rrepVO.setRrepStatus(rrepStatus);
		rrepVO.setRrepNo(rrepNo);
		dao.update(rrepVO);
		
		return rrepVO;
	}
	
	public void deleteRrep(Integer rrepNo) {
		dao.delete(rrepNo);
	}

	public RrepVO getOneRrep(Integer rrepNo) {
		return dao.findByPrimaryKey(rrepNo);
	}

	public List<RrepVO> getAll() {
		return dao.getAll();
	}

}
	

