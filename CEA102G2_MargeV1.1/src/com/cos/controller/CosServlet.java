package com.cos.controller;

import java.io.*;

import java.sql.Timestamp;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.cos.model.*;
import com.coutype.model.CostypeService;
import com.lecturer.model.LecturerService;

import javax.servlet.http.Part;

@MultipartConfig

public class CosServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

		public void doGet(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {
			doPost(req, res);
		}

		@SuppressWarnings("unchecked")
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
								.getRequestDispatcher("/back-end/Cos/select_cos_page.jsp");
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
								.getRequestDispatcher("/back-end/Cos/select_cos_page.jsp");
						failureView.forward(req, res);
						return;
					}
					
					CosService cosSvc = new CosService();
					CosVO cosVO = cosSvc.findByPrimaryKeyCos(cosNo);
					if (cosVO == null) {
						errorMsgs.add("getOne_For_Display：cosVO為null");
					}
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cos/select_cos_page.jsp");
						failureView.forward(req, res);
						return;
					}

					req.setAttribute("cosVO", cosVO);
					String url = "/back-end/Cos/listOneCos.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

				} catch (Exception e) {
					errorMsgs.add("getOne_For_Display：有errorMsgs發生" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cos/select_cos_page.jsp");
					failureView.forward(req, res);
				}
			}
			
			
			if ("getOne_For_Update".equals(action)){

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					Integer cosNo = new Integer(req.getParameter("cosNo"));

					CosService cosSvc = new CosService();
					CosVO cosVO = cosSvc.findByPrimaryKeyCos(cosNo);

					req.setAttribute("cosVO", cosVO);
					String url = "/back-end/Cos/update_cos_input.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);
				} catch (Exception e) {
					errorMsgs.add("getOne_For_Update：有errorMsgs發生" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cos/listAllCos.jsp");
					failureView.forward(req, res);
				}
			}
			
			if ("update".equals(action)){
				
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
			
				String requestURL = req.getParameter("requestURL");// 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】 或 【 /emp/listEmps_ByCompositeQuery.jsp】
				
				try {
					Integer cosNo = new Integer(req.getParameter("cosNo").trim());
					
					Integer lecNo = null;
					try {
						lecNo = new Integer(req.getParameter("lecNo").trim());
					} catch (NumberFormatException e) {
						lecNo = 0;
						errorMsgs.add("update：lecNo出現NumberFormatException");
					}

					Integer cosCount = null;
					try {
						cosCount = new Integer(req.getParameter("cosCount").trim());
					} catch (NumberFormatException e) {
						cosCount = 0;
						errorMsgs.add("update：cosCount出現NumberFormatException");
					}
					Integer cosRate = null;
					try {
						cosRate = new Integer(req.getParameter("cosRate").trim());
					} catch (NumberFormatException e) {
						cosRate = 0;
						errorMsgs.add("update：cosRate出現NumberFormatException");
					}
					
					Boolean cosStatus = null;
					
					cosStatus = Boolean.parseBoolean(req.getParameter("cosStatus").trim());
								
					Integer cosMinCount = null;
					try {
						cosMinCount = new Integer(req.getParameter("cosMinCount").trim());
					} catch (NumberFormatException e) {
						cosMinCount = 0;
						errorMsgs.add("update：cosMinCount出現NumberFormatException");
					}					
					Integer cosMaxCount = null;
					try {
						cosMaxCount = new Integer(req.getParameter("cosMaxCount").trim());
					} catch (NumberFormatException e) {
						cosMaxCount = 0;
						errorMsgs.add("update：cosMaxCount出現NumberFormatException");
					}
					Integer cosPrice = null;
					try {
						cosPrice = new Integer(req.getParameter("cosPrice").trim());
					} catch (NumberFormatException e) {
						cosPrice = 0;
						errorMsgs.add("update：cosPrice出現NumberFormatException");
					}					
					
					
					String cosIntro = req.getParameter("cosIntro");
					if (cosIntro == null || cosIntro.trim().length() == 0) {
						errorMsgs.add("update：cosIntro出現null");
					}			
					
					String cosAdd = req.getParameter("cosAdd");
					if (cosAdd == null || cosAdd.trim().length() == 0) {
						errorMsgs.add("update：cosAdd出現null");
					}					
					String cosName = req.getParameter("cosName");
					String cosNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
					if (cosName == null || cosName.trim().length() == 0) {
						errorMsgs.add("課程名稱: 請勿空白");
					} else if(!cosName.trim().matches(cosNameReg)) { //以下練習正則(規)表示式(regular-expression)
						errorMsgs.add("課程名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
		            }
					
					
					Timestamp cosFrom = null;
					try {
						cosFrom = java.sql.Timestamp.valueOf(req.getParameter("cosFrom"));
					} catch (IllegalArgumentException e) {
						errorMsgs.add("update：cosName出現IllegalArgumentException");
					}
					Timestamp cosTo = null;
					try {
						cosTo = java.sql.Timestamp.valueOf(req.getParameter("cosTo"));
					} catch (IllegalArgumentException e) {
						errorMsgs.add("update：cosTo出現IllegalArgumentException");
					}					
					Timestamp cosApplyFrom = null;
					try {
						cosApplyFrom = java.sql.Timestamp.valueOf(req.getParameter("cosApplyFrom"));
					} catch (IllegalArgumentException e) {
						errorMsgs.add("update：cosApplyFrom出現IllegalArgumentException");
					}					
					Timestamp cosApplyTo = null;
					try {
						cosApplyTo = java.sql.Timestamp.valueOf(req.getParameter("cosApplyTo"));
					} catch (IllegalArgumentException e) {
						errorMsgs.add("update：cosApplyTo出現IllegalArgumentException");
					}					
					
					Integer cosTypeNo = new Integer(req.getParameter("cosTypeNo").trim());
					
					byte[] cosPic = null;
					try {
						Part part = req.getPart("upfile1");

						if (part.getSize() != 0) {
							//此段檢查JSP送資料時是否有上傳圖片
							
							InputStream is = part.getInputStream();
							cosPic = new byte[is.available()];
							is.read(cosPic);
							is.close();
						} else {
							//圖片未上傳走的路徑
							CosVO cosVO = new CosVO();
							cosVO.setCosNo(cosNo);
							cosVO.setLecNo(lecNo);
							cosVO.setCosTypeNo(cosTypeNo);
							cosVO.setCosFrom(cosFrom);
							cosVO.setCosTo(cosTo);
							cosVO.setCosIntro(cosIntro);
							cosVO.setCosAdd(cosAdd);
							cosVO.setCosCount(cosCount);
							cosVO.setCosRate(cosRate);
							cosVO.setCosStatus(cosStatus);
							cosVO.setCosMinCount(cosMinCount);
							cosVO.setCosMaxCount(cosMaxCount);
							cosVO.setCosPrice(cosPrice);
							cosVO.setCosApplyFrom(cosApplyFrom);
							cosVO.setCosApplyTo(cosApplyTo);
							cosVO.setCosName(cosName);

						}
					} catch (Exception e) {
						errorMsgs.add("有問題");
					}
					//有上傳圖片走的路徑
					CosVO cosVO = new CosVO();
					cosVO.setCosNo(cosNo);
					cosVO.setLecNo(lecNo);
					cosVO.setCosTypeNo(cosTypeNo);
					cosVO.setCosFrom(cosFrom);
					cosVO.setCosTo(cosTo);
					cosVO.setCosIntro(cosIntro);
					cosVO.setCosPic(cosPic);
					cosVO.setCosAdd(cosAdd);
					cosVO.setCosCount(cosCount);
					cosVO.setCosRate(cosRate);
					cosVO.setCosStatus(cosStatus);
					cosVO.setCosMinCount(cosMinCount);
					cosVO.setCosMaxCount(cosMaxCount);
					cosVO.setCosPrice(cosPrice);
					cosVO.setCosApplyFrom(cosApplyFrom);
					cosVO.setCosApplyTo(cosApplyTo);
					cosVO.setCosName(cosName);
					

					if (!errorMsgs.isEmpty()) {
						req.setAttribute("cosVO", cosVO);
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cos/update_cos_input.jsp");
						failureView.forward(req, res);
						return;
					}
					
					CosService cosSvc = new CosService();
					if (cosPic != null) {
					cosVO = cosSvc.updateCos(cosNo, lecNo, cosTypeNo, cosFrom, cosTo, cosIntro, cosPic, cosAdd, cosCount, cosRate, cosStatus, cosMinCount, cosMaxCount, cosPrice, cosApplyFrom, cosApplyTo, cosName);
							} else {
						cosVO = cosSvc.updateCosNoPic(cosNo, lecNo, cosTypeNo, cosFrom, cosTo, cosIntro, cosAdd, cosCount, cosRate, cosStatus, cosMinCount, cosMaxCount, cosPrice, cosApplyFrom, cosApplyTo, cosName);
								}
					
					CostypeService costypeSvc = new CostypeService();
					if(requestURL.equals("/back-end/Costype/listCos_ByCosTypeNo.jsp") || requestURL.equals("/back-end/Costype/listAllCostype.jsp"))
						req.setAttribute("listCos_ByCosTypeNo",costypeSvc.getCosByCosTypeNo(cosTypeNo)); // 資料庫取出的list物件,存入request
					
					if(requestURL.equals("/back-end/Cos/listCos_ByCompositeQuery.jsp")){
						HttpSession session = req.getSession();
						Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
						List<CosVO> list  = cosSvc.getAll(map);
						req.setAttribute("listCos_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
					}
					req.setAttribute("cosVO", cosVO);
					String url = requestURL;
					RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
					successView.forward(req, res);
					
					/***************************其他可能的錯誤處理*************************************/
				} catch (Exception e) {
					errorMsgs.add("修改資料失敗:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cos/update_cos_input.jsp");
					failureView.forward(req, res);
				}
			}
			
			
	        if ("insert".equals(action)){ 
				
				List<String> errorMsgs = new LinkedList<String>();
				
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					Integer lecNo = null;
					try {
						lecNo = new Integer(req.getParameter("lecNo").trim());
					} catch (NumberFormatException e) {
						lecNo = 0;
						errorMsgs.add("insert：lecNo出現NumberFormatException");
					}
					Integer cosTypeNo = null;
					try {
						cosTypeNo = new Integer(req.getParameter("cosTypeNo").trim());
					} catch (NumberFormatException e) {
						cosTypeNo = 0;
						errorMsgs.add("insert：cosTypeNo出現NumberFormatException");
					}
					Integer cosCount = null;
					try {
						cosCount = new Integer(req.getParameter("cosCount").trim());
					} catch (NumberFormatException e) {
						cosCount = 0;
						errorMsgs.add("insert：cosCount出現NumberFormatException");
					}
					Integer cosRate = null;
					try {
						cosRate = new Integer(req.getParameter("cosRate").trim());
					} catch (NumberFormatException e) {
						cosRate = 0;
						errorMsgs.add("insert：cosRate出現NumberFormatException");
					}					
					Boolean cosStatus = Boolean.parseBoolean(req.getParameter("cosStatus").trim());					
					Integer cosMinCount = null;
					try {
						cosMinCount = new Integer(req.getParameter("cosMinCount").trim());
					} catch (NumberFormatException e) {
						cosMinCount = 0;
						errorMsgs.add("insert：cosMinCount出現NumberFormatException");
					}					
					Integer cosMaxCount = null;
					try {
						cosMaxCount = new Integer(req.getParameter("cosMaxCount").trim());
					} catch (NumberFormatException e) {
						cosMaxCount = 0;
						errorMsgs.add("insert：cosMaxCount出現NumberFormatException");
					}
					Integer cosPrice = null;
					try {
						cosPrice = new Integer(req.getParameter("cosPrice").trim());
					} catch (NumberFormatException e) {
						cosPrice = 0;
						errorMsgs.add("insert：cosPrice出現NumberFormatException");
					}					
					
					
					String cosIntro = req.getParameter("cosIntro");
					if (cosIntro == null || cosIntro.trim().length() == 0) {
						errorMsgs.add("insert：cosIntro出現null");
					}
					
					
					String cosAdd = req.getParameter("cosAdd");
					if (cosAdd == null || cosAdd.trim().length() == 0) {
						errorMsgs.add("insert：cosAdd出現null");
					}					
					String cosName = req.getParameter("cosName");
					if (cosName == null || cosName.trim().length() == 0) {
						errorMsgs.add("insert：cosName出現null");
					}
					
					
					Timestamp cosFrom = null;
					try {
						cosFrom = java.sql.Timestamp.valueOf(req.getParameter("cosFrom"));
					} catch (IllegalArgumentException e) {
						errorMsgs.add("insert：cosName出現IllegalArgumentException");
					}
					Timestamp cosTo = null;
					try {
						cosTo = java.sql.Timestamp.valueOf(req.getParameter("cosTo"));
					} catch (IllegalArgumentException e) {
						errorMsgs.add("insert：cosTo出現IllegalArgumentException");
					}					
					Timestamp cosApplyFrom = null;
					try {
						cosApplyFrom = java.sql.Timestamp.valueOf(req.getParameter("cosApplyFrom"));
					} catch (IllegalArgumentException e) {
						errorMsgs.add("insert：cosApplyFrom出現IllegalArgumentException");
					}					
					Timestamp cosApplyTo = null;
					try {
						cosApplyTo = java.sql.Timestamp.valueOf(req.getParameter("cosApplyTo"));
					} catch (IllegalArgumentException e) {
						errorMsgs.add("insert：cosApplyTo出現IllegalArgumentException");
					}

					
					byte[] cosPic = null;
					try {
						Part part = req.getPart("upfile1");
					
						InputStream is = part.getInputStream();
						cosPic = new byte[is.available()];
						is.read(cosPic);
						is.close();
						}catch (Exception e) {
							errorMsgs.add("有問題");
						}
						if(cosPic.length == 0)
						cosPic = null;	
					CosVO cosVO = new CosVO();
					cosVO.setLecNo(lecNo);
					cosVO.setCosTypeNo(cosTypeNo);
					cosVO.setCosFrom(cosFrom);
					cosVO.setCosTo(cosTo);
					cosVO.setCosIntro(cosIntro);
					cosVO.setCosPic(cosPic);
					cosVO.setCosAdd(cosAdd);
					cosVO.setCosCount(cosCount);
					cosVO.setCosRate(cosRate);
					cosVO.setCosStatus(cosStatus);
					cosVO.setCosMinCount(cosMinCount);
					cosVO.setCosMaxCount(cosMaxCount);
					cosVO.setCosPrice(cosPrice);
					cosVO.setCosApplyFrom(cosApplyFrom);
					cosVO.setCosApplyTo(cosApplyTo);
					cosVO.setCosName(cosName);
					
					
					
					
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("cosVO", cosVO);
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cos/addCos.jsp");
						failureView.forward(req, res);
						return;
					}
					
					CosService cosSvc = new CosService();
					cosVO = cosSvc.addCos(lecNo, cosTypeNo, cosFrom, cosTo, cosIntro, cosPic, cosAdd, cosCount, cosRate, cosStatus, cosMinCount, cosMaxCount, cosPrice, cosApplyFrom, cosApplyTo, cosName);
					String url = "/back-end/Cos/listAllCos.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);				
				
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cos/addCos.jsp");
					failureView.forward(req, res);
				}
			}
			
			if ("delete".equals(action)){// 來自listAllEmp.jsp 或  /dept/listEmps_ByDeptno.jsp的請求

				List<String> errorMsgs = new LinkedList<String>();

				req.setAttribute("errorMsgs", errorMsgs);
				
				String requestURL = req.getParameter("requestURL"); // 送出刪除的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】 或 【 /emp/listEmps_ByCompositeQuery.jsp】
		
				try {
					Integer cosNo = new Integer(req.getParameter("cosNo"));
					System.out.println(cosNo);
					CosService cosSvc = new CosService();
					CosVO cosVO = cosSvc.findByPrimaryKeyCos(cosNo);
					cosSvc.deleteCos(cosNo);
					
					CostypeService costypeSvc = new CostypeService();
					if(requestURL.equals("/back-end/Costype/listCos_ByCosTypeNo.jsp") || requestURL.equals("/back-end/Costype/listAllCostype.jsp"))
						req.setAttribute("listCos_ByCosTypeNo",costypeSvc.getCosByCosTypeNo(cosVO.getCosTypeNo())); // 資料庫取出的list物件,存入request
					
					if(requestURL.equals("/back-end/Cos/listCos_ByCompositeQuery.jsp")){
						HttpSession session = req.getSession();
						Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
						List<CosVO> list  = cosSvc.getAll(map);
						req.setAttribute("listCos_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
					}
					
					String url = requestURL;
					RequestDispatcher successView = req.getRequestDispatcher(url); // 刪除成功後,轉交回送出刪除的來源網頁
					successView.forward(req, res);
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add("刪除資料失敗:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
				}
			}
			
			if ("listCos_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					
					/***************************1.將輸入資料轉為Map**********************************/ 
					//採用Map<String,String[]> getParameterMap()的方法 
					//注意:an immutable java.util.Map 
					//Map<String, String[]> map = req.getParameterMap();
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					if (req.getParameter("whichPage") == null){
						HashMap<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
						session.setAttribute("map",map1);
						map = map1;
					} 
					
					/***************************2.開始複合查詢***************************************/
					CosService cosSvc = new CosService();
					List<CosVO> list  = cosSvc.getAll(map);					
					
					/***************************3.查詢完成,準備轉交(Send the Success view)************/
					req.setAttribute("listCos_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
					RequestDispatcher successView = req.getRequestDispatcher("/back-end/Cos/listCos_ByCompositeQuery.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
					successView.forward(req, res);
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cos/select_cos_page.jsp");
					failureView.forward(req, res);
				}
			}
			
			if ("listCos_ByCompositeQuery_forFront".equals(action)) { // 來自select_page.jsp的複合查詢請求
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					
					/***************************1.將輸入資料轉為Map**********************************/ 
					//採用Map<String,String[]> getParameterMap()的方法 
					//注意:an immutable java.util.Map 
					//Map<String, String[]> map = req.getParameterMap();
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					if (req.getParameter("whichPage") == null){
						HashMap<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
						session.setAttribute("map",map1);
						map = map1;
					} 
					
					/***************************2.開始複合查詢***************************************/
					CosService cosSvc = new CosService();
					List<CosVO> list  = cosSvc.getAll(map);					
					
					/***************************3.查詢完成,準備轉交(Send the Success view)************/
					if (list != null) {
						req.setAttribute("listCos_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
						RequestDispatcher successView = req.getRequestDispatcher("/front-end/Cos/listCos_ByCompositeQueryfront.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
					successView.forward(req, res);
					}else {
						RequestDispatcher successView = req.getRequestDispatcher("/front-end/Cos/Course_Lec_1st.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
						successView.forward(req, res);
					}
					
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/Cos/select_cos_pagefront.jsp");
					failureView.forward(req, res);
				}
			}
			
			if ("getOne_For_Apply".equals(action)){

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				Integer applyno;
				
				try {
					Integer cosNo = new Integer(req.getParameter("cosNo"));

					CosService cosSvc = new CosService();
					CosVO cosVO = cosSvc.findByPrimaryKeyCos(cosNo);

					req.setAttribute("cosVO", cosVO);
					String url = "/back-end/Cos/update_cos_input.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);
				} catch (Exception e) {
					errorMsgs.add("getOne_For_Update：有errorMsgs發生" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cos/listAllCos.jsp");
					failureView.forward(req, res);
				}
			}
			
			
		}
	}


