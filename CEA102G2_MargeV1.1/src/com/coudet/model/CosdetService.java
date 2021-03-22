package com.coudet.model;

import java.util.List;

public class CosdetService {

		private CosdetDAO_interface dao;

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
}

