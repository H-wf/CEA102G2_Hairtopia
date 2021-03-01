package com.comment.model;

import java.util.List;


public interface CommentDAO_Interface {

	public void insert(CommentVO commentVo);
    public void update(CommentVO commentVo);
    public void delete(CommentVO commentVo);
    public List<CommentVO> getComsByPostNo(Integer postNo);
    public List<CommentVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map);
}
