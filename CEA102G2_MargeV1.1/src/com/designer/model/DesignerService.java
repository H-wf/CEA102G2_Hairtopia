package com.designer.model;

import java.sql.Connection;
import java.sql.Date;
import java.util.List;



public class DesignerService {
	
	private DesignerDAO_interface dao;
	
	public DesignerService() {
		dao = new DesignerDAO();
	}
	
	public DesignerVO addDesigner(Integer memNo, Integer salNo, String desName,
			String desInfor, String desSchedule, byte[] desPic) {

		DesignerVO designerVO = new DesignerVO();

		designerVO.setMemNo(memNo);
		designerVO.setSalNo(salNo);
		designerVO.setDesName(desName);
		designerVO.setDesInfor(desInfor);
		designerVO.setDesSchedule(desSchedule);
		designerVO.setDesPic(desPic);
		dao.insert(designerVO);

		return designerVO;
	}
	public void addDesigner(DesignerVO designerVO,Connection con) {
		dao.insert2(designerVO,con);
	}
	
	public void addDesigner(DesignerVO designerVO,Connection con) {
		dao.insert2(designerVO,con);
	}
	
	public DesignerVO getOneDesByMemNo(Integer memNo) {
		return dao.findByMemNo(memNo);
	}
	
	public DesignerVO getOneDesByDesNo(Integer desNo) {
		return dao.findByDesNo(desNo);
	}
	
	public DesignerVO updateOneStatus(Date desEndDate, Integer desStatus, Integer desNo) {
		
		DesignerVO designerVO = new DesignerVO();
		
		designerVO.setDesEndDate(desEndDate);
		designerVO.setDesStatus(desStatus);
		designerVO.setDesNo(desNo);
		
		dao.updateOneStatus(designerVO);
		
		return designerVO;
	}
	
	
	public DesignerVO update(Integer salNo, String desName, String desInfor, String desSchedule, byte[] desPic, Integer desNo) {
		
		DesignerVO designerVO = new DesignerVO();
		
		designerVO.setSalNo(salNo);
		designerVO.setDesName(desName);
		designerVO.setDesInfor(desInfor);
		designerVO.setDesSchedule(desSchedule);
		designerVO.setDesPic(desPic);
		designerVO.setDesNo(desNo);
		
		dao.update(designerVO);
		
		return designerVO;
	}
	
	
	public DesignerVO updateWithoutPic(Integer salNo, String desName, String desInfor, String desSchedule, Integer desNo) {

		DesignerVO designerVO = new DesignerVO();

		designerVO.setSalNo(salNo);
		designerVO.setDesName(desName);
		designerVO.setDesInfor(desInfor);
		designerVO.setDesSchedule(desSchedule);
		designerVO.setDesNo(desNo);
		
		dao.updateWithoutPic(designerVO);

		return designerVO;
	}
	public void deleteDesigner(Integer desNo) {
		dao.delete(desNo);
	}
	
	
	
	public List<DesignerVO> getAll(){
		return dao.getAll();
	}
	
	public List<String> getNameAJAX(String keyword){
		return dao.getNameByAJAX(keyword);
	}
	
	public List<DesignerVO> searchDes(String keyword){
		return dao.searchDes(keyword);
	}
	

}
