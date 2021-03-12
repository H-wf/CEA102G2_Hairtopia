package com.staff.controller;

import java.io.IOException;

import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.staff.model.*;

/**
 * Servlet implementation class StaffServlet
 */

@MultipartConfig
public class StaffServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public StaffServlet() {
		super();

	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		System.out.println("login");
		if ("getOne_For_Display".equals(action)) { // 來自select_lec_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("staNo");
				if (str == null || (str.trim()).isEmpty() == true) {
					errorMsgs.add("請輸入員工編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Staff/select_sta_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				

				Integer staNo = null;
				try {
					staNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Staff/select_sta_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				StaffService staSvc = new StaffService();
				StaffVO staVO = staSvc.getOneStaff(staNo);
				if (staVO == null) {
					errorMsgs.add("查無員工資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Staff/select_sta_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("staVO", staVO); // 資料庫取出的lecVO物件,存入req
				String url = "/back-end/Staff/listOneSta.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneLec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Staff/select_sta_page.jsp");
				failureView.forward(req, res);
			}

		}

		if ("getOne_For_Update".equals(action)) { // 來自listAll_lec.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer staNo = new Integer(req.getParameter("staNo"));

				/*************************** 2.開始查詢資料 ****************************************/
				StaffService staSvc = new StaffService();
				StaffVO staVO = staSvc.getOneStaff(staNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("staVO", staVO); // 資料庫取出的lecVO物件,存入req
				String url = "/back-end/Staff/update_sta_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_lec_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Staff/listAll_sta.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_lec_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				Integer staNo = new Integer(req.getParameter("staNo").trim());

				String staAcct = req.getParameter("staAcct");

				String lecNameReg = "^[(a-zA-Z0-9_)]{2,30}$";
				if (staAcct == null || staAcct.trim().isEmpty() == true) {

					errorMsgs.add("員工帳號:請勿空白");
				} else if (!staAcct.trim().matches(lecNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工帳號: 英文字母、數字和_ , 且長度必需在2到30之間");
				}

				String staPswd = req.getParameter("staPswd").trim();
				
				if (staPswd == null || staPswd.trim().isEmpty() == true) {
					errorMsgs.add("密碼請勿空白");
				} else if (!staPswd.trim().matches(lecNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工密碼: 英文字母、數字和_ , 且長度必需在2到30之間");
				} 
				String staName = req.getParameter("staName");
				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (staName == null || staName.trim().length() == 0) {
					errorMsgs.add("員工姓名: 請勿空白");
				} else if(!staName.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }

				
				
				StaffVO staVO = new StaffVO();
				staVO.setStaNo(staNo);
				staVO.setStaName(staName);
				staVO.setStaAcct(staAcct);
				staVO.setStaPswd(staPswd);
			

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("staVO", staVO); // 含有輸入格式錯誤的staVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Staff/update_sta_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				/*************************** 2.開始修改資料 *****************************************/
				StaffService staSvc = new StaffService();
				// 下方if判斷式判斷以哪一個指令更新資料
			
					staVO = staSvc.updateStaff(staNo, staAcct, staPswd,staName);
				

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("staVO", staVO); // 資料庫update成功後,正確的的lecVO物件,存入req
				String url = "/back-end/Staff/listOneSta.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneLec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Staff/update_sta_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("insert".equals(action)) { // 來自addLec.jsp的請求
			

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

				String lecNameReg = "^[(a-zA-Z0-9_)]{2,40}$";
				if (staAcct == null || staAcct.trim().isEmpty() == true) {
					errorMsgs.add("員工帳號: 請勿空白");
				} else if (!staAcct.trim().matches(lecNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工帳號: 只能是英文字母、數字和_ , 且長度必需在2到40之間");
				}

				String staPswd = req.getParameter("staPswd").trim();

				if (staPswd == null || staPswd.trim().isEmpty() == true) {
					errorMsgs.add("密碼請勿空白");
				}else if (!staPswd.trim().matches(lecNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工密碼: 只能是英文字母、數字和_ , 且長度必需在2到40之間");
				}

					StaffVO staVO = new StaffVO();
					staVO.setStaAcct(staName);
					staVO.setStaAcct(staAcct);
					staVO.setStaPswd(staPswd);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("staVO", staVO); // 含有輸入格式錯誤的LecVO物件,也存入req
					
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Staff/addSta.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				StaffService staSvc = new StaffService();
				staVO = staSvc.addStaff(staAcct, staPswd,staName);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Staff/listAll_sta.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAll_lec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());

				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Staff/addSta.jsp");
				failureView.forward(req, res);

			}

		}
		
		if ("delete".equals(action)) { // 來自listAll_lec.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer staNo = new Integer(req.getParameter("staNo"));

				/*************************** 2.開始刪除資料 ***************************************/
				StaffService staSvc = new StaffService();
				staSvc.deleteStaff(staNo);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Staff/listAll_sta.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Staff/listAll_sta.jsp");
				failureView.forward(req, res);
			}
		}

		if ("login".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			String staAcct = req.getParameter("staAcct");
			if (staAcct == null || staAcct.trim().length() == 0) {
				errorMsgs.add("帳號請勿空白");
			}
			String staPswd = req.getParameter("staPswd");
			if (staPswd == null || staPswd.trim().length() == 0) {
				errorMsgs.add("帳號請勿空白");
			}
			/*************************** 2.開始查詢資料 *****************************************/
			StaffService staffSvc = new StaffService();
			StaffVO staffVO = staffSvc.validate(staAcct, staPswd);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			if (staffVO == null) { 
				errorMsgs.add("error account or password");
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Staff/login.jsp");
				failureView.forward(req, res);
			} else {
				HttpSession session = req.getSession();
				session.setAttribute("staAcct", staAcct);
				session.setAttribute("staPswd", staffVO);
				try {
					String location = (String) session.getAttribute("location");
					if (location != null) {
						session.removeAttribute("location"); // *工作2: 看看有無來源網頁 (-->如有來源網頁:則重導至來源網頁)
						res.sendRedirect(location);
						return;
					}
				} catch (Exception ignored) {
				}

				res.sendRedirect(req.getContextPath() + "/back-end/Staff/login_success.jsp");
			}
		}
	}

}
