package com.transactionRecord.controller;

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

import com.transactionRecord.model.*;

public class TransRecServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TransRecServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOne_For_Display".equals(action)) { // 來自select_trans_rec_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("traNo");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入通知編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/transactionRecord/select_trans_rec_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer traNo = null;
				try {
					traNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("交易編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/transactionRecord/select_trans_rec_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				TransRecService transRecSvc = new TransRecService();
				TransRecVO transRecVO = transRecSvc.getOneTransRec(traNo);
				if (transRecVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/transactionRecord/select_trans_rec_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("transRecVO", transRecVO); // 資料庫取出的transRecVO物件,存入req
				String url = "/back-end/transactionRecord/listOneTransRec.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/transactionRecord/select_trans_rec_page.jsp");
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
				Integer traNo = new Integer(req.getParameter("traNo"));
				
				/***************************2.開始查詢資料****************************************/
				TransRecService transRecSvc = new TransRecService();
				TransRecVO transRecVO = transRecSvc.getOneTransRec(traNo);
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("transRecVO", transRecVO); // 資料庫取出的transRecVO物件,存入req
				
				String url = "/back-end/transactionRecord/update_trans_rec_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_trans_rec_input.jsp
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
		
		
		if ("update".equals(action)) { // 來自update_trans_rec_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/noti/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer traNo = new Integer(req.getParameter("traNo").trim());

				Integer memNo =new Integer(req.getParameter("memNo").trim());
				
				Integer traDes = new Integer(req.getParameter("traDes"));

				String str = req.getParameter("traPri");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入交易金額");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/transactionRecord/update_trans_rec_input.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer traPri = null;
				try {
					traPri = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("交易金額格式不正確");
				}
				
				str = req.getParameter("traBal");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入餘額");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/transactionRecord/update_trans_rec_input.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}			
				Integer traBal = null;
				try {
					traBal = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("餘額格式不正確");
				}

				
				
				TransRecVO transRecVO = new TransRecVO();
				transRecVO.setTraNo(traNo);
				transRecVO.setMemNo(memNo);
				transRecVO.setTraDes(traDes);
				transRecVO.setTraPri(traPri);;
				transRecVO.setTraBal(traBal);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("transRecVO", transRecVO); // 含有輸入格式錯誤的transRecVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/transactionRecord/update_trans_rec_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				TransRecService transRecSvc = new TransRecService();
				transRecVO = transRecSvc.updateTransRec(traNo, memNo, traDes, traPri, traBal);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/				
//				TransRecService deptSvc = new TransRecService();
//				if(requestURL.equals("/transactionRecord/listEmps_ByDeptno.jsp") || requestURL.equals("/transactionRecord/listAllDept.jsp"))
//					req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(deptno)); // 資料庫取出的list物件,存入request

                String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());

				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/transactionRecord/update_trans_rec_input.jsp");
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
				
				Integer traDes = new Integer(req.getParameter("traDes"));
				
				
				String str = req.getParameter("traPri");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入交易金額");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/transactionRecord/addTransRec.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}			
				Integer traPri = null;
				try {
					traPri = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("交易金額格式不正確");
				}
				
				str = req.getParameter("traBal");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入餘額");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/transactionRecord/addTransRec.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}			
				Integer traBal = null;
				try {
					traBal = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("餘額格式不正確");
				}

				
				TransRecVO transRecVO = new TransRecVO();
				transRecVO.setMemNo(memNo);
				transRecVO.setTraDes(traDes);
				transRecVO.setTraPri(traPri);;
				transRecVO.setTraBal(traBal);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("transRecVO", transRecVO); // 含有輸入格式錯誤的transRecVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/transactionRecord/addTransRec.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				TransRecService transRecSvc = new TransRecService();
				transRecVO = transRecSvc.addTransRec(memNo, traDes, traPri, traBal);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/transactionRecord/listAllTransRec.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/transactionRecord/addTransRec.jsp");
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
				Integer traNo = new Integer(req.getParameter("traNo"));
				
				/***************************2.開始刪除資料***************************************/
				TransRecService transRecSvc = new TransRecService();
				TransRecVO transRecVO = transRecSvc.getOneTransRec(traNo);
				transRecSvc.deleteTransRec(traNo);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
//				DeptService deptSvc = new DeptService();
//				if(requestURL.equals("/dept/listEmps_ByDeptno.jsp") || requestURL.equals("/dept/listAllDept.jsp"))
//					req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(transRecVO.getDeptno())); // 資料庫取出的list物件,存入request
				
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
