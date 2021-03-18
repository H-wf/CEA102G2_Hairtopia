package com.orderdetail.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
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

import com.orderdetail.model.OrderDetailDAO;
import com.orderdetail.model.OrderDetailService;
import com.orderdetail.model.OrderDetailVO;
import com.product.model.ProductService;
import com.product.model.ProductVO;


@MultipartConfig
public class OrderDetailServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");		
		HttpSession session = req.getSession();
		@SuppressWarnings("unchecked")
		List<OrderDetailVO> buylist = (Vector<OrderDetailVO>) session.getAttribute("shoppingcart");

		if (action.equals("DELETE")||action.equals("ADD")) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			Object account = session.getAttribute("account");
			if (account == null) {
				res.sendRedirect(req.getContextPath() + "/front-end/member/login.jsp");
				return;
			}
			// 刪除購物車中的訂單明細
			if (action.equals("DELETE")) {
				String del = req.getParameter("del");
				int d = Integer.parseInt(del);
				buylist.remove(d);
			}
			// 新增訂單明細至購物車中
			else if (action.equals("ADD")) {
				
				// 取得後來新增的訂單明細
				String proNo = req.getParameter("proNo");
				Integer proPrice = new Integer(req.getParameter("proPrice"));
				Integer ordDetAmt = new Integer(req.getParameter("ordDetAmt"));
				OrderDetailVO orderdetailVO = new OrderDetailVO();
		
				orderdetailVO.setProNo(new Integer(proNo));
				orderdetailVO.setOrdDetPrice(proPrice*ordDetAmt);
				orderdetailVO.setOrdDetAmt(ordDetAmt);
	
				if (buylist == null) {
					buylist = new Vector<OrderDetailVO>();
					buylist.add(orderdetailVO);
				} else {
					if (buylist.contains(orderdetailVO)) {
						OrderDetailVO innerOrderDetailVO = buylist.get(buylist.indexOf(orderdetailVO));
						innerOrderDetailVO.setOrdDetAmt(innerOrderDetailVO.getOrdDetAmt() + orderdetailVO.getOrdDetAmt());
					} else {
						buylist.add(orderdetailVO);
					}
				}
					
			}
	
			session.setAttribute("shoppingcart", buylist);
			String url = "/front-end/product/EShop.jsp";
			RequestDispatcher rd = req.getRequestDispatcher(url);
			rd.forward(req, res);
			
		}

		// 結帳，計算購物車訂單明細價錢總數
		else if (action.equals("CHECKOUT")) {
			Integer total = 0;
			for (int i = 0; i < buylist.size(); i++) {
				OrderDetailVO order = buylist.get(i);
				Integer ordDetPrice = order.getOrdDetPrice();
				
				Integer ordDetAmt = order.getOrdDetAmt();
				
				total += (ordDetPrice * ordDetAmt);
			}

			String ordAmt = String.valueOf(total);
			req.setAttribute("ordAmt", ordAmt);
			String url = "/front-end/product/Checkout.jsp";
			RequestDispatcher rd = req.getRequestDispatcher(url);
			rd.forward(req, res);
		}
		
		
		if ("listOrderDetails_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				/***************************1.將輸入資料轉為Map**********************************/ 
				//採用Map<String,String[]> getParameterMap()的方法 
				//注意:an immutable java.util.Map 
				Map<String, String[]> map = req.getParameterMap();
System.out.println(map);
				/***************************2.開始複合查詢***************************************/
				OrderDetailService orderdetailSvc = new OrderDetailService();
				List<OrderDetailVO> list  = orderdetailSvc.getAll(map);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("listOrderDetails_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/orderdetail/listOrderDetails_ByCompositeQuery.jsp"); // 成功轉交listOrderDetails_ByCompositeQuery.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/orderdetail/select_page.jsp");
				failureView.forward(req, res);
			}
		}
	}

}
