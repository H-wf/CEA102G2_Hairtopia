package com.coutype.model;

import java.util.*;

import com.cos.model.CosVO;

public interface CostypeDAO_interface {
		public void insert(CostypeVO costypeVO);
		public void update(CostypeVO costypeVO);
		public void delete(Integer cosTypeNo);
		public CostypeVO findByPrimaryKeybyCostypeVO(Integer cosTypeNo);
		public List<CostypeVO> getAll();
		//查詢某課程編號的課程明細(一對多)(回傳 Set)
		public Set<CosVO> findByPrimaryKeybyCosVO(Integer cosTypeNo);
		
}
