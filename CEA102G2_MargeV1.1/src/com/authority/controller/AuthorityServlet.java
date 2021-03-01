package com.authority.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.authority.model.*;

public class AuthorityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AuthorityServlet() {
		super();

	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("insert".equals(action)) { // 來自addLec.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String str = req.getParameter("staNo");
				String str2 = req.getParameter("funcNo");
				Integer staNo = null;
				try {
					staNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}
				Integer funcNo = null;
				try {
					funcNo = new Integer(str2);
				} catch (Exception e) {
					errorMsgs.add("功能格式不正確");
				}
				AuthorityVO authVO = new AuthorityVO();
				authVO.setStaNo(staNo);
				authVO.setFuncNo(funcNo);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("authVO", authVO); // 含有輸入格式錯誤的LecVO物件,也存入req

					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Authority/addAuth.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				AuthorityService authSvc = new AuthorityService();
				authSvc.deleteAuthority(staNo, funcNo);
				authVO = authSvc.addAuthority(staNo, funcNo);
				List<AuthorityVO> list=authSvc.getAllByStaNo(staNo);
				req.setAttribute("list", list);
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Authority/listAll_auth.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAll_lec.jsp
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());

				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Authority/addAuth.jsp");
				failureView.forward(req, res);
			}

		}
		if ("insertMuti".equals(action)) { // 來自addLec.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String str = req.getParameter("staNo");
				String[] str2 = req.getParameterValues("funcNo");
				Integer staNo = null;
				try {
					staNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}
				
				AuthorityService authSvc = new AuthorityService();
				
				authSvc.deleteAuthority(staNo);
				
				Integer funcNo = null;
				if (str2 != null) {
					for (int i = 0; i < str2.length; i++) {
						try {
							funcNo = new Integer(str2[i]);
						} catch (Exception e) {
							errorMsgs.add("功能代碼不正確");
						}
						AuthorityVO authVO = new AuthorityVO();
						authVO.setStaNo(staNo);
						authVO.setFuncNo(funcNo);
						if (!errorMsgs.isEmpty()) {
							req.setAttribute("authVO", authVO); // 含有輸入格式錯誤的LecVO物件,也存入req
							RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Authority/addAuthMuti.jsp");
							failureView.forward(req, res);
							return;
						}
//						AuthorityService authSvc2 = new AuthorityService();
//						authSvc2.deleteAuthority(staNo);
						authVO = authSvc.addAuthority(staNo, funcNo);
					
					}
//					AuthorityService authSvc = new AuthorityService();
					List<AuthorityVO> list=authSvc.getAllByStaNo(staNo);
					req.setAttribute("list", list);
				}
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Authority/listAll_auth.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAll_lec.jsp
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Authority/addAuthMuti.jsp");
				failureView.forward(req, res);
			}
		}
		if ("listAll_auth".equals(action) || "listAll_authByFunc".equals(action)) { // 來自listAll_lec.jsp

			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer staNo = new Integer(req.getParameter("staNo"));
				Integer funcNo = new Integer(req.getParameter("funcNo"));
				/*************************** 2.開始刪除資料 ***************************************/
				AuthorityService authSvc = new AuthorityService();
				authSvc.deleteAuthority(staNo,funcNo);
				List<AuthorityVO> list=authSvc.getAllByStaNo(staNo);
				req.setAttribute("list", list);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = null;
						if ("listAll_auth".equals(action))
							url = "/back-end/Authority/listAll_auth.jsp";        // 成功轉交 dept/listEmps_ByDeptno.jsp
						else if ("listAll_authByFunc".equals(action))
							url = "/back-end/Authority/listAll_authByFunc.jsp";   	
						
						
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Authority/listAll_auth.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("queryByStaNo".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer staNo = new Integer(req.getParameter("staNo"));
				
				/*************************** 2.開始查詢資料 ***************************************/
				AuthorityService authSvc = new AuthorityService();
				List<AuthorityVO> list=authSvc.getAllByStaNo(staNo);
				req.setAttribute("list", list);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Authority/listAll_auth.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("查詢資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Authority/listAll_auth.jsp");
				failureView.forward(req, res);
			}		
		}
		
		if ("queryByFuncNo".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer staNo = new Integer(req.getParameter("funcNo"));
				
				/*************************** 2.開始查詢資料 ***************************************/
				AuthorityService authSvc = new AuthorityService();
				List<AuthorityVO> list=authSvc.getAllByFuncNo(staNo);
				req.setAttribute("list", list);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Authority/listAll_authByFunc.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("查詢資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Authority/listAll_auth.jsp");
				failureView.forward(req, res);
			}
		}
	}

}
