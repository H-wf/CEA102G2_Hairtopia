package com.service.model;

import java.util.List;

import com.service.model.ServiceDAO;
import com.service.model.ServiceDAO_interface;
import com.service.model.ServiceVO;

public class ServiceService {
	
	private ServiceDAO_interface dao;
	
	public ServiceService() {
		dao = new ServiceDAO();
	}
	
	public ServiceVO addService(Integer desNo, Integer stypeNo, String serName,
			Integer serPrice, Integer serTime, String serDesc, Integer serStatus) {

		ServiceVO serviceVO = new ServiceVO();

		serviceVO.setDesNo(desNo);
		serviceVO.setStypeNo(stypeNo);
		serviceVO.setSerName(serName);
		serviceVO.setSerPrice(serPrice);
		serviceVO.setSerTime(serTime);
		serviceVO.setSerDesc(serDesc);
		serviceVO.setSerStatus(serStatus);
		dao.insert(serviceVO);

		return serviceVO;
	}
	
	public ServiceVO updateService(Integer serNo, Integer desNo, Integer stypeNo,
			String serName, Integer serPrice, Integer serTime, String serDesc,
			Integer serStatus) {

		ServiceVO serviceVO = new ServiceVO();
		
		serviceVO.setSerNo(serNo);
		serviceVO.setDesNo(desNo);
		serviceVO.setStypeNo(stypeNo);
		serviceVO.setSerName(serName);
		serviceVO.setSerPrice(serPrice);
		serviceVO.setSerTime(serTime);
		serviceVO.setSerDesc(serDesc);
		serviceVO.setSerStatus(serStatus);
		dao.update(serviceVO);

		return serviceVO;
	}
	
	public ServiceVO updateServiceStatus(Integer serNo, Integer serStatus) {
		
		ServiceVO serviceVO = new ServiceVO();
		
		serviceVO.setSerNo(serNo);
		serviceVO.setSerStatus(serStatus);
		dao.updateSerStatus(serviceVO);
		
		return serviceVO;
	}
	
	public void deleteService(Integer serNo) {
		dao.delete(serNo);
	}

	public ServiceVO getOneServiceBySerNo(Integer serNo) {
		return dao.findByPrimaryKeySerNo(serNo);
	}
	
	public List<ServiceVO> getAllServiceByDesNo(Integer desNo) {
		return dao.findByPrimaryKeyDesNo(desNo);
	}
	
	public List<ServiceVO> getAllServiceByStypeNo(Integer stypeNo) {
		return dao.findByPrimaryKeyStypeNo(stypeNo);
	}

	public List<ServiceVO> getAll() {
		return dao.getAll();
	}
	
	public String getSerName(Integer serNo) {
		return dao.findByPrimaryKeySerNo(serNo).getSerName();
	}
	
	public Integer getSerTime(Integer serNo) {
		return dao.findByPrimaryKeySerNo(serNo).getSerTime();
	}

}