package com.cos.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashSet;
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

import com.coudet.model.CosdetDAO;
import com.coudet.model.CosdetService;
import com.coudet.model.CosdetVO;
import com.member.controller.MemServlet;
import com.member.model.MemService;
import com.member.model.MemVO;
import com.util.mail.MailService;
import com.cos.model.CosService;
import com.cos.model.CosVO;

@MultipartConfig
public class OrderServlet2 extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		HttpSession session = req.getSession();

		@SuppressWarnings("unchecked")
		List<CosdetVO> buylist = (Vector<CosdetVO>) session.getAttribute("shoppingcart");

		if (buylist == null) {
			buylist = new Vector<CosdetVO>();
		}

		if (action.equals("DELETE") || action.equals("ADD")) {
			System.out.println("orderServlet no.51：已經做到");
			String url = null;
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			// 刪除購物車中的訂單明細
			if (action.equals("DELETE")) {
				String del = req.getParameter("del");
				int d = Integer.parseInt(del);
				buylist.remove(d);
				if (buylist.size() > 0) {
					url = "/front-end/Cos/Cart.jsp";
				} else {
					url = "/front-end/Cos/listAllCosApplyFromfront.jsp";

				}
				session.setAttribute("shoppingcart", buylist);

				RequestDispatcher rd = req.getRequestDispatcher(url);
				rd.forward(req, res);

			}
			// 新增訂單明細至購物車中
			else if (action.equals("ADD")) {

				CosdetService cosdetSvc = new CosdetService();
				MemVO memVO = (MemVO) session.getAttribute("userSession");
				Integer memNo = memVO.getMemNo();
				System.out.println("orderServlet no. 91 ：" + memNo);
				
				

				// 取得後來新增的訂單明細
				Integer cosNo = new Integer(req.getParameter("cosNo"));
				System.out.println("orderServlet no. 88：" + cosNo);

				Integer cosDetailPrice = new Integer(req.getParameter("cosDetailPrice"));
				System.out.println("orderServlet no. 94：" + cosDetailPrice);

				CosdetVO deleteCosIfDouble = cosdetSvc.findQRCodeByCosNoAndCosNo(cosNo, memNo);
				if (deleteCosIfDouble == null) {

					CosdetVO cosdetVO = new CosdetVO();
					cosdetVO.setCosNo(new Integer(cosNo));
					cosdetVO.setMemNo(new Integer(memNo));
					cosdetVO.setCosDetailPrice(new Integer(cosDetailPrice));
//					if (buylist == null) {
//						buylist = new Vector<CosdetVO>();
//					}
					buylist.add(cosdetVO);
					
					

					url = "/front-end/Cos/Cart.jsp";
					
					session.setAttribute("shoppingcart", buylist);
					RequestDispatcher rd = req.getRequestDispatcher(url);
					rd.forward(req, res);
				}
				if (deleteCosIfDouble != null) {
					req.setAttribute("wilsonli","重覆報名" );
					url = "/front-end/Cos/listAllCosApplyFromfront.jsp";
					RequestDispatcher rd = req.getRequestDispatcher(url);
					rd.forward(req, res);
				}
//				//去購物車找出同樣報名的產品
//				for(int i=0; )

			}
		}

		// 結帳，計算購物車訂單明細價錢總數
		else if (action.equals("CHECKOUT")) {
			Integer total = 0;
			for (CosdetVO order : buylist) {
				Integer cosDetailPrice = order.getCosDetailPrice();
				Integer cosNo = order.getCosNo();
				System.out.println("orderServlet no.142：" + cosNo);
				total += (cosDetailPrice);
			}

			String ordAmt = String.valueOf(total);
			req.setAttribute("ordAmt", ordAmt);
//			sessionUser = session.getAttribute("sessionUser");
			Integer memNo = null;
//			req.setAttribute(sessionUser, memNo);
			System.out.println("orderServlet no.149：" + memNo);
			String url = "/front-end/Cos/Checkout.jsp";
			RequestDispatcher rd = req.getRequestDispatcher(url);
			rd.forward(req, res);
		}

		if (action.equals("SENDCOSDETAIL")) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
//			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			String account = req.getParameter("account");
//			/*************************** 2.開始查詢資料 *****************************************/
			MemService memSvc = new MemService();
			MailService ms = new MailService();
//			MemVO memVO = memSvc.validateEmail(account);

			// buylist -> cosdet
			for (CosdetVO vo : buylist) {

				Integer cosNo = vo.getCosNo();
				System.out.println("orderServlet no.153：" + cosNo);

				Integer memNo = vo.getMemNo();
				System.out.println("orderServlet no.156：" + memNo);

//				if(vo.getMemNo()==null) {
//					Integer memNo = 1000;
//					}
//					String memNo = null;
//					System.out.println("orderServlet no.158："+ memNo);
				Integer cosDetailPrice = vo.getCosDetailPrice();
				System.out.println("orderServlet no.164：" + cosDetailPrice);

				// insert into cosdet table
				CosdetVO cosdetVO = new CosdetVO();
				cosdetVO.setCosNo(cosNo);
				cosdetVO.setMemNo(memNo);
				System.out.println("orderServlet no.187：" + memNo);
				cosdetVO.setCosDetailPrice(cosDetailPrice);

				CosdetService cosdetSvc = new CosdetService();
				cosdetVO = cosdetSvc.insertCosDetNoComment(cosNo, memNo, cosDetailPrice);
				System.out.println("orderServlet no.193：成功送入cosdet");

				// get cos cosCount=?
				CosVO cosVO = new CosVO();
				cosVO.setCosNo(cosNo);
				CosService cosSvc1 = new CosService();
				CosVO cosVO1 = cosSvc1.FindCountApplyNo(cosNo);
				Integer cosCount = cosVO1.getCosCount();
				cosVO.setCosCount(cosCount);

				CosService cosSvc2 = new CosService();
				cosVO = cosSvc2.AddCountApplyNo(cosNo, cosCount);
				System.out.println("OrderServlet no.167：成功送入cos人數");
			}

//			session.setAttribute("ordAmt", ordAmt);

			RequestDispatcher SuccessView = req.getRequestDispatcher("/front-end/Cos/pass.jsp");
			SuccessView.forward(req, res);
			System.out.println("OrderServlet no.174：" + errorMsgs);
		}

	}
}
