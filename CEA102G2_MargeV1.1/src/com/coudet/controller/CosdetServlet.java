package com.coudet.controller;

import java.io.*;

import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import javax.servlet.http.Part;

import com.coudet.model.CosdetService;
import com.coudet.model.CosdetVO;

@MultipartConfig

public class CosdetServlet extends HttpServlet {

		public void doGet(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {
			doPost(req, res);
		}

		public void doPost(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {

			req.setCharacterEncoding("UTF-8");
			String action = req.getParameter("action");
			
			
			if ("getOne_For_Display".equals(action)) {

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					String str = req.getParameter("cosNo");
					if (str == null || (str.trim()).length() == 0) {
						errorMsgs.add("getOne_For_Display：cosNo無法轉成str");
					}
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cosdetail/select_cosdetail_page.jsp");
						failureView.forward(req, res);
						return;
					}
					
					Integer cosNo = null;
					try {
						cosNo = new Integer(str);
					} catch (Exception e) {
						errorMsgs.add("getOne_For_Display：str無法變成包裝型別cosNo");
					}
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cosdetail/select_cosdetail_page.jsp");
						failureView.forward(req, res);
						return;
					}
					
					CosdetService cosdetSvc = new CosdetService();
					CosdetVO cosdetVO = cosdetSvc.getOneCosDet(cosNo);
					if (cosdetVO == null) {
						errorMsgs.add("getOne_For_Display：cosdetVO為null");
					}
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cosdetail/select_cosdetail_page.jsp");
						failureView.forward(req, res);
						return;
					}

					req.setAttribute("cosdetVO", cosdetVO);
					String url = "/back-end/Cosdetail/listOneCosdetail.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

				} catch (Exception e) {
					errorMsgs.add("getOne_For_Display：有errorMsgs發生" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cosdetail/select_cosdetail_page.jsp");
					failureView.forward(req, res);
				}
			}
			
			if ("getOne_For_Update".equals(action)){

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					Integer cosNo = new Integer(req.getParameter("cosNo"));
//					System.out.println(cosTypeNo);

					CosdetService cosdetSvc = new CosdetService();
					CosdetVO cosdetVO = cosdetSvc.getOneCosDet(cosNo);

					req.setAttribute("cosdetVO", cosdetVO);
					String url = "/back-end/Cosdetail/update_cosdetail_input.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);
				} catch (Exception e) {
					errorMsgs.add("getOne_For_Update：有errorMsgs發生" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cosdetail/listAllCosdetail.jsp");
					failureView.forward(req, res);
				}
			}
			
			if ("update".equals(action)){
				
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
			
				try {
					Integer cosNo = new Integer(req.getParameter("cosNo").trim());
					
					Integer memNo = null;
					try {
						memNo = new Integer(req.getParameter("memNo").trim());
					} catch (NumberFormatException e) {
						memNo = 0;
						errorMsgs.add("update：memNo出現NumberFormatException");
					}
					
					String cosComment = req.getParameter("cosComment");
					if (cosComment == null || cosComment.trim().length() == 0) {
						errorMsgs.add("update：cosComment出現null");
					}			
					
					Integer cosDetailPrice = null;
					try {
						cosDetailPrice = new Integer(req.getParameter("cosDetailPrice").trim());
					} catch (NumberFormatException e) {
						cosDetailPrice = 0;
						errorMsgs.add("update：cosDetailPrice出現NumberFormatException");
					}					
					
					CosdetVO cosdetVO = new CosdetVO();
					cosdetVO.setCosNo(cosNo);
					cosdetVO.setMemNo(memNo);
					cosdetVO.setCosComment(cosComment);
					cosdetVO.setCosDetailPrice(cosDetailPrice);
					

					if (!errorMsgs.isEmpty()) {
						req.setAttribute("cosdetVO", cosdetVO);
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cosdetail/update_cosdetail_input.jsp");
						failureView.forward(req, res);
						return;
					}
					
					CosdetService cosdetSvc = new CosdetService();
					
					cosdetVO = cosdetSvc.updateCosDet(cosNo, cosComment, cosDetailPrice, memNo);
							
					req.setAttribute("cosdetVO", cosdetVO);
					String url = "/back-end/Cosdetail/listOneCosdetail.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

				} catch (Exception e) {
					errorMsgs.add("update：有errorMsgs發生"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cosdetail/update_cosdetail_input.jsp");
					failureView.forward(req, res);
				}
			}
			
	        if ("insert".equals(action)){ 
				
				List<String> errorMsgs = new LinkedList<String>();
				
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					Integer cosNo = null;
					try {
						cosNo = new Integer(req.getParameter("cosNo").trim());
					} catch (NumberFormatException e) {
						cosNo= 0;
						errorMsgs.add("insert：cosNo出現NumberFormatException");
					}
					
					Integer memNo = null;
					try {
						memNo = new Integer(req.getParameter("memNo").trim());
					} catch (NumberFormatException e) {
						memNo = 0;
						errorMsgs.add("insert：memNo出現NumberFormatException");
					}
					
					String cosComment = req.getParameter("cosComment");
					if (cosComment == null || cosComment.trim().length() == 0) {
						errorMsgs.add("insert：cosComment出現null");
					}			
					
					Integer cosDetailPrice = null;
					try {
						cosDetailPrice = new Integer(req.getParameter("cosDetailPrice").trim());
					} catch (NumberFormatException e) {
						cosDetailPrice = 0;
						errorMsgs.add("insert：cosDetailPrice出現NumberFormatException");
					}
					
					CosdetVO cosdetVO = new CosdetVO();
					cosdetVO.setCosNo(cosNo);
					cosdetVO.setMemNo(memNo);
					cosdetVO.setCosComment(cosComment);
					cosdetVO.setCosDetailPrice(cosDetailPrice);
					
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("cosdetVO", cosdetVO);
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cosdetail/addCosdetail.jsp");
						failureView.forward(req, res);
						return;
					}
					
					CosdetService cosdetSvc = new CosdetService();
					cosdetVO = cosdetSvc.insertCosDet(cosNo, memNo, cosComment, cosDetailPrice);
					String url = "/back-end/Cosdetail/listAllCosdetail.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);				
				
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cosdetail/addCosdetail.jsp");
					failureView.forward(req, res);
				}
			}
			
			if ("delete".equals(action)){

				List<String> errorMsgs = new LinkedList<String>();

				req.setAttribute("errorMsgs", errorMsgs);
		
				try {
					Integer cosNo = new Integer(req.getParameter("cosNo"));
					
					CosdetService cosdetSvc = new CosdetService();
					cosdetSvc.deleteCosDet(cosNo);
												
					String url = "/back-end/Cosdetail/listAllCosdetail.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

				} catch (Exception e) {
					errorMsgs.add("delete：有errorMsgs發生"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cosdetail/listAllCosdetail.jsp");
					failureView.forward(req, res);
				}
			}
		}
	}


