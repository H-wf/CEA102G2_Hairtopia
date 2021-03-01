package com.sertype.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sertype.model.StypeService;
import com.sertype.model.StypeVO;

/**
 * Servlet implementation class StypeServlet
 */

public class StypeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StypeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
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
				
				String str = req.getParameter("stypeNo");
				if (str == null || (str.trim()).isEmpty() == true) {
					errorMsgs.add("請輸入服務類別編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Stype/select_stype_page.jsp");
					failureView.forward(req, res);
					return;
				}

				Integer stypeNo = null;
				try {
					stypeNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("服務類別編號格是不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Stype/select_stype_page.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始查詢資料 *****************************************/
				StypeService stypeSvc = new StypeService();
				StypeVO stypeVO = stypeSvc.getOneStype(stypeNo);
				if (stypeVO == null) {
					errorMsgs.add("查無服務類別資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Stype/select_stype_page.jsp");
					failureView.forward(req, res);
					return;
				}

				
				req.setAttribute("stypeVO", stypeVO); 
				String url = "/back-end/Stype/listOneStype.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/*************************** �隞���隤方��� *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Stype/select_stype_page.jsp");
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
				Integer stypeNo = new Integer(req.getParameter("stypeNo"));

				/*************************** 2.開始查詢資料 ****************************************/
				StypeService stypeSvc = new StypeService();
				StypeVO stypeVO = stypeSvc.getOneStype(stypeNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("stypeVO", stypeVO); // 資料庫取出的lecVO物件,存入req
				String url = "/back-end/Stype/update_stype_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_lec_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Stype/listAll_stype.jsp");
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

				Integer stypeNo = new Integer(req.getParameter("stypeNo").trim());

				String stypeName = req.getParameter("stypeName");

				String lecNameReg = "^[(\\u4e00-\\u9fa5)(a-zA-Z0-9_)]{2,15}$";
				if (stypeName == null || stypeName.trim().isEmpty() == true) {

					errorMsgs.add("類別名稱:請勿空白");
				} else if (!stypeName.trim().matches(lecNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("類別名稱: 中英文字母、數字和_ , 且長度必需在2到15之間");
				}

				
				
				// 有上傳圖片走的路徑
				StypeVO stypeVO = new StypeVO();
				stypeVO.setStypeNo(stypeNo);
				stypeVO.setStypeName(stypeName);
				
		

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("stypeVO", stypeVO); // 含有輸入格式錯誤的lecVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Stype/update_stype_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				/*************************** 2.開始修改資料 *****************************************/
				StypeService stypeSvc = new StypeService();
				// 下方if判斷式判斷以哪一個指令更新資料
			
					stypeVO = stypeSvc.updateStype(stypeNo, stypeName);
				

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("stypeVO",stypeVO); // 資料庫update成功後,正確的的lecVO物件,存入req
				String url = "/back-end/Stype/listOneStype.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneLec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Stype/update_stype_input.jsp");
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
				String stypeName = req.getParameter("stypeName");

				String lecNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,15}$";
				if (stypeName == null || stypeName.trim().isEmpty() == true) {
					errorMsgs.add("功能名稱: 請勿空白");
				} else if (!stypeName.trim().matches(lecNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("功能名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到15之間");
				}

				
					StypeVO stypeVO = new StypeVO();
					stypeVO.setStypeName(stypeName);
					

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("stypeVO", stypeVO); // 含有輸入格式錯誤的LecVO物件,也存入req
					
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Stype/addStype.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				StypeService stypeSvc = new StypeService();
				stypeVO = stypeSvc.addStype(stypeName);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Stype/listAll_stype.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAll_lec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());

				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Stype/addStype.jsp");
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
				Integer stypeNo = new Integer(req.getParameter("stypeNo"));

				/*************************** 2.開始刪除資料 ***************************************/
				StypeService stypeSvc = new StypeService();
				stypeSvc.deleteStype(stypeNo);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Stype/listAll_stype.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Stype/listAll_stype.jsp");
				failureView.forward(req, res);
			}
		}

	}

}
