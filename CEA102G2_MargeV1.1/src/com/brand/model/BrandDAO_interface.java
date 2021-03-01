package com.brand.model;

import java.util.List;
import java.util.Set;
import com.product.model.ProductVO;

public interface BrandDAO_interface {
	public void insert(BrandVO brandVO);
	public void update(BrandVO brandVO);
	public void delete(Integer braNo);
	public BrandVO findByPrimaryKey(Integer braNo);
	public List<BrandVO> getAll();
	public Set<ProductVO> getProductsByBraNo(Integer braNo);
}
