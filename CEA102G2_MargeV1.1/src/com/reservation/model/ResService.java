package com.reservation.model;

import java.util.List;

import com.service.model.ServiceVO;

public class ResService {

	private ResDAO_interface dao;
	
	public ResService() {
		dao = new ResDAO();
	}
	
	public ResVO addRes(Integer memNo, Integer serNo, Integer desNo, java.sql.Date resDate,
			Integer resTime, Integer resPrice) {

		ResVO resVO = new ResVO();

		resVO.setMemNo(memNo);
		resVO.setSerNo(serNo);
		resVO.setDesNo(desNo);
		resVO.setResDate(resDate);
		resVO.setResTime(resTime);
		resVO.setResPrice(resPrice);
		dao.insert(resVO);

		return resVO;
	}
	
	
	public ResVO updateResCom(Integer resCom, Integer resNo) {

		ResVO resVO = new ResVO();

		resVO.setResCom(resCom);
		resVO.setResNo(resNo);
		
		dao.updateCom(resVO);

		return dao.findByPrimaryKeyResNo(resNo);
	}
	
	public ResVO updateResConfirm(Integer resStatus, String resCode, Integer resNo) {
		
		ResVO resVO = new ResVO();
		
		resVO.setResStatus(resStatus);
		resVO.setResCode(resCode);
		resVO.setResNo(resNo);
		
		dao.updateConfirm(resVO);
		
		return dao.findByPrimaryKeyResNo(resNo);
	}
	
	public ResVO updateResStatus(Integer resStatus, Integer resNo) {
		
		ResVO resVO = new ResVO();
		
		resVO.setResStatus(resStatus);
		resVO.setResNo(resNo);
		
		dao.updateStatus(resVO);
		
		return dao.findByPrimaryKeyResNo(resNo);
	}
	
	public void deleteRes(Integer resNo) {
		dao.delete(resNo);
	}

	public ResVO getOneRes(Integer resNo) {
		return dao.findByPrimaryKeyResNo(resNo);
	}
	
	public List<ResVO> getAllResByDesNo(Integer desNo) {
		return dao.findByPrimaryKeyDesNo(desNo);
	}
	
	public List<ResVO> getAllResByMemNo(Integer memNo) {
		return dao.findByPrimaryKeyMemNo(memNo);
	}

	public List<ResVO> getAll() {
		return dao.getAll();
	}
}
