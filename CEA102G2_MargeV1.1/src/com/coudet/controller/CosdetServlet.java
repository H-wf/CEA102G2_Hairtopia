package com.coudet.controller;

import java.io.*;

import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import javax.servlet.http.Part;

import com.cos.model.CosVO;
import com.coudet.model.CosdetService;
import com.coudet.model.CosdetVO;
import com.member.model.MemService;
import com.member.model.MemVO;

@MultipartConfig

public class CosdetServlet extends HttpServlet {

		public void doGet(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {
			doPost(req, res);
		}

		public void doPost(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {

			req.setCharacterEncoding("UTF-8");
			String action = req.getParameter("action");
//			MemService memSvc = new MemService();
//			Integer memNo;
//			MemVO memVO = memSvc.getOneMem(memNo);
//			HttpSession session = req.getSession();
//			session.setAttribute("memVO", memVO);
			
			
			if ("getOne_For_Display".equals(action)) {

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					String str = req.getParameter("cosNo");
					if (str == null || (str.trim()).length() == 0) {
						errorMsgs.add("getOne_For_Display：cosNo無法轉成str");
					}
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cosdetail/select_cosdetail_page.jsp");
						failureView.forward(req, res);
						return;
					}
					
					Integer cosNo = null;
					try {
						cosNo = new Integer(str);
					} catch (Exception e) {
						errorMsgs.add("getOne_For_Display：str無法變成包裝型別cosNo");
					}
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cosdetail/select_cosdetail_page.jsp");
						failureView.forward(req, res);
						return;
					}
					
					CosdetService cosdetSvc = new CosdetService();
					List<CosdetVO> cosdetVO = cosdetSvc.getOneCosDet(cosNo);
					System.out.println("cosNo第71行"+cosNo);
					System.out.println("cosdetVO第72行"+cosdetVO);
					if (cosdetVO == null) {
						errorMsgs.add("getOne_For_Display：cosdetVO為null");
					}
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cosdetail/select_cosdetail_page.jsp");
						failureView.forward(req, res);
						return;
					}

					req.setAttribute("cosdetVO", cosdetVO);
					String url = "/back-end/Cosdetail/listOneCosdetail.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

				} catch (Exception e) {
					errorMsgs.add("getOne_For_Display：有errorMsgs發生" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cosdetail/select_cosdetail_page.jsp");
					failureView.forward(req, res);
				}
			}
			
			if ("getOne_For_Update".equals(action)){

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					Integer cosNo = new Integer(req.getParameter("cosNo"));
//					System.out.println(cosTypeNo);

					CosdetService cosdetSvc = new CosdetService();
					List<CosdetVO> cosdetVO = cosdetSvc.getOneCosDet(cosNo);

					req.setAttribute("cosdetVO", cosdetVO);
					String url = "/back-end/Cosdetail/update_cosdetail_input.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);
				} catch (Exception e) {
					errorMsgs.add("getOne_For_Update：有errorMsgs發生" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cosdetail/listAllCosdetail.jsp");
					failureView.forward(req, res);
				}
			}
			
			if ("update".equals(action)){
				
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
			
				try {
					Integer cosNo = new Integer(req.getParameter("cosNo").trim());
					
					Integer memNo = null;
					try {
						memNo = new Integer(req.getParameter("memNo").trim());
					} catch (NumberFormatException e) {
						memNo = 0;
						errorMsgs.add("update：memNo出現NumberFormatException");
					}
					
					Integer cosComment = null;
					try {
							cosComment = new Integer(req.getParameter("cosComment").trim());
					} catch (NumberFormatException e) {
						memNo = 0;
						errorMsgs.add("update：cosComment出現null");
					}			
					
					Integer cosDetailPrice = null;
					try {
						cosDetailPrice = new Integer(req.getParameter("cosDetailPrice").trim());
					} catch (NumberFormatException e) {
						cosDetailPrice = 0;
						errorMsgs.add("update：cosDetailPrice出現NumberFormatException");
					}					
					
					CosdetVO cosdetVO = new CosdetVO();
					cosdetVO.setCosNo(cosNo);
					cosdetVO.setMemNo(memNo);
					cosdetVO.setCosComment(cosComment);
					cosdetVO.setCosDetailPrice(cosDetailPrice);
					

					if (!errorMsgs.isEmpty()) {
						req.setAttribute("cosdetVO", cosdetVO);
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cosdetail/update_cosdetail_input.jsp");
						failureView.forward(req, res);
						return;
					}
					
					CosdetService cosdetSvc = new CosdetService();
					
					cosdetVO = cosdetSvc.updateCosDet(cosNo, cosComment, cosDetailPrice, memNo);
							
					req.setAttribute("cosdetVO", cosdetVO);
					String url = "/back-end/Cosdetail/listOneCosdetail.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

				} catch (Exception e) {
					errorMsgs.add("update：有errorMsgs發生"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cosdetail/update_cosdetail_input.jsp");
					failureView.forward(req, res);
				}
			}
			
	        if ("insert".equals(action)){ 
				
				List<String> errorMsgs = new LinkedList<String>();
				
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					Integer cosNo = null;
					try {
						cosNo = new Integer(req.getParameter("cosNo").trim());
					} catch (NumberFormatException e) {
						cosNo= 0;
						errorMsgs.add("insert：cosNo出現NumberFormatException");
					}
					
					Integer memNo = null;
					try {
						memNo = new Integer(req.getParameter("memNo").trim());
					} catch (NumberFormatException e) {
						memNo = 0;
						errorMsgs.add("insert：memNo出現NumberFormatException");
					}
					
					Integer cosComment = null;
					try {
							cosComment = new Integer(req.getParameter("cosComment").trim());
					} catch (NumberFormatException e) {
						memNo = 0;
						errorMsgs.add("insert：cosComment出現null");
					}			
					
					Integer cosDetailPrice = null;
					try {
						cosDetailPrice = new Integer(req.getParameter("cosDetailPrice").trim());
					} catch (NumberFormatException e) {
						cosDetailPrice = 0;
						errorMsgs.add("insert：cosDetailPrice出現NumberFormatException");
					}
					
					CosdetVO cosdetVO = new CosdetVO();
					cosdetVO.setCosNo(cosNo);
					cosdetVO.setMemNo(memNo);
					cosdetVO.setCosComment(cosComment);
					cosdetVO.setCosDetailPrice(cosDetailPrice);
					
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("cosdetVO", cosdetVO);
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/Cosdetail/addCosdetail.jsp");
						failureView.forward(req, res);
						return;
					}
					
					CosdetService cosdetSvc = new CosdetService();
					cosdetVO = cosdetSvc.insertCosDet(cosNo, memNo, cosComment, cosDetailPrice);
					String url = "/back-end/Cosdetail/listAllCosdetail.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);				
				
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cosdetail/addCosdetail.jsp");
					failureView.forward(req, res);
				}
			}
			
			if ("delete".equals(action)){

				List<String> errorMsgs = new LinkedList<String>();

				req.setAttribute("errorMsgs", errorMsgs);
		
				try {
					Integer cosNo = new Integer(req.getParameter("cosNo"));
					
					CosdetService cosdetSvc = new CosdetService();
					cosdetSvc.deleteCosDet(cosNo);
												
					String url = "/back-end/Cosdetail/listAllCosdetail.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

				} catch (Exception e) {
					errorMsgs.add("delete：有errorMsgs發生"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cosdetail/listAllCosdetail.jsp");
					failureView.forward(req, res);
				}
			}
		

		
		if ("findByMenNoToCos".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String str = req.getParameter("memNo");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("findByMenNoToCos：cosNo無法轉成str");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/Cos/LoginToRateCos.jsp");
					failureView.forward(req, res);
					return;
				}
				System.out.println("CosdetServlet no.293："+str);
				
				Integer memNo = null;
				try {
					memNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("getOne_For_Display：str無法變成包裝型別memNo");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/Cos/LoginToRateCos.jsp");
					failureView.forward(req, res);
					return;
				}
				
				System.out.println("CosdetServlet no.308："+memNo);
				
				CosdetService cosdetSvc = new CosdetService();
//				CosdetVO cosdetVO = cosdetSvc.findByMenNoToCos(memNo);
				List<CosdetVO> cosdetVO = cosdetSvc.getAllCosByMemNo(memNo);
//				HashSet<CosdetVO> cosdetVO = cosdetSvc.getAllCosByMemNo();
//				System.out.println("test1" + cosdetVO);
				if (cosdetVO == null) {
					errorMsgs.add("getOne_For_Display：cosdetVO為null");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/Cos/LoginToRateCos.jsp");
					failureView.forward(req, res);
					return;
				}

				req.setAttribute("cosdetVO", cosdetVO);
				String url = "/front-end/Cos/RateCos.jsp";//已經走到這一步
//				System.out.println("test2" + cosdetVO);
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("getOne_For_Display：有errorMsgs發生" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/Cos/LoginToRateCos.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOneCos_For_UpdateRate".equals(action)){

		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);
		
		try {
			Integer cosNo = new Integer(req.getParameter("cosNo"));
			System.out.println("CosdetServlet no.347" + cosNo);

			CosdetService cosdetSvc = new CosdetService();
			CosdetVO cosdetVO = cosdetSvc.findOneCosByCosNo(cosNo);
			System.out.println("CosdetServlet no.350" + cosdetVO);
			
//			CosdetService cosdetSvc1 = new CosdetService();
//			CosdetVO cosdetVO = cosdetSvc1.getAvgCosRateByCosNo(cosNo);

			req.setAttribute("cosdetVO", cosdetVO);
			String url = "/front-end/Cos/update_cosdetail_input_front.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		} catch (Exception e) {
			errorMsgs.add("getOneCos_For_UpdateRate：有errorMsgs發生" + e.getMessage());
			RequestDispatcher failureView = req
					.getRequestDispatcher("/front-end/Cos/RateCos.jsp");
			failureView.forward(req, res);
		}
	}
		
		if ("updateCosRate".equals(action)){
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
		    System.out.println("req.getParameter(\"cosNo\").trim() = "+req.getParameter("cosNo").trim());
			try {
				Integer cosNo = new Integer(req.getParameter("cosNo").trim());
				System.out.println("getOneCos_For_UpdateRate取cosNo" + cosNo);
				
				Integer memNo = null;
				try {
					memNo = new Integer(req.getParameter("memNo").trim());
				} catch (NumberFormatException e) {
					memNo = 0;
					errorMsgs.add("updateCosRate：memNo出現NumberFormatException");
				}
				System.out.println("getOneCos_For_UpdateRate取memNo" + memNo);
				
				Integer cosComment = null;
				try {
						cosComment = new Integer(req.getParameter("cosComment").trim());
				} catch (NumberFormatException e) {
					memNo = 0;
					errorMsgs.add("updateCosRate：cosComment出現null");
				}
				System.out.println("getOneCos_For_UpdateRate取cosComment" + cosComment);
				
				CosdetVO cosdetVO = new CosdetVO();
				cosdetVO.setCosNo(cosNo);
				cosdetVO.setMemNo(memNo);
				cosdetVO.setCosComment(cosComment);
				
				CosdetVO cosdetVO1 = new CosdetVO();
				CosVO cosVO1 = new CosVO();

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("cosdetVO", cosdetVO);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/Cos/RateCos.jsp");
					failureView.forward(req, res);
					return;
				}
				
				CosdetService cosdetSvc = new CosdetService();
				
				cosdetVO = cosdetSvc.updateCosDetWithComment(cosComment, memNo, cosNo);
				
				cosdetVO1 = cosdetSvc.getAvgCosCommentByCosNo(cosNo);
				Integer cosRate = (Integer)(cosdetVO1.getCosComment());
//				System.out.println("cosdetVO1.getCosComment()求出平均分數："+cosdetVO1.getCosComment());
//				System.out.println("cosRate"+cosRate);
				cosVO1.setCosRate(cosdetVO1.getCosComment());
				
				cosVO1.setCosNo(cosNo);
				
				CosdetService cosdetSvc1 = new CosdetService();
				cosVO1 = cosdetSvc1.updateCosRateForCosTable(cosRate, cosNo);
//				System.out.println(cosNo);
//				System.out.println(cosRate);
//				System.out.println("updateCosRateForCosTable：已做到419");
				
				req.setAttribute("cosVO", cosVO1);
				
				req.setAttribute("cosdetVO", cosdetVO);
				String url = "/front-end/Cos/passRateCos.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

			} catch (Exception e) {
				errorMsgs.add("updateCosRate：有errorMsgs發生"+e.getMessage());
				e.printStackTrace();
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/Cos/RateCos.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getMemsCos_For_Display".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String str = req.getParameter("memNo");
				System.out.println("CosdetServlet no.452："+str);
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("getMemsCos_For_Display：memNo無法轉成str");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cosdetail/select_cosdetail_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				Integer memNo = null;
				try {
					memNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("getMemsCos_For_Display：str無法變成包裝型別memNo");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cosdetail/select_cosdetail_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				CosdetService cosdetSvc = new CosdetService();
				List<CosdetVO> cosdetVO = cosdetSvc.getAllCosByMemNo(memNo);
				System.out.println("CosdetServlet no.477："+memNo);
				System.out.println("CosdetServlet no.478："+cosdetVO);
				if (cosdetVO == null) {
					errorMsgs.add("getMemsCos_For_Display為null");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Cosdetail/select_cosdetail_page.jsp");
					failureView.forward(req, res);
					return;
				}

				req.setAttribute("cosdetVO", cosdetVO);
				String url = "/back-end/Cosdetail/listOneCosdetail2.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				System.out.println("successView no.492："+ successView);
				successView.forward(req, res);

			} catch (Exception e) {
				errorMsgs.add("getMemsCos_For_Display：有errorMsgs發生" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/Cosdetail/select_cosdetail_page.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
