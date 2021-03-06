package com.staff.model;

import java.util.List;


public class StaffService {
	private StaffDAO_interface dao;

	public StaffService() {
		dao = new StaffDAO();
	}

	public StaffVO addStaff(String staAcct, String staPswd,String staName,Integer staStatus) {
		StaffVO staVO = new StaffVO();
		staVO.setStaName(staName);
		staVO.setStaAcct(staAcct);
		staVO.setStaPswd(staPswd);
		staVO.setStaStatus(staStatus);

		dao.insert(staVO);

		return staVO;

	}

	public StaffVO updateStaff(Integer staNo, String staAcct, String staPswd,String staName) {
		StaffVO staVO = new StaffVO();

		staVO.setStaNo(staNo);
		staVO.setStaName(staName);
		staVO.setStaAcct(staAcct);
		staVO.setStaPswd(staPswd);

		dao.update(staVO);

		return staVO;
	}
	
	public StaffVO updateStaff(StaffVO staVO) {
		dao.update(staVO);
		StaffVO newVO = dao.findByPrimaryKey(staVO.getStaNo());
		
		return newVO;
	}

	public void deleteStaff(Integer staNo) {
		dao.delete(staNo);
	}

	public StaffVO getOneStaff(Integer staNo) {
		return dao.findByPrimaryKey(staNo);
	}
	
	public StaffVO getOneStaff(String staAcct) {
		return dao.findByPrimaryKey(staAcct);
	}


	public List<StaffVO> getAll() {

		return dao.getAll();
	}
	
	public StaffVO getOneStaff(String staAcct,String staPswd) {
		return dao.findByAcctAndPwsd(staAcct, staPswd);
	}
	
	
	

}
