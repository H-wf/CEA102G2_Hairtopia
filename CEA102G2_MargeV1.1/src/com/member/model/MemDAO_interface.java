package com.member.model;

import java.io.InputStream;
import java.util.List;

public interface MemDAO_interface {
	public void insert(MemVO memVO);
	public void signUp(MemVO memVO);
	public void update(MemVO memVO);
	public void updatePassword(String memEmail, String memPswd);
	public void delete(Integer memno);
    public MemVO findByPrimaryKey(Integer memno);
    public String validateEmail(String memEmail);
    public List<MemVO> getAll();
    public MemVO validate(String memEmail, String memPswd);
//    public InputStream showImg(Integer memNo);
}
