package com.followlist.model;

import java.util.List;


public interface FollowListDAO_Interface {
	
	public void insert(FollowListVO followListVo);
    public void update(FollowListVO followListVo);
    public void delete(Integer memNO,Integer desNo);
    public Boolean findByPrimaryKey(Integer memNO,Integer desNo);
    public List<FollowListVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map);

}
