package com.cospost.model;

import java.sql.Timestamp;
import java.util.List;

public class CospostService {

		private CospostDAO_interface dao;

		public CospostService() {
			dao = new CospostDAO();
		}
		
		public CospostVO insertCosPost(Integer cosNo, String cosPubCon, Timestamp cosPubTime) {

			CospostVO cospostVO = new CospostVO();

			cospostVO.setCosNo(cosNo);
			cospostVO.setCosPubCon(cosPubCon);
			cospostVO.setCosPubTime(cosPubTime);
			dao.insert(cospostVO);

			return cospostVO;
		}
		
		public void deleteCosPost(Integer cosPubNo) {
			dao.delete(cosPubNo);
		}
		
		public CospostVO updateCosPost(Integer cosNo, String cosPubCon, Timestamp cosPubTime, Integer cosPubNo) {

			CospostVO cospostVO = new CospostVO();

			cospostVO.setCosNo(cosNo);
			cospostVO.setCosPubCon(cosPubCon);
			cospostVO.setCosPubTime(cosPubTime);
			cospostVO.setCosPubNo(cosPubNo);
			dao.update(cospostVO);

			return cospostVO;
		}
		
		public List<CospostVO> getAll() {
			return dao.getAll();
		}

		public CospostVO getOneCosPost(Integer cosPubNo) {
			return dao.findByPrimaryKey(cosPubNo);
		}
}

