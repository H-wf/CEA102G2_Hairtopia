package com.schedule.controller;

import java.io.IOException;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import com.schedule.model.*;


public class ScheduleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ScheduleServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		

		if ("insert".equals(action)) { // 來自addEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				Integer desNo = null;
				try {
					desNo = new Integer(req.getParameter("desNo").trim());
				} catch (NumberFormatException e) {
					desNo = 0;
					errorMsgs.add("設計師編號請填數字.");
				}
				String schStatus = req.getParameter("schStatus").trim();
				if (schStatus == null || schStatus.trim().length() == 0) {
					errorMsgs.add("班表狀態請勿空白");
				}

				java.sql.Date schDate = null;
				try {
					schDate = java.sql.Date.valueOf(req.getParameter("schDate").trim());
				} catch (IllegalArgumentException e) {
					schDate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				ScheduleVO schVO = new ScheduleVO();
				schVO.setDesNo(desNo);
				schVO.setSchDate(schDate);
				schVO.setSchStatus(schStatus);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("schVO", schVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/Schedule/check_DailySchedule.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				ScheduleService schSvc = new ScheduleService();
				schVO = schSvc.addSchedule(desNo, schDate, schStatus);
				schVO = schSvc.getOneSchdule(desNo, schDate);
				req.setAttribute("schVO", schVO);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/Schedule/listOneSchedule.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Schedule/check_DailySchedule.jsp");
				failureView.forward(req, res);
			}
		}

		if ("queryByDesNo".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer desNo = null;
				try {
					desNo = new Integer(req.getParameter("desNo").trim());
				} catch (NumberFormatException e) {
					desNo = 0;
					errorMsgs.add("設計師編號請填數字.");
				}

				java.sql.Date schDate = null;
				try {
					schDate = java.sql.Date.valueOf(req.getParameter("schDate").trim());
				} catch (IllegalArgumentException e) {
					schDate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/Schedule/select_schedule_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ScheduleService schSvc = new ScheduleService();
				ScheduleVO schVO = schSvc.getOneSchdule(desNo, schDate);
				if (schVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/Schedule/select_schedule_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("schVO", schVO); // 資料庫取出的empVO物件,存入req
				String url = "/front-end/Schedule/listOneSchedule.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/Schedule/select_schedule_page.jsp");
				failureView.forward(req, res);
			}
		}
		if ("querySchedulesByDesNo".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer desNo = null;
				try {
					desNo = new Integer(req.getParameter("desNo").trim());
				} catch (NumberFormatException e) {
					desNo = 0;
					errorMsgs.add("設計師編號請填數字.");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/Schedule/select_schedule_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ScheduleService schSvc = new ScheduleService();
				List<ScheduleVO> list = new ArrayList<ScheduleVO>();
				list = schSvc.getAll(desNo);
				if (list.size() == 0) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/Schedule/select_schedule_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("list", list); // 資料庫取出的empVO物件,存入req
				String url = "/front-end/Schedule/listAll_Schedule.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/Schedule/select_schedule_page.jsp");
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
				Integer schNo = new Integer(req.getParameter("schNo"));
				Integer desNo = new Integer(req.getParameter("desNo"));
				/*************************** 2.開始刪除資料 ***************************************/
				ScheduleService schSvc = new ScheduleService();
				schSvc.deleteSchdule(schNo);
				List<ScheduleVO> list = new ArrayList<ScheduleVO>();
				list = schSvc.getAll(desNo);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("list", list);
				String url = "/front-end/Schedule/listAll_Schedule.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Schedule/listAll_Schedule.jsp");
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
				Integer desNo = new Integer(req.getParameter("desNo"));
				java.sql.Date schDate = null;
				try {
					schDate = java.sql.Date.valueOf(req.getParameter("schDate").trim());
				} catch (IllegalArgumentException e) {
					schDate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				/*************************** 2.開始查詢資料 ****************************************/
				ScheduleService schSvc = new ScheduleService();
				ScheduleVO schVO = schSvc.getOneSchdule(desNo, schDate);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("schVO", schVO); // 資料庫取出的lecVO物件,存入req
				String url = "/front-end/Schedule/update_dailySchedule.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_lec_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Schedule/listOneSchedule.jsp");
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

				Integer schNo = new Integer(req.getParameter("schNo").trim());
				Integer desNo = new Integer(req.getParameter("desNo").trim());
				String schStatus = req.getParameter("schStatus");

				java.sql.Date schDate = null;
				try {
					schDate = java.sql.Date.valueOf(req.getParameter("schDate").trim());
				} catch (IllegalArgumentException e) {
					schDate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}			
				ScheduleVO schVO = new ScheduleVO();
				schVO.setSchNo(schNo);
				schVO.setDesNo(desNo);
				schVO.setSchStatus(schStatus);
				schVO.setSchDate(schDate);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("schVO", schVO); // 含有輸入格式錯誤的staVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Schedule/update_dailySchedule.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				/*************************** 2.開始修改資料 *****************************************/
				ScheduleService schSvc = new ScheduleService();
				// 下方if判斷式判斷以哪一個指令更新資料
			
					schVO = schSvc.updateSchedule(schNo, desNo,schDate,schStatus);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("schVO", schVO); // 資料庫update成功後,正確的的lecVO物件,存入req
				String url = "/front-end/Schedule/listOneSchedule.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneLec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Schedule/update_dailySchedule.jsp");
				failureView.forward(req, res);
			}
		}
	}

}
