package com.coutype.controller;

import java.io.*;

import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import javax.servlet.http.Part;

import com.cos.model.CosVO;
import com.coutype.model.CostypeService;
import com.coutype.model.CostypeVO;

@MultipartConfig

public class CostypeServlet extends HttpServlet {

		public void doGet(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {
			doPost(req, res);
		}

		public void doPost(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {

			req.setCharacterEncoding("UTF-8");
			String action = req.getParameter("action");
			
		    // 來自select_page.jsp的請求                                  // 來自 dept/listAllDept.jsp的請求
			if ("listCos_ByCosTypeNo_A".equals(action) || "listCos_ByCosTypeNo_B".equals(action)) {

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/*************************** 1.接收請求參數 ****************************************/
					Integer cosTypeNo = new Integer(req.getParameter("cosTypeNo"));

					/*************************** 2.開始查詢資料 ****************************************/
					CostypeService costypeSvc = new CostypeService();
					Set<CosVO> set = costypeSvc.getCosByCosTypeNo(cosTypeNo);

					/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
					req.setAttribute("listCos_ByCosTypeNo", set);    // 資料庫取出的list物件,存入request

					String url = null;
					if ("listCos_ByCosTypeNo_A".equals(action))
						url = "/back-end/Costype/listCos_ByCosTypeNo.jsp";        // 成功轉交 dept/listEmps_ByDeptno.jsp
					else if ("listCos_ByCosTypeNo_B".equals(action))
						url = "/back-end/Costype/listAllCostype.jsp";              // 成功轉交 dept/listAllDept.jsp

					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

					/*************************** 其他可能的錯誤處理 ***********************************/
				} catch (Exception e) {
					throw new ServletException(e);
				}
			}
			
			
			if ("getOne_For_Display".equals(action)) {

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					String str = req.getParameter("cosTypeNo");
					if (str == null || (str.trim()).length() == 0) {
						errorMsgs.add("getOne_For_Display：cosTypeNo無法轉成str");
					}
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Costype/select_costype_page.jsp");
						failureView.forward(req, res);
						return;
					}
					
					Integer cosTypeNo = null;
					try {
						cosTypeNo = new Integer(str);
					} catch (Exception e) {
						errorMsgs.add("getOne_For_Display：str無法變成包裝型別cosTypeNo");
					}
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Costype/select_costype_page.jsp");
						failureView.forward(req, res);
						return;
					}
					
					CostypeService costypeSvc = new CostypeService();
					CostypeVO costypeVO = costypeSvc.getOneCosType(cosTypeNo);
					if (costypeVO == null) {
						errorMsgs.add("getOne_For_Display：costypeVO為null");
					}
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Costype/select_costype_page.jsp");
						failureView.forward(req, res);
						return;
					}

					req.setAttribute("costypeVO", costypeVO);
					String url = "/back-end/Costype/listOneCostype.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

				} catch (Exception e) {
					errorMsgs.add("getOne_For_Display：有errorMsgs發生" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Costype/select_costype_page.jsp");
					failureView.forward(req, res);
				}
			}
			
			if ("getOne_For_Update".equals(action)){

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					Integer cosTypeNo = new Integer(req.getParameter("cosTypeNo"));
//					System.out.println(cosTypeNo);

					CostypeService costypeSvc = new CostypeService();
					CostypeVO costypeVO = costypeSvc.getOneCosType(cosTypeNo);

					req.setAttribute("costypeVO", costypeVO);
					
					boolean openModal=true;
					req.setAttribute("openModal",openModal );
					
					
					String url = "/back-end/Costype/listAllCostype.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);
					return;
				} catch (Exception e) {
					errorMsgs.add("getOne_For_Update：有errorMsgs發生" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Costype/listAllCostype.jsp");
					failureView.forward(req, res);
				}
			}
			
			if ("update".equals(action)){
				
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
			
				try {
					Integer cosTypeNo = new Integer(req.getParameter("cosTypeNo").trim());
					
					
					String cosTypeName = req.getParameter("cosTypeName");
					if (cosTypeName == null || cosTypeName.trim().length() == 0) {
						errorMsgs.add("update：cosTypeName出現null");
					}else if(cosTypeName.length() >= 18) {
						errorMsgs.add("update：cosTypeName長度超過限制");
					}
					
					String cosTypeIntro = req.getParameter("cosTypeIntro");
					if (cosTypeIntro == null || cosTypeIntro.trim().length() == 0) {
						errorMsgs.add("update：cosTypeIntro出現null");
					}else if(cosTypeName.length() >= 180) {
						errorMsgs.add("update：cosTypeIntro長度超過限制");
					}					
					
					CostypeVO costypeVO = new CostypeVO();
					costypeVO.setCosTypeNo(cosTypeNo);
					costypeVO.setCosTypeName(cosTypeName);
					costypeVO.setCosTypeIntro(cosTypeIntro);
					

					if (!errorMsgs.isEmpty()) {
						req.setAttribute("costypeVO", costypeVO);
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Costype/listAllCostype.jsp");
						boolean openModal=true;
						req.setAttribute("openModal",openModal);
						failureView.forward(req, res);
						return;
					}
					
					CostypeService costypeSvc = new CostypeService();
					
					costypeVO = costypeSvc.updateCosType(cosTypeNo, cosTypeName, cosTypeIntro);
							
					req.setAttribute("costypeVO", costypeVO);
					String url = "/back-end/Costype/listAllCostype.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

				} catch (Exception e) {
					errorMsgs.add("update：有errorMsgs發生"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Costype/listAllCostype.jsp");
					failureView.forward(req, res);
				}
			}
			
	        if ("insert".equals(action)){ 
				
				List<String> errorMsgs = new LinkedList<String>();
				
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					String cosTypeName = req.getParameter("cosTypeName");
					if (cosTypeName == null || cosTypeName.trim().length() == 0) {
						errorMsgs.add("insert：cosTypeName出現null");
					}else if(cosTypeName.length() >= 18) {
						errorMsgs.add("insert：cosTypeName長度超過限制");
					}
					
					String cosTypeIntro = req.getParameter("cosTypeIntro");
					if (cosTypeIntro == null || cosTypeIntro.trim().length() == 0) {
						errorMsgs.add("insert：cosTypeIntro出現null");
					}else if(cosTypeIntro.length() >= 180) {
						errorMsgs.add("insert：cosTypeIntro長度超過限制");
					}					
					
					CostypeVO costypeVO = new CostypeVO();
					costypeVO.setCosTypeName(cosTypeName);
					costypeVO.setCosTypeIntro(cosTypeIntro);
					
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("costypeVO", costypeVO);
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Costype/listAllCostype.jsp");
						boolean openModal=true;
						req.setAttribute("openModal",openModal);
						failureView.forward(req, res);
						return;
					}
					
					CostypeService costypeSvc = new CostypeService();
					costypeVO = costypeSvc.insertCosType(cosTypeName, cosTypeIntro);
					String url = "/back-end/Costype/listAllCostype.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);				
				
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Costype/listAllCostype.jsp");
					failureView.forward(req, res);
				}
			}
			
			if ("delete".equals(action)){

				List<String> errorMsgs = new LinkedList<String>();

				req.setAttribute("errorMsgs", errorMsgs);
		
				try {
					Integer cosTypeNo = new Integer(req.getParameter("cosTypeNo"));
					
					CostypeService costypeSvc = new CostypeService();
					costypeSvc.deleteCosType(cosTypeNo);
												
					String url = "/back-end/Costype/listAllCostype.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

				} catch (Exception e) {
					errorMsgs.add("delete：有errorMsgs發生"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Costype/listAllCostype.jsp");
					failureView.forward(req, res);
				}
			}
		}
	}


