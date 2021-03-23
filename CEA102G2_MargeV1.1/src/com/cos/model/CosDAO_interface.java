package com.cos.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.coudet.model.CosdetVO;

public interface CosDAO_interface {
	public void insert(CosVO cosVO);
	public void update(CosVO cosVO);
	public void updateNoPic(CosVO cosVO);
	public void delete(Integer cosNo);
	public CosVO findByPrimaryKey(Integer cosNo);
	public List<CosVO> getAll();
	public List<CosVO> getAllCosApplyFrom();
    public List<CosVO> getAll(Map<String, String[]> map);//萬用複合查詢(傳入參數型態Map)(回傳 List)
    public List<CosVO> getAllCosFrom();
    public void AddCountApplyNo(CosVO cosVO);
    public CosVO FindCountApplyNo(Integer cosNo);
    public CosdetVO getAvgCosRateByCosNo(Integer cosNo);
    
}
