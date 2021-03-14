package com.tagdet.model;

import java.util.*;


public interface TagdetDAO_Interface {
	public void insert(TagdetVO tagdetVo);
    public void update(TagdetVO tagdetVo);
    public void delete(Integer tagdetNo);
    public Set<Integer> findByPostNo(Integer tagdetNo);
    public List<TagdetVO> getAll();
    public Set<Integer> searchPostNo(Integer tagNo);

    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map);
}
