package com.brand.controller;

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

import com.brand.model.BrandDAO;
import com.brand.model.BrandService;
import com.brand.model.BrandVO;
import com.product.model.ProductVO;


@MultipartConfig
public class BrandServlet extends HttpServlet {

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
				String str = req.getParameter("braNo");//str==null防呆用
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入品牌編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/brand/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer braNo = null;
				try {
					braNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("品牌編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/brand/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				BrandService braSvc = new BrandService();
				BrandVO brandVO = braSvc.getOneBrand(braNo);
				if (brandVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/brand/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("brandVO", brandVO); // 資料庫取出的brandVO物件,存入req
				String url = "/back-end/brand/listOneBrand.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneBrand.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/brand/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllBrand.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer braNo = new Integer(req.getParameter("braNo"));

				/*************************** 2.開始查詢資料 ****************************************/
				BrandService braSvc = new BrandService();
				BrandVO brandVO = braSvc.getOneBrand(braNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("brandVO", brandVO); // 資料庫取出的brandVO物件,存入req
				String url = "/back-end/brand/update_bra_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_bra_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/brand/listAllBrand.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // 來自update_bra_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				Integer braNo = new Integer(req.getParameter("braNo").trim());
				
				String braName = req.getParameter("braName").trim();
				if (braName == null || braName.trim().length() == 0) {
					errorMsgs.add("名稱請勿空白");
				}

				String braIntro = req.getParameter("braIntro").trim();
				if (braIntro == null || braIntro.trim().length() == 0) {
					errorMsgs.add("介紹請勿空白");
				}

				byte[] braLogo = null;
				BrandService braSvc = new BrandService();
				BrandVO brandVO = braSvc.getOneBrand(braNo);
				try {
					Part part = req.getPart("braLogo");
					if (part.getSize() != 0) {
						InputStream is = part.getInputStream();
						braLogo = new byte[is.available()];
						is.read(braLogo);
						brandVO.setBraLogo(braLogo);
						is.close();	
					}else {
						braLogo=brandVO.getBraLogo();
						brandVO.setBraLogo(braLogo);
					}
				} catch (Exception e) {
					errorMsgs.add("有問題");
				}
				
				
				brandVO.setBraNo(braNo);
				brandVO.setBraName(braName);
				
				brandVO.setBraIntro(braIntro);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("brandVO", brandVO); // 含有輸入格式錯誤的brandVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/brand/update_bra_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				/*************************** 2.開始修改資料 *****************************************/
				
				brandVO = braSvc.updateBrand(braNo, braName, braLogo, braIntro);
				System.out.println(brandVO.getBraNo());

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("brandVO", brandVO); // 資料庫update成功後,正確的的brandVO物件,存入req
				String url = "/back-end/brand/listOneBrand.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneBrand.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/brand/update_bra_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("insert".equals(action)) { // 來自addBrand.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String braName = req.getParameter("braName");
				if (braName == null || braName.trim().length() == 0) {
					errorMsgs.add("名稱請勿空白");
				}

				String braIntro = req.getParameter("braIntro").trim();
				if (braIntro == null || braIntro.trim().length() == 0) {
					errorMsgs.add("介紹請勿空白");
				}

				byte[] braLogo = null;
				try {
					Part part = req.getPart("braLogo");

					InputStream is = part.getInputStream();
					braLogo = new byte[is.available()];
					is.read(braLogo);

					is.close();
				} catch (Exception e) {
					errorMsgs.add("有問題");
				}
				BrandVO brandVO = new BrandVO();
				brandVO.setBraName(braName);
				brandVO.setBraLogo(braLogo);
				brandVO.setBraIntro(braIntro);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("brandVO", brandVO); // 含有輸入格式錯誤的brandVO物件,也存入req

					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/brand/addBrand.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				BrandService braSvc = new BrandService();
				brandVO = braSvc.addBrand(braName, braLogo, braIntro);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/brand/listAllBrand.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllBrand.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());

				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/brand/addBrand.jsp");
				failureView.forward(req, res);

			}
		}
		
		if ("delete".equals(action)) { // 來自listAllBrand.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer braNo = new Integer(req.getParameter("braNo"));

				/*************************** 2.開始刪除資料 ***************************************/
				BrandService braSvc = new BrandService();
				braSvc.deleteBrand(braNo);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/brand/listAllBrand.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/brand/listAllBrand.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("listProducts_ByBraNo".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer braNo = new Integer(req.getParameter("braNo"));

				/*************************** 2.開始查詢資料 ****************************************/
				BrandService brandSvc = new BrandService();
				Set<ProductVO> set = brandSvc.getProductsByBraNo(braNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("listProducts_ByBraNo", set);    // 資料庫取出的list物件,存入request

				String url = null;
				if ("listProducts_ByBraNo".equals(action)) {
					url = "/back-end/brand/listProducts_ByBraNo.jsp";        // 成功轉交 brand/listProducts_ByBraNo.jsp
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
