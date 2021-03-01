package com.sertype.model;

import java.sql.Date;
import java.util.List;

import com.sertype.model.StypeVO;

public class StypeService {
	
private StypeDAO_interface dao;
	
	public StypeService() {
		dao = new StypeDAO();
	}
	
	public StypeVO addStype(String stypeName) {

		StypeVO stypeVO = new StypeVO();

		stypeVO.setStypeName(stypeName);
		dao.insert(stypeVO);

		return stypeVO;
	}
	
	public StypeVO updateStype(Integer stypeNo,String stypeName) {

		StypeVO stypeVO = new StypeVO();
		
		stypeVO.setStypeName(stypeName);
		stypeVO.setStypeNo(stypeNo);
		dao.update(stypeVO);

		return stypeVO;
	}
	
	public void deleteStype(Integer stypeNo) {
		dao.delete(stypeNo);
	}

	public StypeVO getOneStype(Integer stypeNo) {
		return dao.findByPrimaryKey(stypeNo);
	}

	public List<StypeVO> getAll() {
		return dao.getAll();
	}

}
