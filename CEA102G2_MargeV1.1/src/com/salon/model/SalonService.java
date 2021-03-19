package com.salon.model;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.designer.model.*;
import com.post.model.PostVO;


public class SalonService {
	
	private SalonDAO_interface dao;
	
	public SalonService() {
		dao = new SalonDAO();
	}
	
	public SalonVO addSalon(String salName, String salAdd, String salTime,
			String salPhone, Integer salStatus,String salLat,String salLng) {

		SalonVO salonVO = new SalonVO();

		salonVO.setSalName(salName);
		salonVO.setSalAdd(salAdd);
		salonVO.setSalTime(salTime);
		salonVO.setSalPhone(salPhone);
		salonVO.setSalStatus(salStatus);
		salonVO.setSalLat(salLat);
		salonVO.setSalLng(salLng);
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
	
	public Set<SalonVO> pickup5Sal() {
		Set<SalonVO> reSal = new HashSet<SalonVO>();
		try {
			List<SalonVO> allSal = dao.getAll();
			Set<Integer> index = new HashSet<Integer>();

			while (index.size() < 5) {
				int x = (int) (Math.random() * allSal.size());
				index.add(x);
			}
			while (reSal.size() < 5) {
				for (Integer y : index) {
					reSal.add(allSal.get(y));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reSal;
	}


}
