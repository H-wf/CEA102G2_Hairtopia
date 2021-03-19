package com.comment.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.comment.model.CommentService;
import com.comment.model.CommentVO;
import com.post.model.PostService;
import com.post.model.PostVO;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


public class CommentServlet extends HttpServlet {
	Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd hh:mm:ss").create();
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("insert".equals(action) || "insert_Front".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Integer postNo = new Integer(req.getParameter("postNo"));
			if (postNo == null || postNo == 0) {
				errorMsgs.add("請填入有效貼文編號!");
			}
			
			Integer memNo = new Integer(req.getParameter("memNo"));
			if (memNo == null || memNo == 0) {
				errorMsgs.add("請填入有效會員編號!");
			}
			
			String comCon = req.getParameter("comCon");
			if (comCon == null || comCon.trim().length() == 0) {
				errorMsgs.add("留言內容請勿空白!");
			}
			
			CommentVO commentVo = new CommentVO();
			commentVo.setPostNo(postNo);
			commentVo.setMemNo(memNo);
			commentVo.setComCon(comCon);
			
			CommentService commentSvc = new CommentService();
			commentSvc.addComment(postNo,memNo,comCon);
			
			PostService postSvc = new PostService();
			PostVO postVO = postSvc.getOnePost(postNo);
			
			req.setAttribute("postVO", postVO);
			
			String url="";
			
			if("insert".equals(action)) {
				url = "/back-end/Post/listPostWithComments.jsp";
			}else if("insert_Front".equals(action)) {
				url = "/post/post.do?postNo="+postNo+"&action=Display_fromListAll";
			}
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		
		if("update_Comment".equals(action) || "update_Comment_Front".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Integer postNo = new Integer(req.getParameter("postNo"));
			
			String comCon = req.getParameter("comCon");
			if (comCon == null || comCon.trim().length() == 0) {
				errorMsgs.add("留言內容請勿空白!");
			}
			Integer comNo = new Integer(req.getParameter("comNo"));
			if (comNo == null || comNo == 0) {
				errorMsgs.add("請填入有效貼文編號!");
			}
			
			CommentVO commentVo = new CommentVO();
			commentVo.setPostNo(comNo);
			commentVo.setComCon(comCon);
			
			CommentService commentSvc = new CommentService();
			commentSvc.updateComment(comNo, comCon);
			
			PostService postSvc = new PostService();
			PostVO postVO = postSvc.getOnePost(postNo);
			
			req.setAttribute("postVO", postVO);
			
			String url = "";
			if("update_Comment".equals(action)) {
				url = "/back-end/Post/listPostWithComments.jsp";
			}else if("update_Comment_Front".equals(action)) {
				url = "/front-end/Post/listPostWithComments_front.jsp";
			}
			
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		

		
		if("delete_Comment".equals(action) || "delete_Comment_Front".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Integer postNo = new Integer(req.getParameter("postNo"));
			
			Integer comNo = new Integer(req.getParameter("comNo"));
			if (comNo == null || comNo == 0) {
				errorMsgs.add("請填入有效貼文編號!");
			}
			Boolean comStatus = new Boolean(req.getParameter("comStatus"));
			
			CommentVO commentVo = new CommentVO();
			commentVo.setComNo(comNo);
			commentVo.setComStatus(comStatus);
			
			CommentService commentSvc = new CommentService();
			commentSvc.deleteComment(commentVo);
			
			PostService postSvc = new PostService();
			PostVO postVO = postSvc.getOnePost(postNo);
			
			req.setAttribute("postVO", postVO);
			
			String url ="";
			
			if("delete_Comment".equals(action)) {
				url = "/back-end/Post/listPostWithComments.jsp";
			}else if("delete_Comment_Front".equals(action)) {
				url = "/front-end/Post/listPostWithComments_front.jsp";
			}
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			
		}
		
		if("addComByAJAX".equals(action)) {
			Integer postNo = new Integer(req.getParameter("postNo"));
			
			Integer memNo = new Integer(req.getParameter("userSessionNo"));
			
			String comCon = req.getParameter("comCon");
			
			CommentVO commentVo = new CommentVO();
			commentVo.setPostNo(postNo);
			commentVo.setMemNo(memNo);
			commentVo.setComCon(comCon);
			
			CommentService commentSvc = new CommentService();
			CommentVO comVoAJAX = commentSvc.addComment(postNo,memNo,comCon);
			String jsonStr = gson.toJson(comVoAJAX);
System.out.println(jsonStr);
			res.setContentType("text/plain");
			res.setCharacterEncoding("UTF-8");
			PrintWriter out = res.getWriter();
			out.print(jsonStr);
			out.flush();
			out.close();
			return;
		}
		
	}

}
