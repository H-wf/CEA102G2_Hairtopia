package com.orderdetail.model;

import java.util.List;
import java.util.Map;


public interface OrderDetailDAO_interface {
	public void insert(OrderDetailVO orderdetailVO);
	public void update(OrderDetailVO orderdetailVO);
	public void delete(Integer ordNo, Integer proNo);
	public OrderDetailVO findByPrimaryKey(Integer ordNo, Integer proNo);
	public List<OrderDetailVO> getAll();
	public List<OrderDetailVO> getAll(Map<String, String[]> map);
	public void insert2(OrderDetailVO orderdetailVO, java.sql.Connection con);
}
