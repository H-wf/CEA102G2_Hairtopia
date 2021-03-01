package com.postrep.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

import com.postrep.model.PostrepService;
import com.postrep.model.PostrepVO;

public class PostrepServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				Integer postNo = new Integer(req.getParameter("postNo"));
				Integer memNo = new Integer(req.getParameter("memNo"));
				String postRepCon = req.getParameter("postRepCon");
				if (postRepCon == null || postRepCon.trim().length() == 0) {
					errorMsgs.add("檢舉內容請勿空白");
				}
				
				PostrepVO postrepVo = new PostrepVO();
				postrepVo.setPostNo(postNo);
				postrepVo.setMemNo(memNo);
				postrepVo.setPostRepCon(postRepCon);
				
				PostrepService prepSvc = new PostrepService();
				postrepVo = prepSvc.addPostrep(postNo, memNo, postRepCon);
				
				String url = "/back-end/listAllPostRep.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}

}
