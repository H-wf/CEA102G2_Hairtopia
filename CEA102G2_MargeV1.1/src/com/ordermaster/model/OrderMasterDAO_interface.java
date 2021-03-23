package com.ordermaster.model;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import com.orderdetail.model.OrderDetailVO;


public interface OrderMasterDAO_interface {
	public void insert(OrderMasterVO ordmVO);
	public void update(OrderMasterVO ordmVO);
	public void delete(Integer ordNo);
	public OrderMasterVO findByPrimaryKey(Integer ordNo);
	public List<OrderMasterVO> getAll();
//	public List<OrderMasterVO> getAllByMemNo(Integer memNo);
	public List<OrderMasterVO> getAll(Map<String, String[]> map);
	public OrderMasterVO insertWithOrderDetails(OrderMasterVO ordermasterVO, List<OrderDetailVO> list);
}
 