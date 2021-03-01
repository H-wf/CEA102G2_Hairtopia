package com.ptype.model;

import java.util.List;
import java.util.Set;
import com.product.model.ProductVO;

public interface PtypeDAO_interface {
	public void insert(PtypeVO ptypeVO);
	public void update(PtypeVO ptypeVO);
	public void delete(Integer ptypeNo);
	public PtypeVO findByPrimaryKey(Integer ptypeNo);
	public List<PtypeVO> getAll();
	public Set<ProductVO> getProductsByPtypeNo(Integer ptypeNo);
}
