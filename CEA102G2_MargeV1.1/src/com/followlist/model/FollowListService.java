package com.followlist.model;

import java.util.List;


public class FollowListService {
	
	FollowListDAO_Interface dao;
	
	public FollowListService() {
		dao = new FollowListDAO();
	}

	public FollowListVO addFollow(Integer memNo,Integer desNo) {
		FollowListVO followListVo = new FollowListVO();
		
		followListVo.setMemNo(memNo);
		followListVo.setDesNo(desNo);
		
		dao.insert(followListVo);
		
		return followListVo;
	}
	
	public List<FollowListVO> getAll() {
		return dao.getAll();
	}
	
	public Boolean isfollowing(Integer memNo,Integer desNo) {
		return dao.findByPrimaryKey(memNo, desNo);
	}
	
	public void deleteFollow(Integer memNo,Integer desNo) {
		dao.delete(memNo, desNo);
	}
}
