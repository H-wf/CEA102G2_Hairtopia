package com.brand.model;

import java.util.List;
import java.util.Set;
import com.product.model.ProductVO;

public class BrandService {
	
	private BrandDAO_interface dao;
	
	public BrandService() {
		dao = new BrandDAO();
	}
	
	public BrandVO addBrand(String braName, byte[] braLogo, String braIntro) {
		BrandVO brandVO = new BrandVO();
		
		brandVO.setBraName(braName);
		brandVO.setBraLogo(braLogo);
		brandVO.setBraIntro(braIntro);
		dao.insert(brandVO);
		
		return brandVO;
	}
	
	//預留給Struts2用
	public void addBrand(BrandVO brandVO) {
		dao.insert(brandVO);
	}
	
	public BrandVO updateBrand(Integer braNo, String braName, byte[] braLogo, String braIntro) {
		BrandVO brandVO = new BrandVO();
		
		brandVO.setBraNo(braNo);
		brandVO.setBraName(braName);
		brandVO.setBraLogo(braLogo);
		brandVO.setBraIntro(braIntro);
		dao.update(brandVO);
		
		return dao.findByPrimaryKey(braNo);
	}
	
	//預留給Struts2用
	public void updateBrand(BrandVO brandVO) {
		dao.update(brandVO);
	}
	
	public void deleteBrand(Integer braNo) {
		dao.delete(braNo);
	}
	
	public BrandVO getOneBrand(Integer braNo) {
		return dao.findByPrimaryKey(braNo);
	}
	
	public List<BrandVO> getAll(){
		return dao.getAll();
	}
	
	public Set<ProductVO> getProductsByBraNo(Integer braNo){
		return dao.getProductsByBraNo(braNo);
	}
}
