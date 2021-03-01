package com.func.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.func.model.*;



public class FuncServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public FuncServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	
		doPost(req, res);
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				
				String str = req.getParameter("funcNo");
				if (str == null || (str.trim()).isEmpty() == true) {
					errorMsgs.add("請輸入功能編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Func/select_func_page.jsp");
					failureView.forward(req, res);
					return;
				}

				Integer funcNo = null;
				try {
					funcNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("功能編號格是不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Func/select_func_page.jsp");
					failureView.forward(req, res);
					return;// 蝔�葉�
				}

				/*************************** 2.開始查詢資料 *****************************************/
				FuncService funcSvc = new FuncService();
				FuncVO funcVO = funcSvc.getOneFunc(funcNo);
				if (funcVO == null) {
					errorMsgs.add("查無功能資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Func/select_func_page.jsp");
					failureView.forward(req, res);
					return;// 蝔�葉�
				}

				
				req.setAttribute("funcVO", funcVO); 
				String url = "/back-end/Func/listOneFunc.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ����漱 listOneLec.jsp
				successView.forward(req, res);

				/*************************** �隞���隤方��� *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Func/select_func_page.jsp");
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
				Integer funcNo = new Integer(req.getParameter("funcNo"));

				/*************************** 2.開始查詢資料 ****************************************/
				FuncService funcSvc = new FuncService();
				FuncVO funcVO = funcSvc.getOneFunc(funcNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("funcVO", funcVO); // 資料庫取出的lecVO物件,存入req
				String url = "/back-end/Func/update_func_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_lec_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Func/listAll_func.jsp");
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

				Integer funcNo = new Integer(req.getParameter("funcNo").trim());

				String funcName = req.getParameter("funcName");

				String lecNameReg = "^[(\\u4e00-\\u9fa5)(a-zA-Z0-9_)]{2,40}$";
				if (funcName == null || funcName.trim().isEmpty() == true) {

					errorMsgs.add("功能名稱:請勿空白");
				} else if (!funcName.trim().matches(lecNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("功能名稱: 中英文字母、數字和_ , 且長度必需在2到40之間");
				}

				
				
				// 有上傳圖片走的路徑
				FuncVO funcVO = new FuncVO();
				funcVO.setFuncNo(funcNo);
				funcVO.setFuncName(funcName);
				
		

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("funcVO", funcVO); // 含有輸入格式錯誤的lecVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Func/update_func_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				/*************************** 2.開始修改資料 *****************************************/
				FuncService funcSvc = new FuncService();
				// 下方if判斷式判斷以哪一個指令更新資料
			
					funcVO = funcSvc.updateFunc(funcNo, funcName);
				

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("funcVO",funcVO); // 資料庫update成功後,正確的的lecVO物件,存入req
				String url = "/back-end/Func/listOneFunc.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneLec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Func/update_func_input.jsp");
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
				String funcName = req.getParameter("funcName");

				String lecNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,40}$";
				if (funcName == null || funcName.trim().isEmpty() == true) {
					errorMsgs.add("功能名稱: 請勿空白");
				} else if (!funcName.trim().matches(lecNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("功能名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到40之間");
				}

				
					FuncVO funcVO = new FuncVO();
					funcVO.setFuncName(funcName);
					

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("funcVO", funcVO); // 含有輸入格式錯誤的LecVO物件,也存入req
					
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Func/addFunc.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				FuncService funcSvc = new FuncService();
				funcVO = funcSvc.addFunc(funcName);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Func/listAll_func.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAll_lec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());

				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Func/addFunc.jsp");
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
				Integer funcNo = new Integer(req.getParameter("funcNo"));

				/*************************** 2.開始刪除資料 ***************************************/
				FuncService funcSvc = new FuncService();
				funcSvc.deleteFunc(funcNo);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Func/listAll_func.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Func/listAll_func.jsp");
				failureView.forward(req, res);
			}
		}

		
		
		
		

		
	}

}
