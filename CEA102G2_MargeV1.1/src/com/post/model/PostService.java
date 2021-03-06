package com.post.model;

import java.util.*;

import com.designer.model.*;

public class PostService {
	private PostDAO_Interface dao;

	public PostService() {
		dao = new PostDAO();
	}

	public PostVO addPost(Integer desNo, String postCon, byte[] postPic1, byte[] postPic2, byte[] postPic3,
			Integer postStatus) {
		PostVO postVO = new PostVO();

		postVO.setDesNo(desNo);
		postVO.setPostCon(postCon);
		postVO.setPostPic1(postPic1);
		postVO.setPostPic2(postPic2);
		postVO.setPostPic3(postPic3);
		postVO.setPostStatus(postStatus);

		postVO = dao.insert(postVO);

		return postVO;
	}

	public PostVO addPost(Integer desNo, String postCon, byte[] postPic1, byte[] postPic2, Integer postStatus) {
		PostVO postVO = new PostVO();

		postVO.setDesNo(desNo);
		postVO.setPostCon(postCon);
		postVO.setPostPic1(postPic1);
		postVO.setPostPic2(postPic2);
		postVO.setPostStatus(postStatus);

		postVO = dao.insert2(postVO);

		return postVO;
	}

	public PostVO addPost(Integer desNo, String postCon, byte[] postPic1, Integer postStatus) {
		PostVO postVO = new PostVO();

		postVO.setDesNo(desNo);
		postVO.setPostCon(postCon);
		postVO.setPostPic1(postPic1);
		postVO.setPostStatus(postStatus);

    postVO = dao.insert3(postVO);

		return postVO;
	}

	public PostVO updatePost(Integer postNo, Integer desNo, String postCon, byte[] postPic1, byte[] postPic2,
			byte[] postPic3, Integer postStatus, Boolean postPror) {
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
	public PostVO updatePost(Integer postNo, String postCon) {
		PostVO postVO = new PostVO();
		
		postVO.setPostNo(postNo);
		postVO.setPostCon(postCon);
		dao.updateAJAX(postVO);
		
		postVO = dao.findByPrimaryKey(postNo);
		
		postVO.setPostPic1(new byte[0]);
		if(postVO.getPostPic2() != null) {
			postVO.setPostPic2(new byte[0]);
		}else if(postVO.getPostPic3() != null) {
			postVO.setPostPic3(new byte[0]);
		}
		
		return postVO;
	}

	public PostVO updatePost(Integer postNo, Integer desNo, String postCon, byte[] postPic1, byte[] postPic2,
			Integer postStatus, Boolean postPror) {
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

	public PostVO updatePost(Integer postNo, Integer desNo, String postCon, byte[] postPic1, Integer postStatus,
			Boolean postPror) {
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

	public PostVO updatePost(Integer postNo, Integer desNo, String postCon, Integer postStatus, Boolean postPror) {
		PostVO postVO = new PostVO();

		postVO.setPostNo(postNo);
		postVO.setPostCon(postCon);
		postVO.setPostStatus(postStatus);
		postVO.setPostPror(postPror);
		dao.update(postVO);
		postVO = dao.findByPrimaryKey(postNo);

		return postVO;
	}

	public void deletePost(Integer postNo,Integer postStatus) {
		dao.delete(postNo,postStatus);
	}

	public PostVO getOnePost(Integer postNo) {
		PostVO postVo = dao.findByPrimaryKey(postNo);
		String desName = new DesignerService().getOneDesByDesNo(postVo.getDesNo()).getDesName();
		postVo.setDesName(desName);
		return postVo;
	}

	public List<PostVO> getAll() {
		return dao.getAll();
	}

	public Set<PostVO> pickup5Post() {
		Set<PostVO> rePost = new HashSet<PostVO>();
		try {
			List<PostVO> allPost = dao.getAll();
			Set<Integer> index = new HashSet<Integer>();

			while (index.size() < 5) {
				int x = (int) (Math.random() * allPost.size());
				index.add(x);
			}
			while (rePost.size() < 5) {
				for (Integer y : index) {
					rePost.add(allPost.get(y));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rePost;
	}

	public List<PostVO> getAll(Integer desNo) {
		return dao.getAll(desNo);
	}

}
