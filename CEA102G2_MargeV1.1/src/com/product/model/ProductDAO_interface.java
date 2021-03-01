package com.product.model;

import java.util.List;
import java.util.Map;

public interface ProductDAO_interface {
	public void insert(ProductVO productVO);
	public void update(ProductVO productVO);
	public void delete(Integer proNo);
	public ProductVO findByPrimaryKey(Integer proNo);
	public List<ProductVO> getAll();
	public List<ProductVO> getAll(Map<String, String[]> map);
}
