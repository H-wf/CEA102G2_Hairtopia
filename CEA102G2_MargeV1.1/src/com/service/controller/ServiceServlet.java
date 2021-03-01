package com.service.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.service.model.ServiceService;
import com.service.model.ServiceVO;

public class ServiceServlet extends HttpServlet{
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
				
		if ("insert".equals(action)) { // 來自addService.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				Integer desNo = new Integer(req.getParameter("desNo"));
				Integer stypeNo = new Integer(req.getParameter("stypeNo"));
				
				String serName = req.getParameter("serName");
				String serNameReg = "^[(\\u4e00-\\u9fa5)(\\u0020)(a-zA-Z0-9_)]{2,40}$";
				if (serName == null || serName.trim().length() == 0) {
					errorMsgs.add("服務名稱請勿空白");
				} else if(!serName.trim().matches(serNameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("服務名稱長度必需在2到40之間");
	            }
				
				Integer serPrice = null;
						new Integer(req.getParameter("serPrice"));
				try {
					serPrice = new Integer(req.getParameter("serPrice").trim());
				} catch (NumberFormatException e) {
					serPrice = 0;
					errorMsgs.add("服務金額請填數字.");
				}
				
				Integer serTime = new Integer(req.getParameter("serTime"));
				
				String serDesc = req.getParameter("serDesc").trim();
				if (serDesc == null || serDesc.trim().length() == 0) {
					errorMsgs.add("服務敘述請勿空白");
				}
				
				Integer serStatus = new Integer(req.getParameter("serStatus"));

				ServiceVO serviceVO = new ServiceVO();
				
				serviceVO.setDesNo(desNo);
				serviceVO.setStypeNo(stypeNo);
				serviceVO.setSerName(serName);
				serviceVO.setSerPrice(serPrice);
				serviceVO.setSerTime(serTime);
				serviceVO.setSerDesc(serDesc);
				serviceVO.setSerStatus(serStatus);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("serviceVO", serviceVO); // 含有輸入格式錯誤的serviceVO物件,也存入req(資料輸入錯誤不用全新重寫)
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/service/addService.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ServiceService serviceSvc = new ServiceService();
				serviceVO = serviceSvc.addService(desNo, stypeNo, serName, serPrice, serTime, serDesc, serStatus);
				List<ServiceVO> list = serviceSvc.getAllServiceByDesNo(serviceVO.getDesNo());
				req.setAttribute("list", list);
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/service/listAllSerByDes.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/service/addService.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("serNo");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入服務編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/service/select_service_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer serNo = null;
				try {
					serNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("服務編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/service/select_service_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				ServiceService serviceSvc = new ServiceService();
				ServiceVO serviceVO = serviceSvc.getOneServiceBySerNo(serNo);
				if (serviceVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/service/select_service_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("serviceVO", serviceVO); // 資料庫取出的serviceVO物件,存入req
				String url = "/front-end/service/listOneService.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/service/select_service_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllSalon.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer serNo = new Integer(req.getParameter("serNo"));
				
				/***************************2.開始查詢資料****************************************/
				ServiceService serviceSvc = new ServiceService();
				ServiceVO serviceVO = serviceSvc.getOneServiceBySerNo(serNo);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("serviceVO", serviceVO);         // 資料庫取出的salonVO物件,存入req
				String url = "/front-end/service/update_service_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_salon_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/service/listAllSerByDes.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // 來自update_service_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer serNo = new Integer(req.getParameter("serNo").trim());
				Integer desNo = new Integer(req.getParameter("desNo"));
				Integer stypeNo = new Integer(req.getParameter("stypeNo"));
				
				String serName = req.getParameter("serName");
				String serNameReg = "^[(\\u4e00-\\u9fa5)(\\u0020)(a-zA-Z0-9_)]{2,40}$";
				if (serName == null || serName.trim().length() == 0) {
					errorMsgs.add("服務名稱請勿空白");
				} else if(!serName.trim().matches(serNameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("服務名稱長度必需在2到40之間");
	            }
				
				Integer serPrice = null;
						new Integer(req.getParameter("serPrice"));
				try {
					serPrice = new Integer(req.getParameter("serPrice").trim());
				} catch (NumberFormatException e) {
					serPrice = 0;
					errorMsgs.add("服務金額請填數字.");
				}
				
				Integer serTime = new Integer(req.getParameter("serTime"));
				
				String serDesc = req.getParameter("serDesc").trim();
				if (serDesc == null || serDesc.trim().length() == 0) {
					errorMsgs.add("服務敘述請勿空白");
				}
				
				Integer serStatus = new Integer(req.getParameter("serStatus"));

				ServiceVO serviceVO = new ServiceVO();				
				serviceVO.setSerNo(serNo);
				serviceVO.setDesNo(desNo);
				serviceVO.setStypeNo(stypeNo);
				serviceVO.setSerName(serName);
				serviceVO.setSerPrice(serPrice);
				serviceVO.setSerTime(serTime);
				serviceVO.setSerDesc(serDesc);
				serviceVO.setSerStatus(serStatus);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("serviceVO", serviceVO); // 含有輸入格式錯誤的serviceVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/service/update_service_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				ServiceService serviceSvc = new ServiceService();
				serviceVO = serviceSvc.updateService(serNo, desNo, stypeNo, serName, serPrice, 
						serTime, serDesc, serStatus);
				List<ServiceVO> list = serviceSvc.getAllServiceByDesNo(serviceVO.getDesNo());
				req.setAttribute("list", list);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("serviceVO", serviceVO); // 資料庫update成功後,正確的的serviceVO物件,存入req
				String url = "/front-end/service/listAllSerByDes.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneSalon.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/service/update_service_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("updateSerStatus".equals(action)) { // 來自update_service_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer serNo = new Integer(req.getParameter("serNo"));
				Integer serStatus = new Integer(req.getParameter("serStatus"));
				if(serStatus == 1) {
					serStatus = 0;
				}else {
					serStatus = 1;
				}
				Integer desNo = new Integer(req.getParameter("desNo"));
				
				ServiceVO serviceVO = new ServiceVO();				
				serviceVO.setSerNo(serNo);
				serviceVO.setSerStatus(serStatus);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("serviceVO", serviceVO); // 含有輸入格式錯誤的serviceVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/service/update_service_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				ServiceService serviceSvc = new ServiceService();
				serviceVO = serviceSvc.updateServiceStatus(serNo, serStatus);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
//				req.setAttribute("serviceVO", serviceVO); // 資料庫update成功後,正確的的serviceVO物件,存入req
				List<ServiceVO> list = serviceSvc.getAllServiceByDesNo(serviceVO.getDesNo());
				req.setAttribute("list", list);
				String url = "/front-end/service/listAllSerByDes.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneSalon.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/service/update_service_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer serNo = new Integer(req.getParameter("serNo"));
				Integer desNo = new Integer(req.getParameter("desNo"));
				
				/***************************2.開始刪除資料***************************************/
				ServiceService serviceSvc = new ServiceService();
				serviceSvc.deleteService(serNo);
				List<ServiceVO> list = serviceSvc.getAllServiceByDesNo(desNo);
				req.setAttribute("list", list);
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/service/listAllSerByDes.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/service/listAllService.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("queryByDesNo".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer desNo = new Integer(req.getParameter("desNo"));
				
				/*************************** 2.開始查詢資料 ***************************************/
				ServiceService serviceSvc = new ServiceService();
				List<ServiceVO> list=serviceSvc.getAllServiceByDesNo(desNo);
				req.setAttribute("list", list);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/service/listAllSerByDes.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("查詢資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/service/select_service_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer serNo = new Integer(req.getParameter("serNo"));
				
				/***************************2.開始刪除資料***************************************/
				ServiceService serviceSvc = new ServiceService();
				serviceSvc.deleteService(serNo);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/service/listAllService.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/service/listAllService.jsp");
				failureView.forward(req, res);
			}
		}
	}

}
