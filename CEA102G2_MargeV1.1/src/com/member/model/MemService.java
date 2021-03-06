package com.member.model;

import java.io.InputStream;
import java.util.*;

public class MemService {
	private MemDAO_interface dao;
	
	public MemService() {
		dao = new MemDAO();
	}
	//memName, memGender, memInform ,memEmail, memPswd, memPhone, memAddr, memPic
	public MemVO addMember(String memName, Integer memGender, String memInform, String memEmail, String memPswd, String memPhone, String memAddr, byte[] memPic) {
		MemVO memVO = new MemVO();
		memVO.setMemName(memName);
		memVO.setMemGender(memGender);
		memVO.setMemInform(memInform);
		memVO.setMemEmail(memEmail);
		memVO.setMemPswd(memPswd);
		memVO.setMemPhone(memPhone);
		memVO.setMemAddr(memAddr);
		memVO.setMemPic(memPic);
		
		dao.insert(memVO);
		
		return memVO;
	}
	
	public MemVO updateMember(Integer memNo, String memName, Integer memGender, String memInform, String memEmail, String memPswd, String memPhone, String memAddr, byte[] memPic) {
		
		MemVO memVO = new MemVO();
		memVO.setMemNo(memNo);
		memVO.setMemName(memName);
		memVO.setMemGender(memGender);
		memVO.setMemInform(memInform);
		memVO.setMemEmail(memEmail);
		memVO.setMemPswd(memPswd);
		memVO.setMemPhone(memPhone);
		memVO.setMemAddr(memAddr);
		memVO.setMemPic(memPic);
		
		dao.update(memVO);
		
		return memVO;
	}
	
	public void deleteMember(Integer memNo) {
		dao.delete(memNo);
	}
	
	public MemVO getOneMem(Integer memNo) {
		return dao.findByPrimaryKey(memNo);
	}
	
	public List<MemVO> getAll() {
		return dao.getAll();
	}
	
	public MemVO validate(String memEmail, String memPswd){
		return dao.validate(memEmail, memPswd);
	}
	
	public String validateEmail(String memEmail) {
		return dao.validateEmail(memEmail);
	}
	
	public void updatePassword(String memEmail, String memPswd) {
		dao.updatePassword(memEmail, memPswd);
	}
	
	public String getOneMemName(Integer memNo) {
		return dao.findByPrimaryKey(memNo).getMemName();
	}
}
