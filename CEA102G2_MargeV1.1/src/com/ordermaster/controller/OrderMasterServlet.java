package com.ordermaster.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
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

import com.orderdetail.model.OrderDetailVO;
import com.ordermaster.model.OrderMasterDAO;
import com.ordermaster.model.OrderMasterService;
import com.ordermaster.model.OrderMasterVO;
import com.product.model.ProductVO;


@WebServlet("/ordermaster/ordermaster.do")
@MultipartConfig
public class OrderMasterServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("listOrderMasters_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的請求
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
				OrderMasterService ordermasterSvc = new OrderMasterService();
				List<OrderMasterVO> list  = ordermasterSvc.getAll(map);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("listOrderMasters_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/ordermaster/listOrderMasters_ByCompositeQuery.jsp"); // 成功轉交listOrderMasters_ByCompositeQuery.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ordermaster/select_page.jsp");
				failureView.forward(req, res);
			}
		}	
		
		if (action.equals("PAY")) { // 來自select_page.jsp的請求			
			/***************************1.接收請求參數**********************************/ 
			//採用Map<String,String[]> getParameterMap()的方法 
			//注意:an immutable java.util.Map 
			
			Integer memNo = new Integer(req.getParameter("memNo"));
			Integer ordAmt = new Integer(req.getParameter("ordAmt"));
			
			HttpSession session = req.getSession();
			@SuppressWarnings("unchecked")
			Vector<ProductVO> buylist = (Vector<ProductVO>)session.getAttribute("buylist");
			OrderMasterVO ordermasterVO = new OrderMasterVO();
			ordermasterVO.setMemNo(memNo);
			ordermasterVO.setOrdAmt(ordAmt);
			List<OrderDetailVO> list = new ArrayList<OrderDetailVO>();
			OrderDetailVO orderdetailVO = null;
			for(ProductVO productVO : buylist) {
				orderdetailVO = new OrderDetailVO();
				orderdetailVO.setProNo(productVO.getProNo());
				orderdetailVO.setOrdDetAmt(productVO.getQuantity());
				orderdetailVO.setOrdDetPrice(productVO.getProPrice()*productVO.getQuantity());
				list.add(orderdetailVO);
			}
			session.removeAttribute("shoppingcart");
			/***************************2.開始新增資料***************************************/
			OrderMasterService ordermasterSvc = new OrderMasterService();
			ordermasterVO = ordermasterSvc.addOrderMasterwithOrderDetails(memNo,ordAmt,list);
				
			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
			req.setAttribute("ordermasterVO", ordermasterVO);
			String url = "/front-end/ordermaster/listOneOrderMaster.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllBrand.jsp
			successView.forward(req, res);		
		}			
	}

}
