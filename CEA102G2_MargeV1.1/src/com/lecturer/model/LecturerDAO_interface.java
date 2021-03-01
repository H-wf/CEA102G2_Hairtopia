package com.lecturer.model;

import java.util.List;

public interface LecturerDAO_interface {
	public void insert(LecturerVO lecVO);

	public void update(LecturerVO lecVO);

	public void delete(Integer lecno);

	public LecturerVO findByPrimaryKey(Integer lecno);

	public List<LecturerVO> getAll();
	
	public void update2(LecturerVO lecVO);


}
