package com.schedule.model;

import java.sql.Date;
import java.util.List;



public interface ScheduleDAO_interface {
	public void insert(ScheduleVO schVO);

	public void update(ScheduleVO schVO);

	public void delete(Integer schNo);

	public ScheduleVO findByPrimaryKey(Integer desNo,Date schDate);

	public List<ScheduleVO> getAll(Integer desNo);

}
