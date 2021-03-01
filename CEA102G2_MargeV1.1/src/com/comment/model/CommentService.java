package com.comment.model;

import java.util.List;


public class CommentService {

	CommentDAO_Interface dao;
	
	public CommentService() {
		dao = new CommentDAO();
	}
	
	public CommentVO addComment(Integer postNo,Integer memNo, String comCon) {
		CommentVO commentVo = new CommentVO();
		
		commentVo.setPostNo(postNo);
		commentVo.setMemNo(memNo);
		commentVo.setComCon(comCon);
		
		dao.insert(commentVo);
		
		return commentVo;
	}
	
	public List<CommentVO> getAll() {
		return dao.getAll();
	}
	
	public List<CommentVO> getComsByPostNo(Integer postNo) {
		System.out.println("回傳留言");
		return dao.getComsByPostNo(postNo);
	}
	
	
	public CommentVO updateComment(Integer comNo,String comCon) {
		
		CommentVO commentVo = new CommentVO();
		
		commentVo.setComNo(comNo);
		commentVo.setComCon(comCon);
		
		dao.update(commentVo);
		
		return commentVo;
	}
	
	public void deleteComment(CommentVO commentVo) {
		dao.delete(commentVo);
	}
}
