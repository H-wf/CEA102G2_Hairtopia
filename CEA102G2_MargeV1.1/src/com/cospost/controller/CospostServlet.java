package com.cospost.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.cospost.model.CospostService;
import com.cospost.model.CospostVO;

public class CospostServlet extends HttpServlet {

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
					
					String str = req.getParameter("cosPubNo");

					if (str == null || (str.trim()).length() == 0) {
						errorMsgs.add("getOne_For_Display：cosPubNo無法轉成str");
					}

					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cospost/select_cospost_page.jsp");
						failureView.forward(req, res);
						return;
					}
					
					Integer cosPubNo = null;
					try {
						cosPubNo = new Integer(str);
					} catch (Exception e) {
						errorMsgs.add("getOne_For_Display：str無法變成包裝型別cosPubNo");
					}
					
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cospost/select_cospost_page.jsp");
						failureView.forward(req, res);
						return;
					}

					CospostService cospostSvc = new CospostService();
					CospostVO cospostVO = cospostSvc.getOneCosPost(cosPubNo);
					if (cospostVO == null) {
						errorMsgs.add("getOne_For_Display：cospostVO為null");
					}

					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cospost/select_cospost_page.jsp");
						failureView.forward(req, res);
						return;
					}

					req.setAttribute("cospostVO", cospostVO);
					String url = "/back-end/Cospost/listOneCospost.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

				} catch (Exception e) {
					errorMsgs.add("getOne_For_Display：有errorMsgs發生" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cospost/select_cospost_page.jsp");
					failureView.forward(req, res);
				}
			}

			if ("getOne_For_Update".equals(action)) {

				List<String> errorMsgs = new LinkedList<String>();

				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					Integer cosPubNo = new Integer(req.getParameter("cosPubNo"));

					CospostService cospostSvc = new CospostService();
					CospostVO cospostVO = cospostSvc.getOneCosPost(cosPubNo);

					req.setAttribute("cospostVO", cospostVO);
					boolean openModal=true;
					req.setAttribute("openModal",openModal);
					String url = "/back-end/Cospost/listAllCospost.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

				} catch (Exception e) {
					errorMsgs.add("getOne_For_Update：有errorMsgs發生" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cospost/listAllCospost.jsp");
					failureView.forward(req, res);
				}
			}

			if ("update".equals(action)) {
				
				List<String> errorMsgs = new LinkedList<String>();

				req.setAttribute("errorMsgs", errorMsgs);
			
				try {
					Integer cosPubNo = new Integer(req.getParameter("cosPubNo").trim());
					
					Integer cosNo = null;
					try {
						cosNo = new Integer(req.getParameter("cosNo").trim());
					} catch (NumberFormatException e) {
						cosNo = 0;
						errorMsgs.add("update：cosNo出現NumberFormatException");
					}
					
					String cosPubCon = req.getParameter("cosPubCon");
					if (cosPubCon == null || cosPubCon.trim().length() == 0) {
						errorMsgs.add("update：cosPubCon出現null");
					}
					
					Timestamp cosPubTime = null;
					try {
						cosPubTime = java.sql.Timestamp.valueOf(req.getParameter("cosPubTime"));
					} catch (IllegalArgumentException e) {
						errorMsgs.add("update：cosPubTime出現IllegalArgumentException");
					}
					System.out.println(errorMsgs);

					CospostVO cospostVO = new CospostVO();
					cospostVO.setCosPubNo(cosPubNo);
					cospostVO.setCosNo(cosNo);
					cospostVO.setCosPubCon(cosPubCon);
					cospostVO.setCosPubTime(cosPubTime);

					if (!errorMsgs.isEmpty()) {
						req.setAttribute("cospostVO", cospostVO);
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cospost/listAllCospost.jsp");
						failureView.forward(req, res);
						return;
					}

					CospostService cospostSvc = new CospostService();
					cospostVO = cospostSvc.updateCosPost(cosNo, cosPubCon, cosPubTime, cosPubNo);

					req.setAttribute("cospostVO", cospostVO);
					String url = "/back-end/Cospost/listAllCospost.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

				} catch (Exception e) {
					errorMsgs.add("update：有errorMsgs發生"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cospost/listAllCospost.jsp");
					failureView.forward(req, res);
				}
			}

	        if ("insert".equals(action)) {
				
				List<String> errorMsgs = new LinkedList<String>();

				req.setAttribute("errorMsgs", errorMsgs);
				try {

				    Integer cosNo = new Integer(req.getParameter("cosNo"));
					String cosPubCon = req.getParameter("cosPubCon");
					if (cosPubCon == null || cosPubCon.trim().length() == 0) {
						errorMsgs.add("insert：cosPubCon出現null");
					}
					Timestamp cosPubTime = null;
					try {
						cosPubTime = java.sql.Timestamp.valueOf(req.getParameter("cosPubTime"));
					} catch (IllegalArgumentException e) {
						errorMsgs.add("insert：cosPubTime出現IllegalArgumentException");
					}

					CospostVO cospostVO = new CospostVO();
					cospostVO.setCosNo(cosNo);
					cospostVO.setCosPubCon(cosPubCon);
					cospostVO.setCosPubTime(cosPubTime);

					if (!errorMsgs.isEmpty()) {
						req.setAttribute("cospostVO", cospostVO);
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cospost/listAllCospost.jsp");
						failureView.forward(req, res);
//						System.out.println(errorMsgs);
						return;
						
					}

					CospostService cospostSvc = new CospostService();
					cospostVO = cospostSvc.insertCosPost(cosNo, cosPubCon, cosPubTime);

					String url = "/back-end/Cospost/listAllCospost.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);				

				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cospost/listAllCospost.jsp");
					failureView.forward(req, res);
				}
			}
			
			if ("delete".equals(action)) {

				List<String> errorMsgs = new LinkedList<String>();

				req.setAttribute("errorMsgs", errorMsgs);
		
				try {
					Integer cosPubNo = new Integer(req.getParameter("cosPubNo"));

					CospostService cospostSvc = new CospostService();
					cospostSvc.deleteCosPost(cosPubNo);
							
					String url = "/back-end/Cospost/listAllCospost.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

				} catch (Exception e) {
					errorMsgs.add("delete：有errorMsgs發生"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cospost/listAllCospost.jsp");
					failureView.forward(req, res);
				}
			}
		}
	}


