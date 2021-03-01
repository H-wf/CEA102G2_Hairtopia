package com.authority.model;

import java.util.List;



public class AuthorityService {
	private AuthorityDAO_interface dao;
	
	
	public AuthorityService() {
		dao = new AuthorityDAO();
	}
	
	public AuthorityVO addAuthority(Integer staNo,Integer funcNo) {
		AuthorityVO authVO = new AuthorityVO();

		authVO.setStaNo(staNo);
		authVO.setFuncNo(funcNo);
		

		dao.insert(authVO);

		return authVO;

	}
	
	public void deleteAuthority(Integer staNo) {
		dao.delete(staNo);
	}
	
	public void deleteAuthority(Integer staNo,Integer funcNo) {
		dao.delete(staNo,funcNo);
	}
	
	public List<AuthorityVO> getAllByStaNo(Integer staNo) {

		return dao.findByPrimaryKey(staNo);
	}
	
	public List<AuthorityVO> getAllByFuncNo(Integer funcNo) {

		return dao.findByPrimaryKey2(funcNo);
	}
	public List<AuthorityVO> getAll() {

		return dao.getAll();
	}

}
