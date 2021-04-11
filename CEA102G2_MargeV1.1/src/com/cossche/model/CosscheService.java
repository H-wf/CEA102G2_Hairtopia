package com.cossche.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

public class CosscheService {
	private Cossche_interface dao;
	
	public CosscheVO updateCosStatusWhenApplyStart() {
		
		CosscheVO cosscheVO = new CosscheVO();	
			dao.updateCosStatusWhenApplyStart();
			return cosscheVO;
	}
	
//	public CosscheVO updateCosStatusWhenApplyOver() {
//		
//		CosscheVO cosscheVO = new CosscheVO();	
//			dao.updateCosStatusWhenApplyOver();
//			return cosscheVO;
//	}
}
	