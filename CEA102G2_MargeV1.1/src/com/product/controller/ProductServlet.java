package com.product.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.brand.model.BrandService;
import com.brand.model.BrandVO;
import com.product.model.ProductDAO;
import com.product.model.ProductService;
import com.product.model.ProductVO;
import org.json.JSONArray;

@MultipartConfig
public class ProductServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		HttpSession session = req.getSession();
		@SuppressWarnings("unchecked")
		List<ProductVO> buylist = (Vector<ProductVO>) session.getAttribute("shoppingcart");
	
		if (action.equals("DELETE")||action.equals("ADD")) {
			
			// 刪除購物車中的商品
			if (action.equals("DELETE")) {
				String del = req.getParameter("del");
				int d = Integer.parseInt(del);
				buylist.remove(d);
				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				PrintWriter out = res.getWriter();
				out.print(buylist.size());
				out.flush();
				out.close();
				return;
			}
			// 新增訂單明細至購物車中
			else if (action.equals("ADD")) {
				
				// 取得後來新增的商品
				Integer proNo = new Integer(req.getParameter("proNo")); System.out.println("proNo="+proNo);
				ProductService productSvc = new ProductService();
				ProductVO productVO = productSvc.getOneProduct(proNo);				
				Integer quantity = new Integer(req.getParameter("quantity"));
				productVO.setQuantity(quantity);
				
				if (buylist == null) {
					buylist = new Vector<ProductVO>();
					buylist.add(productVO);
				} else {
					if (buylist.contains(productVO)) {
						ProductVO innerProductVO = buylist.get(buylist.indexOf(productVO));
						innerProductVO.setQuantity(innerProductVO.getQuantity() + productVO.getQuantity());
					} else {
						buylist.add(productVO);
					}
				}									
			}
			Integer sum=0;
			for(ProductVO productVO:buylist ) {
				sum+=productVO.getQuantity();
			}
			session.getAttribute("sum");
			session.setAttribute("sum", sum);
			session.setAttribute("shoppingcart", buylist);
			String jsonStr = new JSONArray(buylist).toString();
			
			System.out.println(jsonStr);
			
			res.setContentType("text/plain");
			res.setCharacterEncoding("UTF-8");
			PrintWriter out = res.getWriter();
			out.print(jsonStr);
			out.flush();
			out.close();
			return;
//			String url = "/front-end/product/EShop.jsp";
//			RequestDispatcher rd = req.getRequestDispatcher(url);
//			rd.forward(req, res);
			
		}

		// 結帳，計算購物車訂單明細價錢總數
		else if (action.equals("CHECKOUT")) {
			Integer total = 0;		
			for (int i = 0; i < buylist.size(); i++) {
				ProductVO order = buylist.get(i);
				Integer ordDetAmt = order.getProPrice()*order.getQuantity();				
				total += ordDetAmt ;
			}
			String ordAmt = String.valueOf(total);
			session.setAttribute("ordAmt", ordAmt);
			String url = "/front-end/product/Checkout.jsp";
			RequestDispatcher rd = req.getRequestDispatcher(url);
			rd.forward(req, res);
		}

		String from = req.getParameter("from");
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				
				String str = req.getParameter("proNo");//str==null防呆用
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入商品編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/"+from+"/product/listAllProduct.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer proNo = null;
				try {
					proNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("商品編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/"+from+"/product/listAllProduct.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				ProductService productSvc = new ProductService();
				ProductVO productVO = productSvc.getOneProduct(proNo);
				if (productVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/"+from+"/product/listAllProduct.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("productVO", productVO); // 資料庫取出的productVO物件,存入req
				String url = "/"+from+"/product/listOneProduct.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneProduct.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/"+from+"/product/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllProduct.jsp的請求
			try {
				
				Integer proNo = new Integer(req.getParameter("proNo"));
				
				ProductService productSvc = new ProductService();
				ProductVO productVO = productSvc.getOneProduct(proNo);
				
				req.setAttribute("productVO", productVO); 
				//Bootstrap_modal
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				String url = "/back-end/product/listAllProduct.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
				return;

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				/*************************** 1.接收請求參數 ****************************************/
//				Integer proNo = new Integer(req.getParameter("proNo"));
//
//				/*************************** 2.開始查詢資料 ****************************************/
//				ProductService productSvc = new ProductService();
//				ProductVO productVO = productSvc.getOneProduct(proNo);
//
//				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
//				req.setAttribute("productVO", productVO); // 資料庫取出的productVO物件,存入req
//				String url = "/back-end/product/update_product_input.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_product_input.jsp
//				successView.forward(req, res);
//
//				/*************************** 其他可能的錯誤處理 **********************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/product/listAllProduct.jsp");
//				failureView.forward(req, res);
//			}
		}
		
		if ("update".equals(action)) { // 來自update_product_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				Integer proNo = new Integer(req.getParameter("proNo").trim());
				
				Integer ptypeNo = new Integer(req.getParameter("ptypeNo").trim());
				
				Integer braNo = new Integer(req.getParameter("braNo").trim());
				
				String proName = req.getParameter("proName").trim();
				if (proName == null || proName.trim().length() == 0) {
					errorMsgs.add("商品名稱請勿空白");
				}
							
				Boolean proStatus = Boolean.parseBoolean(req.getParameter("proStatus").trim());
				
				Integer proPrice = null;
				try {
					proPrice = new Integer(req.getParameter("proPrice").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("商品單價請勿空白");
				}
				
				byte[] proMpic = null;
				ProductService productSvc = new ProductService();
				ProductVO productVO = productSvc.getOneProduct(proNo);
				try {
					Part part = req.getPart("proMpic");
					if (part.getSize() != 0) {
						InputStream is = part.getInputStream();
						proMpic = new byte[is.available()];
						is.read(proMpic);
						productVO.setProMpic(proMpic);
						is.close();	
					}else {
						proMpic=productVO.getProMpic();
						productVO.setProMpic(proMpic);
					}
				} catch (Exception e) {
					errorMsgs.add("有問題");
				}
				
				byte[] proPic = null;
				try {
					Part part = req.getPart("proPic");
					if (part.getSize() != 0) {
						InputStream is = part.getInputStream();
						proPic = new byte[is.available()];
						is.read(proPic);
						productVO.setProPic(proPic);
						is.close();	
					}else {
						proPic=productVO.getProPic();
						productVO.setProPic(proPic);
					}
				} catch (Exception e) {
					errorMsgs.add("有問題");
				}
				
				String proDesc = req.getParameter("proDesc");
				if (proDesc == null || proDesc.trim().length() == 0) {
					errorMsgs.add("商品描述請勿空白");
				}
				
				productVO.setProNo(proNo);
				productVO.setPtypeNo(ptypeNo);
				productVO.setBraNo(braNo);
				productVO.setProName(proName);
				productVO.setProStatus(proStatus);
				productVO.setProPrice(proPrice);
				productVO.setProDesc(proDesc);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("productVO", productVO); // 含有輸入格式錯誤的productVO物件,也存入req
					boolean openModal=true;
					req.setAttribute("openModal",openModal);
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/product/listAllProduct.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				/*************************** 2.開始修改資料 *****************************************/
				
				productVO = productSvc.updateProduct(proNo, ptypeNo, braNo, proName, proStatus, proPrice, proMpic, proPic, proDesc);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("productVO", productVO); // 資料庫update成功後,正確的的productVO物件,存入req
				String url = "/back-end/product/listAllProduct.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneProduct.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/product/listAllProduct.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("insert".equals(action)) { // 來自addProduct.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				Integer ptypeNo = new Integer(req.getParameter("ptypeNo").trim());
				
				Integer braNo = new Integer(req.getParameter("braNo").trim());
				
				String proName = req.getParameter("proName").trim();
				if (proName == null || proName.trim().length() == 0) {
					
					errorMsgs.add("商品名稱請勿空白");					
				}
				
				Boolean proStatus = Boolean.parseBoolean(req.getParameter("proStatus").trim());
				
				Integer proPrice = null;
				try {
					proPrice = new Integer(req.getParameter("proPrice").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("商品單價請勿空白");
				}
				
				byte[] proMpic = null;
				try {
					Part part = req.getPart("proMpic");
					InputStream is = part.getInputStream();
					proMpic = new byte[is.available()];
					is.read(proMpic);
				
					is.close();	
				} catch (Exception e) {
					errorMsgs.add("有問題");
				}
				
				byte[] proPic = null;
				try {
					Part part = req.getPart("proPic");
					InputStream is = part.getInputStream();
					proPic = new byte[is.available()];
					is.read(proPic);
				
					is.close();	
				} catch (Exception e) {
					errorMsgs.add("有問題");
				}
				
				String proDesc = req.getParameter("proDesc");
				if (proDesc == null || proDesc.trim().length() == 0) {
					errorMsgs.add("商品描述請勿空白");
				}

				
				ProductVO productVO = new ProductVO();
				productVO.setPtypeNo(ptypeNo);
				productVO.setBraNo(braNo);
				productVO.setProName(proName);
				productVO.setProStatus(proStatus);
				productVO.setProPrice(proPrice);
				productVO.setProMpic(proMpic);
				productVO.setProPic(proPic);
				productVO.setProDesc(proDesc);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {					
					req.setAttribute("productVO", productVO); // 含有輸入格式錯誤的productVO物件,也存入req

					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/product/listAllProduct.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				ProductService productSvc = new ProductService();
				productVO = productSvc.addProduct(ptypeNo, braNo, proName, proStatus, proPrice, proMpic, proPic, proDesc);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/product/listAllProduct.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllProduct.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/product/listAllProduct.jsp");
				failureView.forward(req, res);

			}
		}
		
		if ("delete".equals(action)) { // 來自listAllProduct.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer proNo = new Integer(req.getParameter("proNo"));

				/*************************** 2.開始刪除資料 ***************************************/
				ProductService productSvc = new ProductService();
				productSvc.deleteProduct(proNo);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/product/listAllProduct.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/product/listAllProduct.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("listProducts_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				/***************************1.將輸入資料轉為Map**********************************/ 
				//採用Map<String,String[]> getParameterMap()的方法 
				//注意:an immutable java.util.Map 
				Map<String, String[]> map = req.getParameterMap();

				/***************************2.開始複合查詢***************************************/
				ProductService productSvc = new ProductService();
				List<ProductVO> list  = productSvc.getAll(map);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("listProducts_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/product/listProducts_ByCompositeQuery.jsp"); // 成功轉交listProducts_ByCompositeQuery.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/product/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("listProducts_ByCompositeQuery_Ajax".equals(action)) { // 來自select_page.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				/***************************1.將輸入資料轉為Map**********************************/ 
				//採用Map<String,String[]> getParameterMap()的方法 
				//注意:an immutable java.util.Map 
				Map<String, String[]> map = req.getParameterMap();

				/***************************2.開始複合查詢***************************************/
				ProductService productSvc = new ProductService();
				List<ProductVO> list  = productSvc.getAll(map);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				String jsonStr = new JSONArray(list).toString();
				
				System.out.println(jsonStr);
				
				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				PrintWriter out = res.getWriter();
				out.print(jsonStr);
				out.flush();
				out.close();
				return;
//				req.setAttribute("listProducts_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
//				RequestDispatcher successView = req.getRequestDispatcher("/back-end/product/listProducts_ByCompositeQuery.jsp"); // 成功轉交listProducts_ByCompositeQuery.jsp
//				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/product/select_page.jsp");
				failureView.forward(req, res);
			}
		}		
	}
}
