package com.coudet.model;

import java.util.HashSet;
import java.util.List;

import com.cos.model.CosVO;

public class CosdetService {

		private static CosdetDAO_interface dao;

		public CosdetService() {
			dao = new CosdetDAO();
		}
		
		public CosdetVO insertCosDet(Integer cosNo, Integer memNo, Integer cosComment, Integer cosDetailPrice) {

			CosdetVO cosdetVO = new CosdetVO();
			
			cosdetVO.setCosNo(cosNo);
			cosdetVO.setMemNo(memNo);
			cosdetVO.setCosComment(cosComment);
			cosdetVO.setCosDetailPrice(cosDetailPrice);
			dao.insert(cosdetVO);

			return cosdetVO;
		}
		
		public void deleteCosDet(Integer cosNo) {
			dao.delete(cosNo);
		}
		
		public CosdetVO updateCosDet(Integer cosNo, Integer cosComment, Integer cosDetailPrice, Integer memNo) {

			CosdetVO cosdetVO = new CosdetVO();

			cosdetVO.setCosNo(cosNo);
			cosdetVO.setCosComment(cosComment);
			cosdetVO.setCosDetailPrice(cosDetailPrice);
			cosdetVO.setMemNo(memNo);
			
			dao.update(cosdetVO);

			return cosdetVO;
		}
		
		public List<CosdetVO> getAll() {
			return dao.getAll();
		}

		public List<CosdetVO> getOneCosDet(Integer cosNo) {
			return dao.findByPrimaryKey(cosNo);
		}
		
		public CosdetVO insertCosDetNoComment(Integer cosNo, Integer memNo, Integer cosDetailPrice) {

			CosdetVO cosdetVO = new CosdetVO();
			
			cosdetVO.setCosNo(cosNo);
			cosdetVO.setMemNo(memNo);
			cosdetVO.setCosDetailPrice(cosDetailPrice);
			dao.insertNoComment(cosdetVO);

			return cosdetVO;
		}
		
		public CosdetVO updateCosDetWithComment(Integer cosComment, Integer memNo, Integer cosNo) {

			CosdetVO cosdetVO = new CosdetVO();
			
			cosdetVO.setCosComment(cosComment);
			cosdetVO.setMemNo(memNo);
			cosdetVO.setCosNo(cosNo);
			
			dao.updateCosRate(cosdetVO);

			return cosdetVO;
		}
		
		public List<CosdetVO> getAllCosByMemNo(Integer memNo) {
			return dao.getAllCosByMemNo(memNo);
		}
		
		public CosdetVO getAvgCosCommentByCosNo(Integer cosNo) {
			return dao.getAvgCosCommentByCosNo(cosNo);
		}
		
		public CosVO updateCosRateForCosTable(Integer cosRate, Integer cosNo) {

			CosVO cosVO = new CosVO();
			
			cosVO.setCosRate(cosRate);
			cosVO.setCosNo(cosNo);
			
			dao.updateCosRateForCosTable(cosVO);

			return cosVO;
		}
}

