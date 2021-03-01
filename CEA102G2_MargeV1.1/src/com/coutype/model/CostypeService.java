package com.coutype.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

import com.cos.model.CosVO;

public class CostypeService {

		private CostypeDAO_interface dao;

		public CostypeService() {
			dao = new CostypeDAO();
		}
		
		public CostypeVO insertCosType(String cosTypeName, String cosTypeIntro) {

			CostypeVO costypeVO = new CostypeVO();
			
			costypeVO.setCosTypeName(cosTypeName);
			costypeVO.setCosTypeIntro(cosTypeIntro);
			dao.insert(costypeVO);

			return costypeVO;
		}
		
		public void deleteCosType(Integer cosTypeNo) {
			dao.delete(cosTypeNo);
		}
		
		public CostypeVO updateCosType(Integer cosTypeNo, String cosTypeName, String cosTypeIntro) {

			CostypeVO costypeVO = new CostypeVO();

			costypeVO.setCosTypeNo(cosTypeNo);
			costypeVO.setCosTypeName(cosTypeName);
			costypeVO.setCosTypeIntro(cosTypeIntro);
			dao.update(costypeVO);

			return costypeVO;
		}
		
		public List<CostypeVO> getAll() {
			return dao.getAll();
		}

		public CostypeVO getOneCosType(Integer cosTypeNo) {
			return dao.findByPrimaryKeybyCostypeVO(cosTypeNo);
		}
		
		public Set<CosVO> getCosByCosTypeNo(Integer cosTypeNo) {
			return dao.findByPrimaryKeybyCosVO(cosTypeNo);
		}
}

