package com.product.model;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.post.model.PostVO;

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
	
	public Set<ProductVO> pickup5Product() {
		Set<ProductVO> reProduct = new HashSet<ProductVO>();
		Map<String, String[]> map = new HashMap<String, String[]>();
		String[] proStatus = new String[] {"1"};
		map.put("proStatus",proStatus);
		try {
			List<ProductVO> allProduct = dao.getAll(map);
			Set<Integer> index = new HashSet<Integer>();
			int count=0;
			while (index.size() < 5) {
				int x = (int) (Math.random() * allProduct.size());
				if(index.add(x)) {
					count++;
				}
				if(count==allProduct.size()) {
					break;
				}
			}
			while (reProduct.size() < index.size()) {
				for (Integer y : index) {
					reProduct.add(allProduct.get(y));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reProduct;
	}
}
