package com.coudet.model;

import java.util.*;

import com.cos.model.CosVO;

public interface CosdetDAO_interface {
		public void insert(CosdetVO cosdetVO);
		public void update(CosdetVO cosdetVO);
		public void delete(Integer cosNo);
		public List<CosdetVO> findByPrimaryKey(Integer cosNo);
		public List<CosdetVO> getAll();
		public void insertNoComment(CosdetVO cosdetVO);
		public List<CosdetVO> getAllCosByMemNo(Integer memNo);
		public void updateCosRate(CosdetVO cosdetVO);
		public CosdetVO getAvgCosCommentByCosNo(Integer cosNo);
		public void updateCosRateForCosTable(CosVO cosVO);//把cosComment算出平均後，送入course表格
		
}
