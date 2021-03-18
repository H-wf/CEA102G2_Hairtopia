package com.designer.model;

import java.sql.Connection;
import java.sql.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.post.model.PostVO;



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
	
	public DesignerVO updateOneScore(Integer desCount, Integer desTolScore, Integer desNo) {
		
		DesignerVO designerVO = new DesignerVO();
		
		designerVO.setDesCount(desCount);
		designerVO.setDesTolScore(desTolScore);
		designerVO.setDesNo(desNo);
		
		dao.updateScore(designerVO);
		
		return dao.findByDesNo(desNo);
	}
	public List<String> getNameAJAX(String keyword){
		return dao.getNameByAJAX(keyword);
	}
	
	public List<DesignerVO> searchDes(String keyword){
		return dao.searchDes(keyword);
	}
	
	public Set<DesignerVO> pickup5Des() {
		List<DesignerVO> allDes = dao.getAll();
		Set<DesignerVO> reDes = new HashSet<DesignerVO>();
		Set<Integer> index = new HashSet<Integer>();
		
		while(index.size()<5){
			int x = (int) (Math.random()*allDes.size())+1;
			index.add(x);
		}
		while(reDes.size()<5) {
			for(Integer y:index) {
				reDes.add(allDes.get(y));
			}
		}
		return reDes;
	}
	

}
