package com.lecturer.model;

import java.util.List;

public interface LecturerDAO_interface {
	public void insert(LecturerVO lecVO);

	public void update(LecturerVO lecVO);

	public void delete(Integer lecNo);

	public LecturerVO findByPrimaryKey(Integer lecNo);
	public LecturerVO findByStaNo(Integer staNo);
	public List<LecturerVO> getAll();
	
	public void update2(LecturerVO lecVO);


}
