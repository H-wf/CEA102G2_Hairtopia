package com.tag.controller;

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

import com.google.gson.Gson;

import com.designer.model.DesignerService;
import com.tag.model.TagService;
import com.tag.model.TagVO;

public class TagServlet extends HttpServlet {
	Gson gson = new Gson();
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			String tagName = req.getParameter("tagName");
			if (tagName == null || tagName.trim().length() == 0) {
				errorMsgs.add("標籤內容請勿空白");
			}
			TagVO tagVo = new TagVO();
			tagVo.setTagName(tagName);
			
			TagService tagSvc = new TagService();
			tagSvc.addTag(tagName);
			
			String url = "/back-end/Tag/listAllTag.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			
		}
		
		if("update_Tag".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Integer tagNo = new Integer(req.getParameter("tagNo"));
			if(tagNo == null ||tagNo == 0) {
				errorMsgs.add("請輸入標籤編號");
			}
			
			String tagName = req.getParameter("tagName");
			if (tagName == null || tagName.trim().length() == 0) {
				errorMsgs.add("標籤內容請勿空白");
			}
			
			TagVO tagVo = new TagVO();
			tagVo.setTagNo(tagNo);
			tagVo.setTagName(tagName);
			
			TagService tagSvc = new TagService();
			tagSvc.updateTag(tagNo, tagName);
			
			String url = "/back-end/Tag/listAllTag.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		
		if("delete_Tag".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Integer tagNo = new Integer(req.getParameter("tagNo"));
			if(tagNo == null ||tagNo == 0) {
				errorMsgs.add("請輸入標籤編號");
			}
			
			TagService tagSvc = new TagService();
			tagSvc.deleteTag(tagNo);
			
			String url = "/back-end/Tag/listAllTag.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		
		if ("serchByAjax".equals(action)) { // 來自listAllEmp.jsp


						
						/***************************1.接收請求參數***************************************/
						String keyWord = (req.getParameter("keyWord"));
						/***************************2.開始查資料***************************************/
						TagService tagSvc = new TagService();
						List<String> ajaxList= tagSvc.getTagAJAX(keyWord);
				
						String jsonStr = gson.toJson(ajaxList);
			for(String s:ajaxList){
				
			}
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
