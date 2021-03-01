package com.comrep.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.comrep.model.ComrepService;
import com.comrep.model.ComrepVO;

public class ComrepServlet extends HttpServlet {


	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Integer comNo = new Integer(req.getParameter("comNo"));
			if (comNo == null || comNo == 0) {
				errorMsgs.add("請填入有效貼文編號!");
			}
			
			Integer memNo = new Integer(req.getParameter("memNo"));
			if (memNo == null || memNo == 0) {
				errorMsgs.add("請填入有效會員編號!");
			}
			
			String crepCon = req.getParameter("crepCon");
			if (crepCon == null || crepCon.trim().length() == 0) {
				errorMsgs.add("檢舉內容請勿空白!");
			}
			
			ComrepVO comrepVo = new ComrepVO();
			comrepVo.setComNo(comNo);
			comrepVo.setMemNo(memNo);
			comrepVo.setCrepCon(crepCon);
			
			ComrepService ComrepSvc = new ComrepService();
			ComrepSvc.addComrep(comNo, memNo, crepCon);
			
			String url = "/back-end/Comment/listAllComRep.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
	}

}
