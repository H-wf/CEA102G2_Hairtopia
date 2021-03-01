package com.postrep.model;

import java.util.List;

import com.postrep.model.PostrepVO;

public class PostrepService {
	private PostrepDAO_Interface dao;
	
	public PostrepService() {
		dao = new PostrepDAO();
	}
	
	public PostrepVO addPostrep(Integer postNo,Integer memNo,String postRepCon) {
		PostrepVO postrepVo = new PostrepVO();
		
		postrepVo.setPostNo(postNo);
		postrepVo.setMemNo(memNo);
		postrepVo.setPostRepCon(postRepCon);
		
		dao.insert(postrepVo);
		
		return postrepVo;
	}
	
	public List<PostrepVO> getAll() {
		return dao.getAll();
	}
}
