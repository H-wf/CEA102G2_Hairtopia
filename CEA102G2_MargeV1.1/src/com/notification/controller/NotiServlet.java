package com.notification.controller;

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

import com.notification.model.*;

public class NotiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public NotiServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOne_For_Display".equals(action)) { // 來自select_noti_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("notiNo");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入通知編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/notification/select_noti_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer notiNo = null;
				try {
					notiNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("新聞編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/notification/select_noti_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				NotiService notiSvc = new NotiService();
				NotiVO notiVO = notiSvc.getOneNoti(notiNo);
				if (notiVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/notification/select_noti_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("notiVO", notiVO); // 資料庫取出的notiVO物件,存入req
				String url = "/back-end/notification/listOneNoti.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/notification/select_noti_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp 或  /dept/listEmps_ByDeptno.jsp 的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/noti/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】		
			try {
				/***************************1.接收請求參數****************************************/
				Integer notiNo = new Integer(req.getParameter("notiNo"));
				
				/***************************2.開始查詢資料****************************************/
				NotiService notiSvc = new NotiService();
				NotiVO notiVO = notiSvc.getOneNoti(notiNo);
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("notiVO", notiVO); // 資料庫取出的notiVO物件,存入req
				
				String url = "/back-end/notification/update_noti_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_noti_input.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料取出時失敗:"+e.getMessage());
				System.out.println(requestURL);
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_noti_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/noti/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer notiNo = new Integer(req.getParameter("notiNo").trim());

				Integer memNo =new Integer(req.getParameter("memNo").trim());
				
				Boolean notiIsRead = new Boolean(req.getParameter("notiIsRead"));
				
				String notiText = req.getParameter("notiText");
//				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (notiText == null || notiText.trim().length() == 0) {
					errorMsgs.add("通知內容: 請勿空白");
				} 
				

				NotiVO notiVO = new NotiVO();
				notiVO.setNotiNo(notiNo);
				notiVO.setMemNo(memNo);
				notiVO.setNotiText(notiText);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("notiVO", notiVO); // 含有輸入格式錯誤的notiVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/notification/update_noti_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				NotiService notiSvc = new NotiService();
				notiVO = notiSvc.updateNoti(notiNo, memNo, notiText, notiIsRead);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/				
//				NotiService deptSvc = new NotiService();
//				if(requestURL.equals("/notification/listEmps_ByDeptno.jsp") || requestURL.equals("/notification/listAllDept.jsp"))
//					req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(deptno)); // 資料庫取出的list物件,存入request

                String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());

				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/notification/update_noti_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // 來自addEmp.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				Integer memNo = new Integer(req.getParameter("memNo"));
				
				String notiText = req.getParameter("notiText").trim();
				if (notiText == null || notiText.trim().length() == 0) {
					errorMsgs.add("內容請勿空白");
				}
				
				Boolean notiIsRead = new Boolean(req.getParameter("notiIsRead"));
				
				NotiVO notiVO = new NotiVO();
				notiVO.setMemNo(memNo);
				notiVO.setNotiText(notiText);
				notiVO.setNotiIsRead(notiIsRead);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("notiVO", notiVO); // 含有輸入格式錯誤的notiVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/notification/addNoti.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				NotiService notiSvc = new NotiService();
				notiVO = notiSvc.addNoti(memNo, notiText, notiIsRead);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/notification/listAllNoti.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/notification/addNoti.jsp");
				failureView.forward(req, res);
			}
		}
		
       
		if ("delete".equals(action)) { // 來自listAllEmp.jsp 或  /dept/listEmps_ByDeptno.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出刪除的來源網頁路徑: 可能為【/noti/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】
			try {
				/***************************1.接收請求參數***************************************/
				Integer notiNo = new Integer(req.getParameter("notiNo"));
				
				/***************************2.開始刪除資料***************************************/
				NotiService notiSvc = new NotiService();
				NotiVO notiVO = notiSvc.getOneNoti(notiNo);
				notiSvc.deleteNoti(notiNo);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
//				DeptService deptSvc = new DeptService();
//				if(requestURL.equals("/dept/listEmps_ByDeptno.jsp") || requestURL.equals("/dept/listAllDept.jsp"))
//					req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(notiVO.getDeptno())); // 資料庫取出的list物件,存入request
				
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
	}
		


}
