package com.postrep.model;

import java.util.List;

import com.postrep.model.PostrepVO;

public interface PostrepDAO_Interface {
	
	public void insert(PostrepVO postrepVo);
    public void update(PostrepVO postrepVo);
    public void delete(Integer postrepNo);
    public PostrepVO findByPrimaryKey(Integer postrepNo);
    public List<PostrepVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map);
    
}
