package com.schedule.model;

import java.sql.Date;
import java.util.List;


public class ScheduleService {
	private ScheduleDAO_interface dao;

	public ScheduleService() {
		dao = new ScheduleDAO();
	}
	
	public ScheduleVO addSchedule(Integer desNo, Date schDate,String schStatus) {
		ScheduleVO schVO = new ScheduleVO();
		schVO.setDesNo(desNo);
		schVO.setSchDate(schDate);
		schVO.setSchStatus(schStatus);

		dao.insert(schVO);

		return schVO;

	}
	
	public ScheduleVO updateSchedule(Integer schNo, Integer desNo, Date schDate,String schStatus) {
		ScheduleVO schVO = new ScheduleVO();

		schVO.setSchNo(schNo);
		schVO.setDesNo(desNo);
		schVO.setSchDate(schDate);
		schVO.setSchStatus(schStatus);

		dao.update(schVO);

		return schVO;
	}
	
	public void deleteSchdule(Integer schNo) {
		dao.delete(schNo);
	}

	public ScheduleVO getOneSchdule(Integer desNo,Date schDate) {
		return dao.findByPrimaryKey(desNo, schDate);
	}

	public List<ScheduleVO> getAll(Integer desNo) {

		return dao.getAll(desNo);
	}
	

}
