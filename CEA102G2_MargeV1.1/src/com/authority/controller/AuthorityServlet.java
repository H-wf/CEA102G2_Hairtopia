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
import com.staff.model.StaffService;
import com.staff.model.StaffVO;

import util.MailServiceStaff;

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
				StaffService staSvc = new StaffService();
				StaffVO staVO = staSvc.getOneStaff(staNo);
				
				req.setAttribute("staVO", staVO);
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
				String staName = req.getParameter("staName");
				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (staName == null || staName.trim().length() == 0) {
					errorMsgs.add("員工姓名: 請勿空白");
				} else if(!staName.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }
				
				String staAcct = req.getParameter("staAcct");
				
				StaffService staSvc = new StaffService();
				StaffVO staVO2 = staSvc.getOneStaff(staAcct);
				if(staVO2 != null) {
					errorMsgs.add("此信箱已被使用");
				}

				StaffVO staVO = new StaffVO();
				staVO.setStaName(staName);
				staVO.setStaAcct(staAcct);
				
				String[] str2 = req.getParameterValues("funcNo");
				if(str2 == null) {
					errorMsgs.add("請選擇功能權限");
				}
				
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("staVO", staVO); // 含有輸入格式錯誤的LecVO物件,也存入req
					
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Authority/addAuthMuti.jsp");
					failureView.forward(req, res);
					return;
				}
					
				
				MailServiceStaff ms = new MailServiceStaff();
	
				String subject = "密碼通知";
				String staPswd = genAuthCode();
				String messageText = "Thanks for signing up!\r\n"
							+ "Your pasword has been reset, you can login with the following credentials.\r\n" + "  \r\n"
							+ "------------------------\r\n" + "Username: " + staName + "\r\n" + "Password: " + staPswd
							+ "\r\n" + "------------------------\r\n" + "  \r\n";
				ms.sendMail(staAcct, subject, messageText);
				Integer staStasus = new Integer("1");
				staVO = staSvc.addStaff(staAcct, staPswd,staName,staStasus);
				
				
				
				
				
				Integer staNo = null;
				try {
					staNo = staVO.getStaNo();
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

						authVO = authSvc.addAuthority(staNo, funcNo);
					
					}

					List<AuthorityVO> list=authSvc.getAllByStaNo(staNo);
					req.setAttribute("list", list);
					req.setAttribute("staVO", staVO);
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
				StaffService staSvc = new StaffService();
				StaffVO staVO = staSvc.getOneStaff(staNo);
				req.setAttribute("list", list);
				req.setAttribute("staVO", staVO);

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
				StaffService staSvc = new StaffService();
				StaffVO staVO = staSvc.getOneStaff(staNo);
				
				List<AuthorityVO> list=authSvc.getAllByStaNo(staNo);
				req.setAttribute("list", list);
				req.setAttribute("staVO", staVO);

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
	
	public String genAuthCode() {
		char[] authCode = new char[8];
		byte[] randNum = new byte[8];

		for (int i = 0; i < randNum.length; i++) {
			randNum[i] = (byte) (Math.random() * 62);

		}

		for (int i = 0; i < 8; i++) {
			if (randNum[i] >= 0 && randNum[i] <= 9) {
				authCode[i] = (char) (randNum[i] + 48);
			} else if (randNum[i] >= 10 && randNum[i] <= 35) {
				authCode[i] = (char) (randNum[i] + 55);
			} else if (randNum[i] >= 36 && randNum[i] <= 61) {
				authCode[i] = (char) (randNum[i] + 61);
			}
		}

		return new String(authCode);
	}

}
