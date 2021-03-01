package com.comrep.model;

import java.util.List;


public interface ComrepDAO_Interface {
	
	public void insert(ComrepVO comrepVo);
    public void update(ComrepVO comrepVo);
    public void delete(Integer crepNo);
    public ComrepVO findByPrimaryKey(Integer crepNo);
    public List<ComrepVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map);

}
