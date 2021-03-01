package com.orderdetail.model;

import java.util.List;
import java.util.Map;

import com.product.model.ProductVO;


public class OrderDetailService {
private OrderDetailDAO_interface dao;
	
	public OrderDetailService() {
		dao = new OrderDetailDAO();
	}
	
	public OrderDetailVO addOrderDetail(Integer ordNo, Integer proNo, Integer ordDetAmt, Integer ordDetPrice) {
		OrderDetailVO orderdetailVO = new OrderDetailVO();
		
		orderdetailVO.setOrdNo(ordNo);
		orderdetailVO.setProNo(proNo);
		orderdetailVO.setOrdDetAmt(ordDetAmt);
		orderdetailVO.setOrdDetPrice(ordDetPrice);		
		dao.insert(orderdetailVO);
		
		return orderdetailVO;
	}
	
	//預留給Struts2用
	public void addOrderDetail(OrderDetailVO orderdetailVO) {
		dao.insert(orderdetailVO);
	}
	
	public OrderDetailVO updateOrderDetail(Integer ordNo, Integer proNo, Integer ordDetAmt, Integer ordDetPrice) {
		OrderDetailVO orderdetailVO = new OrderDetailVO();
		
		orderdetailVO.setOrdNo(ordNo);
		orderdetailVO.setProNo(proNo);
		orderdetailVO.setOrdDetAmt(ordDetAmt);
		orderdetailVO.setOrdDetPrice(ordDetPrice);
		dao.update(orderdetailVO);
		
		return dao.findByPrimaryKey(ordNo, proNo);
	}
	
	//預留給Struts2用
	public void updateOrderDetail(OrderDetailVO orderdetailVO) {
		dao.update(orderdetailVO);
	}
	
	public void deleteOrderDetail(Integer ordNo, Integer proNo) {
		dao.delete(ordNo, proNo);
	}
	
	public OrderDetailVO getOneOrderDetail(Integer ordNo, Integer proNo) {
		return dao.findByPrimaryKey(ordNo, proNo);
	}
	
	public List<OrderDetailVO> getAll(){
		return dao.getAll();
	}
	
	public List<OrderDetailVO> getAll(Map<String, String[]> map){
		return dao.getAll(map);
	}
}
