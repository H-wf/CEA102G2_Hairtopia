package com.product.model;

import java.util.List;
import java.util.Map;

public class ProductService {
private ProductDAO_interface dao;
	
	public ProductService() {
		dao = new ProductDAO();
	}
	
	public ProductVO addProduct(Integer ptypeNo, Integer braNo, String proName, Boolean proStatus, Integer proPrice, byte[] proMpic, byte[] proPic, String proDesc) {
		ProductVO productVO = new ProductVO();
		
		productVO.setPtypeNo(ptypeNo);
		productVO.setBraNo(braNo);
		productVO.setProName(proName);
		productVO.setProStatus(proStatus);
		productVO.setProPrice(proPrice);
		productVO.setProMpic(proMpic);
		productVO.setProPic(proPic);
		productVO.setProDesc(proDesc);
		dao.insert(productVO);
		
		return productVO;
	}
	
	//預留給Struts2用
	public void addProduct(ProductVO productVO) {
		dao.insert(productVO);
	}
	
	public ProductVO updateProduct(Integer proNo, Integer ptypeNo, Integer braNo, String proName, Boolean proStatus, Integer proPrice, byte[] proMpic, byte[] proPic, String proDesc) {
		ProductVO productVO = new ProductVO();
		
		productVO.setProNo(proNo);
		productVO.setPtypeNo(ptypeNo);
		productVO.setBraNo(braNo);
		productVO.setProName(proName);
		productVO.setProStatus(proStatus);
		productVO.setProPrice(proPrice);
		productVO.setProMpic(proMpic);
		productVO.setProPic(proPic);
		productVO.setProDesc(proDesc);
		dao.update(productVO);
		
		return dao.findByPrimaryKey(proNo);
	}
	
	//預留給Struts2用
	public void updateProduct(ProductVO productVO) {
		dao.update(productVO);
	}
	
	public void deleteProduct(Integer proNo) {
		dao.delete(proNo);
	}
	
	public ProductVO getOneProduct(Integer proNo) {
		return dao.findByPrimaryKey(proNo);
	}
	
	public List<ProductVO> getAll(){
		return dao.getAll();
	}
	public List<ProductVO> getAll(Map<String, String[]> map){
		return dao.getAll(map);
	}
}
