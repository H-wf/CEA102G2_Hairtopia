package com.post.model;

import java.util.*;



public class PostService {
	private PostDAO_Interface dao;
	
	public PostService(){
		dao = new PostDAO();
	}
	
	public PostVO addPost(Integer desNo,String postCon,byte[] postPic1,byte[] postPic2, byte[] postPic3,Integer postStatus,Boolean postPror) {
		PostVO postVO = new PostVO();
		
		postVO.setDesNo(desNo);
		postVO.setPostCon(postCon);
		postVO.setPostPic1(postPic1);
		postVO.setPostPic2(postPic2);
		postVO.setPostPic3(postPic3);
		postVO.setPostStatus(postStatus);
		postVO.setPostPror(postPror);
		
		
		postVO = dao.insert(postVO);
		
		return postVO;
	}
	public PostVO addPost(Integer desNo,String postCon,byte[] postPic1,byte[] postPic2,Integer postStatus,Boolean postPror) {
		PostVO postVO = new PostVO();
		
		postVO.setDesNo(desNo);
		postVO.setPostCon(postCon);
		postVO.setPostPic1(postPic1);
		postVO.setPostPic2(postPic2);
		postVO.setPostStatus(postStatus);
		postVO.setPostPror(postPror);
		
		
		postVO = dao.insert2(postVO);
		
		return postVO;
	}
	public PostVO addPost(Integer desNo,String postCon,byte[] postPic1,Integer postStatus,Boolean postPror) {
		PostVO postVO = new PostVO();
		
		postVO.setDesNo(desNo);
		postVO.setPostCon(postCon);
		postVO.setPostPic1(postPic1);
		postVO.setPostStatus(postStatus);
		postVO.setPostPror(postPror);
		
		
		postVO = dao.insert3(postVO);
		
		return postVO;
	}
	
	public PostVO updatePost(Integer postNo,Integer desNo,String postCon,byte[] postPic1,byte[] postPic2, byte[] postPic3,Integer postStatus,Boolean postPror) {
		PostVO postVO = new PostVO();
		
		postVO.setPostNo(postNo);
		postVO.setDesNo(desNo);
		postVO.setPostCon(postCon);
		postVO.setPostPic1(postPic1);
		postVO.setPostPic2(postPic2);
		postVO.setPostPic3(postPic3);
		postVO.setPostStatus(postStatus);
		postVO.setPostPror(postPror);
		dao.update(postVO);
		
		return postVO;
	}
	public PostVO updatePost(Integer postNo,Integer desNo,String postCon,byte[] postPic1,byte[] postPic2, Integer postStatus,Boolean postPror) {
		PostVO postVO = new PostVO();
		
		postVO.setPostNo(postNo);
		postVO.setDesNo(desNo);
		postVO.setPostCon(postCon);
		postVO.setPostPic1(postPic1);
		postVO.setPostPic2(postPic2);
		postVO.setPostStatus(postStatus);
		postVO.setPostPror(postPror);
		dao.update(postVO);
		
		return postVO;
	}
	public PostVO updatePost(Integer postNo,Integer desNo,String postCon,byte[] postPic1,Integer postStatus,Boolean postPror) {
		PostVO postVO = new PostVO();
		
		postVO.setPostNo(postNo);
		postVO.setDesNo(desNo);
		postVO.setPostCon(postCon);
		postVO.setPostPic1(postPic1);
		postVO.setPostStatus(postStatus);
		postVO.setPostPror(postPror);
		dao.update(postVO);
		
		return postVO;
	}
	public PostVO updatePost(Integer postNo,Integer desNo,String postCon,Integer postStatus,Boolean postPror) {
		PostVO postVO = new PostVO();
		
		postVO.setPostNo(postNo);
		postVO.setPostCon(postCon);
		postVO.setPostStatus(postStatus);
		postVO.setPostPror(postPror);
		dao.update(postVO);
		postVO=dao.findByPrimaryKey(postNo);
		
		return postVO;
	}
	
	
	
	public void deletePost(Integer postNo) {
		dao.delete(postNo);
	}
	
	public PostVO getOnePost(Integer postNo) {
		return dao.findByPrimaryKey(postNo);
	}
	
	public List<PostVO> getAll() {
		return dao.getAll();
	}
	
	public Set<PostVO> pickup5Post() {
		List<PostVO> allPost = dao.getAll();
		Set<PostVO> rePost = new HashSet<PostVO>();
		Set<Integer> index = new HashSet<Integer>();
		
		while(index.size()<5){
			int x = (int) (Math.random()*allPost.size());
			index.add(x);
		}
		while(rePost.size()<5) {
			for(Integer y:index) {
				rePost.add(allPost.get(y));
			}
		}
		return rePost;
	}
	public List<PostVO> getAll(Integer desNo) {
		return dao.getAll(desNo);
	}
	
}
