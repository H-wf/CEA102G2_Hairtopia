package com.member.model;

import java.util.List;

public interface MemDAO_interface {
	public void insert(MemVO memVO);
	public void signUp(MemVO memVO);
	public void update(MemVO memVO);
	public void updatePassword(String memEmail, String memPswd);
	public void updateStatus(String memEmail, Integer memStatus);
	public void delete(Integer memno);
    public MemVO findByPrimaryKey(Integer memno);
    public MemVO validateEmail(String memEmail);
    public String validateMemberName(String memName);
    public List<MemVO> getAll();
    public MemVO validate(String memEmail, String memPswd);
//    public InputStream showImg(Integer memNo);
}
