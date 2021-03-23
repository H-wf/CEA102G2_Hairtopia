package com.ordermaster.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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

import org.json.JSONArray;
import org.json.JSONObject;

import com.brand.model.BrandService;
import com.brand.model.BrandVO;
import com.orderdetail.model.OrderDetailVO;
import com.ordermaster.model.OrderMasterDAO;
import com.ordermaster.model.OrderMasterService;
import com.ordermaster.model.OrderMasterVO;
import com.product.model.ProductVO;


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
				/***************************2.開始複合查詢***************************************/
				OrderMasterService ordermasterSvc = new OrderMasterService();
				List<OrderMasterVO> list  = ordermasterSvc.getAll(map);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("list", list); // 資料庫取出的list物件,存入request
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/ordermaster/listAllOrderMaster.jsp"); // 成功轉交listOrderMasters_ByCompositeQuery.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ordermaster/listAllOrderMaster.jsp");
				failureView.forward(req, res);
			}
		}	
		
		if (action.equals("PAY")) { // 來自select_page.jsp的請求			
			/***************************1.接收請求參數**********************************/ 
			//採用Map<String,String[]> getParameterMap()的方法 
			//注意:an immutable java.util.Map 
			
			Integer memNo = new Integer(req.getParameter("memNo"));
			Integer ordAmt = new Integer(req.getParameter("ordAmt"));
			String ordName = req.getParameter("ordName");
			String ordEmail = req.getParameter("ordEmail");
			String ordPhone = req.getParameter("ordPhone");
			String ordAddr = req.getParameter("ordAddr");
			
			HttpSession session = req.getSession();
			@SuppressWarnings("unchecked")
			Vector<ProductVO> shoppingcart = (Vector<ProductVO>)session.getAttribute("shoppingcart");
			OrderMasterVO ordermasterVO = new OrderMasterVO();
			ordermasterVO.setMemNo(memNo);
			ordermasterVO.setOrdAmt(ordAmt);
			ordermasterVO.setOrdName(ordName);
			ordermasterVO.setOrdEmail(ordEmail);
			ordermasterVO.setOrdPhone(ordPhone);
			ordermasterVO.setOrdAddr(ordAddr);
			List<OrderDetailVO> list = new ArrayList<OrderDetailVO>();
			OrderDetailVO orderdetailVO = null;System.out.println(shoppingcart.size());
			for(ProductVO productVO : shoppingcart) {
				orderdetailVO = new OrderDetailVO();
				orderdetailVO.setProNo(productVO.getProNo());
				orderdetailVO.setOrdDetAmt(productVO.getQuantity());
				orderdetailVO.setOrdDetPrice(productVO.getProPrice()*productVO.getQuantity());
				list.add(orderdetailVO);
			}
			session.removeAttribute("shoppingcart");
			session.removeAttribute("ordAmt");
			session.removeAttribute("sum");
			/***************************2.開始新增資料***************************************/
			OrderMasterService ordermasterSvc = new OrderMasterService();
			ordermasterVO = ordermasterSvc.addOrderMasterwithOrderDetails(memNo,ordAmt,ordName,ordEmail,ordPhone,ordAddr,list);
				
			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
			req.setAttribute("ordermasterVO", ordermasterVO);
			String url = "/front-end/ordermaster/listOneOrderMaster2.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllBrand.jsp
			successView.forward(req, res);		
		}
		
		if ("cancel".equals(action)) {
//			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				
				Integer ordNo = new Integer(req.getParameter("ordNo").trim());
				System.out.println("ordNo="+ordNo);
				Integer memNo = new Integer(req.getParameter("memNo").trim());
				System.out.println("memNo="+memNo);
				Integer ordStatus = new Integer(req.getParameter("ordStatus").trim());
				System.out.println("ordStatus="+ordStatus);
				Integer ordAmt = new Integer(req.getParameter("ordAmt").trim());
				System.out.println("ordAmt="+ordAmt);
				String index = req.getParameter("index").trim();
				OrderMasterVO ordmVO = new OrderMasterVO();								
				
				ordmVO.setOrdNo(ordNo);
				ordmVO.setMemNo(memNo);
				ordmVO.setOrdStatus(ordStatus);
				ordmVO.setOrdAmt(ordAmt);
								
				/*************************** 2.開始修改資料 *****************************************/
				OrderMasterService ordmSvc = new OrderMasterService();
				ordmSvc.updateOrderMaster(ordNo,memNo,ordStatus,ordAmt);
				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				PrintWriter out = res.getWriter();
				out.print(index);
				out.flush();
				out.close();
				return;
				

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
		


				/*************************** 其他可能的錯誤處理 *************************************/
//			} catch (Exception e) {
//				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/ordermaster/listAllOrderMaster.jsp");
//				failureView.forward(req, res);
//			}
		}
	}

}
