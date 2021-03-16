package com.lecturer.model;

import java.util.List;

public class LecturerService {
	private LecturerDAO_interface dao;
	
	
	public LecturerService() {
		dao = new LecturerDAO();
	}
	
	
	
	public LecturerVO addLecturer(String lecName,byte[] lecPic, String lecIntro, Integer lecStatus,Integer staNo) {
		LecturerVO lecVO = new LecturerVO();
		
		lecVO.setLecName(lecName);
		lecVO.setLecPic(lecPic);
		lecVO.setLecIntro(lecIntro);
		lecVO.setLecStatus(lecStatus);
		lecVO.setStaNo(staNo);
		dao.insert(lecVO);
		
		
		return lecVO;
		
	}
	
	public LecturerVO updateLecturer(Integer lecNo,String lecName,byte[] lecPic,String lecIntro, Integer lecStatus) {
		LecturerVO lecVO = new LecturerVO();
		
		
		lecVO.setLecNo(lecNo);
		lecVO.setLecName(lecName);
		lecVO.setLecPic(lecPic);
		lecVO.setLecIntro(lecIntro);
		lecVO.setLecStatus(lecStatus);
		dao.update(lecVO);
		
		
		
		return lecVO;
	}
	
	
	public void deleteLecturer(Integer lecNo) {
		dao.delete(lecNo);
	}
	
	public LecturerVO getOneLecturer(Integer lecNo) {
		return dao.findByPrimaryKey(lecNo);
	}
	

	public List<LecturerVO> getAll() {
		
		return dao.getAll();
	}
	
	public LecturerVO updateLecturerWoPic(Integer lecNo,String lecName,String lecIntro, Integer lecStatus) {
		//此方法使用於更新資料但未更新圖片
		LecturerVO lecVO = new LecturerVO();
	
		
		
		lecVO.setLecNo(lecNo);
		lecVO.setLecName(lecName);
		lecVO.setLecIntro(lecIntro);
		lecVO.setLecStatus(lecStatus);
		//使用update方式修改
		dao.update2(lecVO);
		//再利用lecNo從DB查更新完的資料回傳給JSP
		lecVO=dao.findByPrimaryKey(lecNo);
		
		
		return lecVO;
	}

}
