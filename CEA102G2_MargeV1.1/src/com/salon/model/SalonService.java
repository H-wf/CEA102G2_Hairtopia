package com.salon.model;

import java.util.List;

import com.designer.model.*;

public class SalonService {
	
	private SalonDAO_interface dao;
	
	public SalonService() {
		dao = new SalonDAO();
	}
	
	public SalonVO addSalon(String salName, String salAdd, String salTime,
			String salPhone, Integer salStatus) {

		SalonVO salonVO = new SalonVO();

		salonVO.setSalName(salName);
		salonVO.setSalAdd(salAdd);
		salonVO.setSalTime(salTime);
		salonVO.setSalPhone(salPhone);
		salonVO.setSalStatus(salStatus);
		dao.insert(salonVO);

		return salonVO;
	}
	public void addSalonWithDes(SalonVO salonVO,List<DesignerVO> list) {
		dao.insertWithDes(salonVO, list);
		
	}
	
	public SalonVO updateSalon(Integer salNo, String salName, String salAdd, 
			String salTime, String salPhone, Integer salStatus) {

		SalonVO salonVO = new SalonVO();
		
		salonVO.setSalNo(salNo);
		salonVO.setSalName(salName);
		salonVO.setSalAdd(salAdd);
		salonVO.setSalTime(salTime);
		salonVO.setSalPhone(salPhone);
		salonVO.setSalStatus(salStatus);
		dao.update(salonVO);

		return salonVO;
	}
	
	public void deleteSalon(Integer salNo) {
		dao.delete(salNo);
	}

	public SalonVO getOneSalon(Integer salNo) {
		return dao.findByPrimaryKey(salNo);
	}

	public List<SalonVO> getAll() {
		return dao.getAll();
	}
	public List<SalonVO> getAllbyAjax(String keyword) {
		return dao.getAllByAjax(keyword);
	}
	public SalonVO getOneSalon(String salName) {
		return dao.findBySalName(salName);
	}
	public List<String> getSalAJAX(String keyword){
		return dao.getSalAJAX(keyword);
	}
	public List<SalonVO> getSalSearch(String keyword){
		return dao.getAllSearch(keyword);
	}

}
