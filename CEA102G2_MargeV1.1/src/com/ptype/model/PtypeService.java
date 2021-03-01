package com.ptype.model;

import java.util.List;
import java.util.Set;
import com.product.model.ProductVO;

public class PtypeService {
	
	private PtypeDAO_interface dao;
	
	public PtypeService() {
		dao = new PtypeDAO();
	}
	
	public PtypeVO addPtype(String ptypeName) {
		PtypeVO ptypeVO = new PtypeVO();
		
		ptypeVO.setPtypeName(ptypeName);
		dao.insert(ptypeVO);
		
		return ptypeVO;
	}
	
	//預留給Struts2用
	public void addPtype(PtypeVO ptypeVO) {
		dao.insert(ptypeVO);
	}
	
	public PtypeVO updatePtype(Integer ptypeNo, String ptypeName) {
		PtypeVO ptypeVO = new PtypeVO();
		
		ptypeVO.setPtypeNo(ptypeNo);
		ptypeVO.setPtypeName(ptypeName);
		dao.update(ptypeVO);
		
		return dao.findByPrimaryKey(ptypeNo);
	}
	
	//預留給Struts2用
	public void updatePtype(PtypeVO ptypeVO) {
		dao.update(ptypeVO);
	}
	
	public void deletePtype(Integer ptypeNo) {
		dao.delete(ptypeNo);
	}
	
	public PtypeVO getOnePtype(Integer ptypeNo) {
		return dao.findByPrimaryKey(ptypeNo);
	}
	
	public List<PtypeVO> getAll(){
		return dao.getAll();
	}
	
	public Set<ProductVO> getProductsByPtypeNo(Integer ptypeNo){
		return dao.getProductsByPtypeNo(ptypeNo);
	}
}
