package com.comment.model;

import java.util.List;

import com.member.model.*;


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
		
		Integer new_comNo = dao.insert(commentVo);
		
		commentVo=dao.getOneCom(new_comNo);
		String memName = new MemService().getOneMemName(commentVo.getMemNo());
		commentVo.setMemName(memName);
		
		return commentVo;
	}
	
	public List<CommentVO> getAll() {
		return dao.getAll();
	}
	
	public List<CommentVO> getComsByPostNo(Integer postNo) {
		List<CommentVO> listComVO = dao.getComsByPostNo(postNo);
		
		for(CommentVO comVo : listComVO) {
			String memName = new MemService().getOneMemName(comVo.getMemNo());
			comVo.setMemName(memName);
		}
		
		return listComVO;
	}
	
	
	public CommentVO updateComment(Integer comNo,String comCon) {
		
		CommentVO commentVo = new CommentVO();
		
		commentVo.setComNo(comNo);
		commentVo.setComCon(comCon);
		
		dao.update(commentVo);
		
		commentVo = dao.getOneCom(comNo);
		
		return commentVo;
	}
	
	public void deleteComment(CommentVO commentVo) {
		dao.delete(commentVo);
	}
}
