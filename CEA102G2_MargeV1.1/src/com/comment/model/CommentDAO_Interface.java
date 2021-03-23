package com.comment.model;

import java.util.List;


public interface CommentDAO_Interface {

	public Integer insert(CommentVO commentVo);
    public void update(CommentVO commentVo);
    public void delete(CommentVO commentVo);
    public List<CommentVO> getComsByPostNo(Integer postNo);
    public List<CommentVO> getAll();
    public CommentVO getOneCom(Integer comNo);
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map);
}
