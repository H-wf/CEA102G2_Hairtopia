package com.tagdet.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tagdet.model.TagdetService;
import com.tagdet.model.TagdetVO;


public class TagdetServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Integer tagNo = new Integer(req.getParameter("tagNo"));
			if (tagNo == null || tagNo == 0) {
				errorMsgs.add("請填入有效標籤編號!");
			}
			Integer postNo = new Integer(req.getParameter("postNo"));
			if (postNo == null || postNo == 0) {
				errorMsgs.add("請填入有效貼文編號!");
			}
			
			TagdetVO tagdetVo = new TagdetVO();
			tagdetVo.setTagNo(tagNo);
			tagdetVo.setPostNo(postNo);
			
			TagdetService tagsetSvc = new TagdetService();
			tagsetSvc.addTagdet(tagNo,postNo);
			
			String url = "/back-end/Tag/listAllTagdet.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			
		
		}
	}

}
