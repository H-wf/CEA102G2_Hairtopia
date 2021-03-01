package com.transactionRecord.model;

import java.util.List;

public class TransRecService {
	private TransRecDAO_interface dao;
	
	public TransRecService() {
		dao = new TransRecDAO();
	}
	
	public TransRecVO addTransRec(Integer memNo, Integer traDes, Integer traPri, Integer traBal) {
		TransRecVO transRecVO = new TransRecVO();
		
		transRecVO.setMemNo(memNo);
		transRecVO.setTraDes(traDes);
		transRecVO.setTraPri(traPri);
		transRecVO.setTraBal(traBal);;
		
		dao.insert(transRecVO);
		
		return transRecVO;
	}
	
	public TransRecVO updateTransRec(Integer traNo, Integer memNo, Integer traDes, Integer traPri, Integer traBal) {
		
		TransRecVO transRecVO = new TransRecVO();
		transRecVO.setTraNo(traNo);
		transRecVO.setMemNo(memNo);
		transRecVO.setTraDes(traDes);
		transRecVO.setTraPri(traPri);
		transRecVO.setTraBal(traBal);
		
		dao.update(transRecVO);
		
		return transRecVO;
	}
	
	public void deleteTransRec(Integer traNo) {
		dao.delete(traNo);
	}
	
	public TransRecVO getOneTransRec(Integer traNo) {
		return dao.findByPrimaryKey(traNo);
	}
	
	public List<TransRecVO> getAll() {
		return dao.getAll();
	}
}
