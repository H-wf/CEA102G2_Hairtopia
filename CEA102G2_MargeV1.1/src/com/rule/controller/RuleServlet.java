package com.rule.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.rule.model.*;
@MultipartConfig
public class RuleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RuleServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOne_For_Display".equals(action)) { // 來自select_rule_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("ruleNo");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入條款編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/rule/select_rule_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer ruleNo = null;
				try {
					ruleNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("新聞編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/rule/select_rule_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				RuleService ruleSvc = new RuleService();
				RuleVO ruleVO = ruleSvc.getOneRule(ruleNo);
				if (ruleVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/rule/select_rule_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("ruleVO", ruleVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/rule/listOneRule.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/rule/select_rule_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllRule.jsp  的請求
			try {
				Integer ruleNo = new Integer(req.getParameter("ruleNo"));
				RuleService ruleSvc = new RuleService();
				RuleVO ruleVO = ruleSvc.getOneRule(ruleNo);
				
				req.setAttribute("ruleVO", ruleVO);
				boolean openModal=true;
				req.setAttribute("openModal", openModal);
				
				String url = "/back-end/rule/listAllRule.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
				return;
				
			}catch (Exception e) {
				throw new ServletException(e);
			}
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/rule/listAllRule.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】		
//			try {
//				/***************************1.接收請求參數****************************************/
//				Integer ruleNo = new Integer(req.getParameter("ruleNo"));
//				
//				/***************************2.開始查詢資料****************************************/
//				RuleService ruleSvc = new RuleService();
//				RuleVO ruleVO = ruleSvc.getOneRule(ruleNo);
//				/***************************3.查詢完成,準備轉交(Send the Success view)************/
//				req.setAttribute("ruleVO", ruleVO); // 資料庫取出的ruleVO物件,存入req
//				
//				String url = "/back-end/rule/update_rule_input.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_rule_input.jsp
//				successView.forward(req, res);
//				
//				/***************************其他可能的錯誤處理************************************/
//			} catch (Exception e) {
//				errorMsgs.add("修改資料取出時失敗:"+e.getMessage());
//				System.out.println(requestURL);
//				RequestDispatcher failureView = req
//						.getRequestDispatcher(requestURL);
//				failureView.forward(req, res);
//			}
		}
		
		
		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			//String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer ruleNo = new Integer(req.getParameter("ruleNo").trim());

				String ruleName = req.getParameter("ruleName");
//				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (ruleName == null || ruleName.trim().length() == 0) {
					errorMsgs.add("標題: 請勿空白");
				} 
//				else if(!ruleName.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
//	            }
				
				String ruleCon = req.getParameter("ruleCon").trim();
				if (ruleCon == null || ruleCon.trim().length() == 0) {
					errorMsgs.add("內容請勿空白");
				}		

				RuleVO ruleVO = new RuleVO();
				ruleVO.setRuleNo(ruleNo);
				ruleVO.setRuleName(ruleName);
				ruleVO.setRuleCon(ruleCon);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("ruleVO", ruleVO); // 含有輸入格式錯誤的empVO物件,也存入req
					boolean openModal=true;
					req.setAttribute("openModal",openModal);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/rule/listAllRule.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				RuleService ruleSvc = new RuleService();
				ruleVO = ruleSvc.updateRule(ruleNo, ruleName, ruleCon);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/				
//				RuleService deptSvc = new RuleService();
//				if(requestURL.equals("/rule/listEmps_ByDeptno.jsp") || requestURL.equals("/rule/listAllDept.jsp"))
//					req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(deptno)); // 資料庫取出的list物件,存入request
				req.setAttribute("ruleVO", ruleVO);
                //String url = requestURL;
				String url = "/back-end/rule/listAllRule.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/rule/listAllRule.jsp");
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
				String ruleName = req.getParameter("ruleName");
//				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (ruleName == null || ruleName.trim().length() == 0) {
					errorMsgs.add("標題: 請勿空白");
				}
//				else if(!ename.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
//	            }
				
				String ruleCon = req.getParameter("ruleCon").trim();
				if (ruleCon == null || ruleCon.trim().length() == 0) {
					errorMsgs.add("內容請勿空白");
				}
				
				RuleVO ruleVO = new RuleVO();
				ruleVO.setRuleName(ruleName);
				ruleVO.setRuleCon(ruleCon);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("ruleVO", ruleVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/rule/listAllRule.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				RuleService ruleSvc = new RuleService();
				ruleVO = ruleSvc.addRule(ruleName, ruleCon);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/rule/listAllRule.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/rule/listAllRule.jsp");
				failureView.forward(req, res);
			}
		}
		
       
		if ("delete".equals(action)) { // 來自listAllEmp.jsp 或  /dept/listEmps_ByDeptno.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			//String requestURL = req.getParameter("requestURL"); // 送出刪除的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】
			try {
				/***************************1.接收請求參數***************************************/
				Integer ruleNo = new Integer(req.getParameter("ruleNo"));
				
				/***************************2.開始刪除資料***************************************/
				RuleService ruleSvc = new RuleService();
				RuleVO ruleVO = ruleSvc.getOneRule(ruleNo);
				ruleSvc.deleteRule(ruleNo);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
//				DeptService deptSvc = new DeptService();
//				if(requestURL.equals("/dept/listEmps_ByDeptno.jsp") || requestURL.equals("/dept/listAllDept.jsp"))
//					req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(empVO.getDeptno())); // 資料庫取出的list物件,存入request
				
				//String url = requestURL;
				String url = "/back-end/rule/listAllRule.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/rule/listAllRule.jsp");
				failureView.forward(req, res);
			}
		}
	}
		


}
