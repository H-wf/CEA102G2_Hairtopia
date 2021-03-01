package com.func.model;

import java.util.List;

public class FuncService {
	private FuncDAO_interface dao;
	
	
	public FuncService() {
		dao = new FuncDAO();
	}
	
	
	public FuncVO addFunc(String funcName) {
		FuncVO funcVO = new FuncVO();

		funcVO.setFuncName(funcName);
		

		dao.insert(funcVO);

		return funcVO;

	}
	
	public FuncVO updateFunc(Integer funcNo, String funcName) {
		FuncVO funcVO = new FuncVO();

		funcVO.setFuncNo(funcNo);
		funcVO.setFuncName(funcName);
	

		dao.update(funcVO);

		return funcVO;
	}
	
	public void deleteFunc(Integer funcNo) {
		dao.delete(funcNo);
	}

	public FuncVO getOneFunc(Integer funcNo) {
		return dao.findByPrimaryKey(funcNo);
	}

	public List<FuncVO> getAll() {

		return dao.getAll();
	}

}
