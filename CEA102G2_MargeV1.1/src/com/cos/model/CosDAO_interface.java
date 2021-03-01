package com.cos.model;

import java.util.List;
import java.util.Map;

public interface CosDAO_interface {
	public void insert(CosVO cosVO);
	public void update(CosVO cosVO);
	public void updateNoPic(CosVO cosVO);
	public void updateCosStatus(CosVO cosVO);//目標：讓系統自動改變課程狀態 (目前未完成)
	public void delete(Integer cosNo);
	public CosVO findByPrimaryKey(Integer cosNo);
	public List<CosVO> getAllCosApplyFrom();
	public List<CosVO> getAll();
    public List<CosVO> getAll(Map<String, String[]> map);//萬用複合查詢(傳入參數型態Map)(回傳 List)
}
