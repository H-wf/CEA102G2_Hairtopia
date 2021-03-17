package com.trenddescription.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trenddescription.model.TrenddescService;
import com.trenddescription.model.TrenddescVO;

/**
 * Servlet implementation class TrenddescServlet
 */

public class TrenddescServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public TrenddescServlet() {
        super();
     
    }


    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Integer treNo = new Integer(req.getParameter("treNo"));
			if (treNo == null || treNo == 0) {
				errorMsgs.add("請填入有效風格誌編號!");
			}
			Integer postNo = new Integer(req.getParameter("postNo"));
			if (postNo == null || postNo == 0) {
				errorMsgs.add("請填入有效貼文編號!");
			}
			
			TrenddescVO trenddescVo = new TrenddescVO();
			trenddescVo.setTreNo(treNo);
			trenddescVo.setPostNo(postNo);
			
			TrenddescService trenddescSvc = new TrenddescService();
			trenddescSvc.addTrenddesc(treNo,postNo);
			
			String url = "/back-end/Trenddesc/listAllTrenddesc.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			
		
		}
	}

}
