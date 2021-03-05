package com.followlist.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.followlist.model.FollowListService;
import com.followlist.model.FollowListVO;

public class FollowListServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
//		if("insert".equals(action)) {
//			List<String> errorMsgs = new LinkedList<String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//			Integer memNo = new Integer(req.getParameter("memNo"));
//			if (memNo == null || memNo == 0) {
//				errorMsgs.add("請填入有效會員編號!");
//			}
//			Integer desNo = new Integer(req.getParameter("desNo"));
//			if (desNo == null || desNo == 0) {
//				errorMsgs.add("請填入有效設計師編號!");
//			}else if(memNo == desNo) {
//				errorMsgs.add("自己不能追蹤自己");
//			}
//			
//			FollowListVO followListVo = new FollowListVO();
//			followListVo.setMemNo(memNo);
//			followListVo.setDesNo(desNo);
//			
//			FollowListService followListSvc = new FollowListService();
//			followListSvc.addFollow(memNo, desNo);
//			
//			String url = "/back-end/FollowList/listAllFollowList.jsp";
//			RequestDispatcher successView = req.getRequestDispatcher(url);
//			successView.forward(req, res);
//		}
		
		if("insertByAJAX".equals(action)) {
			Integer memNo = new Integer (req.getParameter("memNo"));
			Integer desNo = new Integer (req.getParameter("desNo"));
			
			FollowListVO followListVo = new FollowListVO();
			followListVo.setMemNo(memNo);
			followListVo.setDesNo(desNo);
			
			FollowListService followListSvc = new FollowListService();
			followListSvc.addFollow(memNo, desNo);
			
			res.setContentType("text/plain; UTF-8");
			PrintWriter out = res.getWriter();
			out.write("追蹤成功");
			out.flush();
			out.close();
		}
	}

}
