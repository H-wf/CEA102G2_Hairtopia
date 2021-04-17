package com.notification.model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public class NotiService {
	private NotiDAO_interface dao;
	
	public NotiService() {
		dao = new NotiHibernateDAO();
	}
	
	public NotiVO addNoti(Integer memNo, String notiText, Boolean notiIsRead) {
		
		NotiVO notiVO = new NotiVO();
		
		notiVO.setMemNo(memNo);
		notiVO.setNotiText(notiText);
		notiVO.setNotiIsRead(notiIsRead);
		notiVO.setNotiTime(new Timestamp(new Date().getTime()));
		
		dao.insert(notiVO);
		
		return notiVO;
	}
	
	public NotiVO updateNoti(Integer notiNo, Integer memNo, String notiText, Boolean notiIsRead) {
		
		NotiVO notiVO = dao.findByPrimaryKey(notiNo);
		notiVO.setNotiNo(notiNo);
		notiVO.setMemNo(memNo);
		notiVO.setNotiText(notiText);
		notiVO.setNotiIsRead(notiIsRead);;
		
		dao.update(notiVO);
		
		return notiVO;
	}
	
	public void deleteNoti(Integer notiNo) {
		dao.delete(notiNo);
	}
	
	public NotiVO getOneNoti(Integer chatNo) {
		return dao.findByPrimaryKey(chatNo);
	}
	
	public List<NotiVO> getAll() {
		return dao.getAll();
	}
}
