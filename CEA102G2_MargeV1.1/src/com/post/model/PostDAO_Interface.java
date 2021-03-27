package com.post.model;

import java.util.List;

public interface PostDAO_Interface {
	public PostVO insert(PostVO postVo);	//insert a post with 3 pic
    public void delete(Integer postNo,Integer postStatus);
    public PostVO findByPrimaryKey(Integer postNo);
    public List<PostVO> getAll(Integer desNo);
    public List<PostVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map);
	public PostVO insert2(PostVO postVO);	//insert a post with 2 pic
	public PostVO insert3(PostVO postVO);	//insert a post with 1 pic
	public void update(PostVO postVo);	//修改一張照片
	public void update2(PostVO postVo);	//修改兩張照片
	public void update3(PostVO postVo);	//修改三張照片
	public void update4(PostVO postVo);// for 檢舉隱藏貼文
	public PostVO updateAJAX(PostVO postVo);// for 檢舉隱藏貼文
//	public List<PostVO> getAllByAJAX(String keyword); 
}
