package com.ordermaster.model;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import com.orderdetail.model.OrderDetailVO;


public class OrderMasterService {
private OrderMasterDAO_interface dao;
	
	public OrderMasterService() {
		dao = new OrderMasterDAO();
	}
	
	public OrderMasterVO addOrderMaster(Integer memNo, Integer ordStatus, Integer ordAmt) {
		OrderMasterVO ordermasterVO = new OrderMasterVO();
		
		ordermasterVO.setMemNo(memNo);
		ordermasterVO.setOrdStatus(ordStatus);
		ordermasterVO.setOrdAmt(ordAmt);
		dao.insert(ordermasterVO);
		
		return ordermasterVO;
	}
	
	//預留給Struts2用
	public void addOrderMaster(OrderMasterVO ordermasterVO) {
		dao.insert(ordermasterVO);
	}
	
	public OrderMasterVO updateOrderMaster(Integer ordNo, Integer memNo, Integer ordStatus, Integer ordAmt) {
		OrderMasterVO ordermasterVO = new OrderMasterVO();
		
		ordermasterVO.setMemNo(memNo);
		ordermasterVO.setOrdStatus(ordStatus);
		ordermasterVO.setOrdAmt(ordAmt);
		dao.update(ordermasterVO);
		
		return dao.findByPrimaryKey(ordNo);
	}
	
	//預留給Struts2用
	public void updateOrderMaster(OrderMasterVO ordermasterVO) {
		dao.update(ordermasterVO);
	}
	
	public void deleteOrderMaster(Integer ordNo) {
		dao.delete(ordNo);
	}
	
	public OrderMasterVO getOneOrderMaster(Integer ordNo) {
		return dao.findByPrimaryKey(ordNo);
	}
	
	public List<OrderMasterVO> getAll(){
		return dao.getAll();
	}
	
	public List<OrderMasterVO> getAll(Map<String, String[]> map){
		return dao.getAll(map);
	}
	
	public OrderMasterVO addOrderMasterwithOrderDetails(Integer memNo, Integer ordAmt, List<OrderDetailVO> list) {
		OrderMasterVO ordermasterVO = new OrderMasterVO();
		
		ordermasterVO.setMemNo(memNo);
		ordermasterVO.setOrdAmt(ordAmt);
		ordermasterVO=dao.insertWithOrderDetails(ordermasterVO,list);
		
		return ordermasterVO;
	}

}
