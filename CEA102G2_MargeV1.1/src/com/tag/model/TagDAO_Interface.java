package com.tag.model;

import java.util.List;

public interface TagDAO_Interface {
	public TagVO insert(TagVO tagVo);
    public void update(TagVO tagVo);
    public void delete(Integer tagNo);
    public String findByTagNo(Integer tagNo);
    public Integer findByTagName(String tagName);
    public List<TagVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map);
}
