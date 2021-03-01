package com.salon.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.salon.model.SalonService;
import com.salon.model.SalonVO;

public class SalonServlet extends HttpServlet{
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) { // 來自select_salon_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("salNo");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入沙龍編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/salon/select_salon_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer salNo = null;
				try {
					salNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("沙龍編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/salon/select_salon_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				SalonService salonSvc = new SalonService();
				SalonVO salonVO = salonSvc.getOneSalon(salNo);
				if (salonVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/salon/select_salon_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("salonVO", salonVO); // 資料庫取出的salonVO物件,存入req
				String url = "/front-end/salon/listOneSalon.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneSalon.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/salon/select_salon_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("insert".equals(action)) { // 來自addSalon.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String salName = req.getParameter("salName");
				String salNameReg = "^[(\\u4e00-\\u9fa5)(\\u0020)(a-zA-Z0-9_)]{2,30}$";
				if (salName == null || salName.trim().length() == 0) {
					errorMsgs.add("髮廊名稱請勿空白");
				} else if(!salName.trim().matches(salNameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("髮廊名稱長度必需在2到30之間");
	            }
				
				String salAdd = req.getParameter("salAdd").trim();
				if (salAdd == null || salAdd.trim().length() == 0) {
					errorMsgs.add("髮廊地址請勿空白");
				}
				
				String salTime = req.getParameter("salTime").trim();
				if (salTime == null || salTime.trim().length() == 0) {
					errorMsgs.add("營業時間請勿空白");
				}
				
				String salPhone = req.getParameter("salPhone").trim();
				if (salPhone == null || salPhone.trim().length() == 0) {
					errorMsgs.add("髮廊電話請勿空白");
				}
				
				Integer salStatus = new Integer(1);

				SalonVO salonVO = new SalonVO();
				salonVO.setSalName(salName);
				salonVO.setSalAdd(salAdd);
				salonVO.setSalTime(salTime);
				salonVO.setSalPhone(salPhone);
				salonVO.setSalStatus(salStatus);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("salonVO", salonVO); // 含有輸入格式錯誤的salonVO物件,也存入req(資料輸入錯誤不用全新重寫)
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/salon/addSalon.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				SalonService salonSvc = new SalonService();
				salonVO = salonSvc.addSalon(salName, salAdd, salTime, salPhone, salStatus);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/salon/listAllSalon.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/salon/addSalon.jsp");
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
				Integer salNo = new Integer(req.getParameter("salNo"));
				
				/***************************2.開始查詢資料****************************************/
				SalonService salSvc = new SalonService();
				SalonVO salonVO = salSvc.getOneSalon(salNo);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("salonVO", salonVO);         // 資料庫取出的salonVO物件,存入req
				String url = "/front-end/salon/update_salon_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_salon_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/salon/listAllSalon.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // 來自update_salon_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer salNo = new Integer(req.getParameter("salNo").trim());
				
				String salName = req.getParameter("salName");
				String salNameReg = "^[(\\u4e00-\\u9fa5)(\\u0020)(a-zA-Z0-9_)]{2,10}$";
				if (salName == null || salName.trim().length() == 0) {
					errorMsgs.add("髮廊名稱請勿空白");
				} else if(!salName.trim().matches(salNameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("髮廊名稱長度必需在2到30之間");
	            }
				
				String salAdd = req.getParameter("salAdd").trim();
				if (salAdd == null || salAdd.trim().length() == 0) {
					errorMsgs.add("髮廊地址請勿空白");
				}	
				
				String salTime = req.getParameter("salTime").trim();
				if (salTime == null || salTime.trim().length() == 0) {
					errorMsgs.add("營業時間請勿空白");
				}
				
				String salPhone = req.getParameter("salPhone").trim();
				if (salPhone == null || salPhone.trim().length() == 0) {
					errorMsgs.add("髮廊電話請勿空白");
				}
				
				Integer salStatus = new Integer(req.getParameter("salStatus"));

				SalonVO salonVO = new SalonVO();
				salonVO.setSalNo(salNo);
				salonVO.setSalName(salName);
				salonVO.setSalAdd(salAdd);
				salonVO.setSalTime(salTime);
				salonVO.setSalPhone(salPhone);
				salonVO.setSalStatus(salStatus);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("salonVO", salonVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("front-end/salon/update_salon_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				SalonService salSvc = new SalonService();
				salonVO = salSvc.updateSalon(salNo, salName, salAdd, salTime, salPhone, salStatus);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("salonVO", salonVO); // 資料庫update成功後,正確的的salonVO物件,存入req
				String url = "/front-end/salon/listOneSalon.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneSalon.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/salon/update_salon_input.jsp");
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
				Integer salNo = new Integer(req.getParameter("salNo"));
				
				/***************************2.開始刪除資料***************************************/
				SalonService salonSvc = new SalonService();
				salonSvc.deleteSalon(salNo);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/salon/listAllSalon.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/salon/listAllSalon.jsp");
				failureView.forward(req, res);
			}
		}
	}

}
