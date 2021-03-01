package com.trend.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.trend.model.TrendService;
import com.trend.model.TrendVO;

public class TrendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public TrendServlet() {
		super();

	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { // 來自select_lec_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("treNo");
				if (str == null || (str.trim()).isEmpty() == true) {
					errorMsgs.add("請輸入風格誌編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Trend/select_tre_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer treNo = null;
				try {
					treNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("風格誌編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Trend/select_tre_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				TrendService treSvc = new TrendService();
				TrendVO treVO = treSvc.getOneTrend(treNo);
				if (treVO == null) {
					errorMsgs.add("查無風格誌資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Trend/select_tre_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("treVO", treVO); // 資料庫取出的lecVO物件,存入req
				String url = "/back-end/Trend/listOneTre.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneLec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Trend/select_tre_page.jsp");
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
				Integer treNo = new Integer(req.getParameter("treNo"));

				/*************************** 2.開始查詢資料 ****************************************/
				TrendService treSvc = new TrendService();
				TrendVO treVO = treSvc.getOneTrend(treNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("treVO", treVO); // 資料庫取出的lecVO物件,存入req
				String url = "/back-end/Trend/update_tre_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_lec_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Trend/listAll_tre.jsp");
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

				Integer treNo = new Integer(req.getParameter("treNo").trim());

				String treTitle = req.getParameter("treTitle");

				String lecNameReg = "^[(\\u4e00-\\u9fa5)(a-zA-Z0-9_,，.。  )]{1,40}$";
				if (treTitle == null || treTitle.trim().isEmpty() == true) {

					errorMsgs.add("風格誌標題:請勿空白");
				} else if (!treTitle.trim().matches(lecNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("風格誌標題: 英文字母、數字和_ , 且長度必需在2到40之間");
				}

				String treCon = req.getParameter("treCon").trim();
				
				if (treCon == null || treCon.trim().isEmpty() == true) {
					errorMsgs.add("內容請勿空白");
				} else if (treCon.length()>3000 || treCon.length() < 5) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("內容: 英文字母、數字和_ , 且長度必需在5到3000之間");
				}

				java.sql.Timestamp treTime = null;
				try {
					treTime = java.sql.Timestamp.valueOf(req.getParameter("treTime").trim());
				} catch (IllegalArgumentException e) {
					treTime = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入上傳時間!");
				}

				TrendVO treVO = new TrendVO();
				treVO.setTreNo(treNo);
				treVO.setTreTitle(treTitle);
				treVO.setTreCon(treCon);
				treVO.setTreTime(treTime);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("treVO", treVO); // 含有輸入格式錯誤的staVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Trend/update_tre_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				/*************************** 2.開始修改資料 *****************************************/
				TrendService treSvc = new TrendService();
				// 下方if判斷式判斷以哪一個指令更新資料

				treVO = treSvc.updateTrend(treNo, treTitle, treCon, treTime);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("treVO", treVO); // 資料庫update成功後,正確的的lecVO物件,存入req
				String url = "/back-end/Trend/listOneTre.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneLec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Trend/update_tre_input.jsp");
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
				String treTitle = req.getParameter("treTitle");

				String lecNameReg = "^[(\\u4e00-\\u9fa5)(a-zA-Z0-9_,，.。 )]{1,40}$";
				if (treTitle == null || treTitle.trim().isEmpty() == true) {

					errorMsgs.add("風格誌標題:請勿空白");
				} else if (!treTitle.trim().matches(lecNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("風格誌標題: 英文字母、數字和_ , 且長度必需在2到40之間");
				}

				String treCon = req.getParameter("treCon").trim();
				
				if (treCon == null || treCon.trim().isEmpty() == true) {
					errorMsgs.add("內容請勿空白");
				} else if (treCon.length() > 3000 || treCon.length() < 5) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("內容: 長度必需在5到3000之間");
				}

				java.sql.Timestamp treTime = null;
				try {
					treTime = java.sql.Timestamp.valueOf(req.getParameter("treTime").trim());
				} catch (IllegalArgumentException e) {
					treTime = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入上傳時間!");
				}

				TrendVO treVO = new TrendVO();

				treVO.setTreTitle(treTitle);
				treVO.setTreCon(treCon);
				treVO.setTreTime(treTime);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("treVO", treVO); // 含有輸入格式錯誤的LecVO物件,也存入req

					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Trend/addTre.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				TrendService treSvc = new TrendService();
				treVO = treSvc.addTrend(treTitle, treCon, treTime);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Trend/listAll_tre.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAll_lec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());

				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Trend/addTre.jsp");
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
				Integer treNo = new Integer(req.getParameter("treNo"));

				/*************************** 2.開始刪除資料 ***************************************/
				TrendService treSvc = new TrendService();
				treSvc.deleteTrend(treNo);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Trend/listAll_tre.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Trend/listAll_tre.jsp");
				failureView.forward(req, res);
			}
		}

	}

}
