package com.ptype.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.ptype.model.PtypeDAO;
import com.ptype.model.PtypeService;
import com.ptype.model.PtypeVO;
import com.product.model.ProductVO;

@WebServlet("/ptype/ptype.do")
@MultipartConfig
public class PtypeServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("ptypeNo");//str==null防呆用
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入商品類別編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ptype/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer ptypeNo = null;
				try {
					ptypeNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("商品類別編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ptype/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				PtypeService ptypeSvc = new PtypeService();
				PtypeVO ptypeVO = ptypeSvc.getOnePtype(ptypeNo);
				if (ptypeVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ptype/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("ptypeVO", ptypeVO); // 資料庫取出的ptypeVO物件,存入req
				String url = "/back-end/ptype/listOnePtype.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOnePtype.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ptype/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllPtype.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer ptypeNo = new Integer(req.getParameter("ptypeNo"));

				/*************************** 2.開始查詢資料 ****************************************/
				PtypeService ptypeSvc = new PtypeService();
				PtypeVO ptypeVO = ptypeSvc.getOnePtype(ptypeNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("ptypeVO", ptypeVO); // 資料庫取出的ptypeVO物件,存入req
				String url = "/back-end/ptype/update_ptype_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_ptype_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/ptype/listAllPtype.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // 來自update_ptype_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				Integer ptypeNo = new Integer(req.getParameter("ptypeNo").trim());
				
				String ptypeName = req.getParameter("ptypeName").trim();
				if (ptypeName == null || ptypeName.trim().length() == 0) {
					errorMsgs.add("名稱請勿空白");
				}
				
				PtypeService ptypeSvc = new PtypeService();
				PtypeVO ptypeVO = ptypeSvc.getOnePtype(ptypeNo);
				ptypeVO.setPtypeNo(ptypeNo);
				ptypeVO.setPtypeName(ptypeName);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("ptypeVO", ptypeVO); // 含有輸入格式錯誤的ptypeVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/ptype/update_ptype_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				/*************************** 2.開始修改資料 *****************************************/
				
				ptypeVO = ptypeSvc.updatePtype(ptypeNo, ptypeName);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("ptypeVO", ptypeVO); // 資料庫update成功後,正確的的ptypeVO物件,存入req
				String url = "/back-end/ptype/listOnePtype.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOnePtype.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/ptype/update_ptype_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("insert".equals(action)) { // 來自addPtype.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String ptypeName = req.getParameter("ptypeName");
				if (ptypeName == null || ptypeName.trim().length() == 0) {
					errorMsgs.add("名稱請勿空白");
				}

				PtypeVO ptypeVO = new PtypeVO();
				ptypeVO.setPtypeName(ptypeName);


				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("ptypeVO", ptypeVO); // 含有輸入格式錯誤的ptypeVO物件,也存入req

					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/ptype/addPtype.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				PtypeService ptypeSvc = new PtypeService();
				ptypeVO = ptypeSvc.addPtype(ptypeName);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/ptype/listAllPtype.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllPtype.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());

				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/ptype/addPtype.jsp");
				failureView.forward(req, res);

			}
		}
		
		if ("delete".equals(action)) { // 來自listAllPtype.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer ptypeNo = new Integer(req.getParameter("ptypeNo"));

				/*************************** 2.開始刪除資料 ***************************************/
				PtypeService ptypeSvc = new PtypeService();
				ptypeSvc.deletePtype(ptypeNo);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/ptype/listAllPtype.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/ptype/listAllPtype.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("listProducts_ByPtypeNo".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer ptypeNo = new Integer(req.getParameter("ptypeNo"));

				/*************************** 2.開始查詢資料 ****************************************/
				PtypeService ptypeSvc = new PtypeService();
				Set<ProductVO> set = ptypeSvc.getProductsByPtypeNo(ptypeNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("listProducts_ByPtypeNo", set);    // 資料庫取出的list物件,存入request

				String url = null;
				if ("listProducts_ByPtypeNo".equals(action)) {
					url = "/back-end/ptype/listProducts_ByPtypeNo.jsp";        // 成功轉交 ptype/listProducts_ByPtypeNo.jsp
				}        

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}

	}

}
