package com.coudet.controller;

import java.io.*;

import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.cos.model.CosService;
import com.cos.model.CosVO;
import com.coudet.model.CosdetService;
import com.coudet.model.CosdetVO;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
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
				System.out.println("CosdetServlet no.300："+str);
				
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
				
				System.out.println("CosdetServlet no.315："+memNo);
				
				CosdetService cosdetSvc = new CosdetService();
				List<CosdetVO> cosdetVO = cosdetSvc.getAllCosByMemNo(memNo);
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
		
		if ("ShowQRCodeByCosNoAndMemNo".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				Integer cosNo = null;
				try {
					cosNo = new Integer(req.getParameter("cosNo"));
				} catch (Exception e) {
					errorMsgs.add("ShowQRCodeByCosNoAndMemNo：str無法變成包裝型別cosNo");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/Cos/RateCos.jsp");
					failureView.forward(req, res);
					return;
				}
				System.out.println("CosdetServlet no.358："+cosNo);
				
				Integer memNo = null;
				try {
					memNo = new Integer(req.getParameter("memNo"));
				} catch (Exception e) {
					errorMsgs.add("ShowQRCodeByCosNoAndMemNo：str無法變成包裝型別memNo");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/Cos/RateCos.jsp");
					failureView.forward(req, res);
					return;
				}
				
				System.out.println("CosdetServlet no.373："+memNo);
				
				CosdetService cosdetSvc = new CosdetService();
				CosdetVO cosdetVO = cosdetSvc.findQRCodeByCosNoAndCosNo(cosNo, memNo);
				if (cosdetVO == null) {
					errorMsgs.add("getOne_For_Display：cosdetVO為null");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/Cos/LoginToRateCos.jsp");
					failureView.forward(req, res);
					return;
				}
				
				System.out.println("cosdetVO no.387：" + cosdetVO);
				
				res.setContentType("image/jpeg");
				ServletOutputStream out = res.getOutputStream();
				
				System.out.println("========== cosdetServlet no.399：");
				
//				req.setCharacterEncoding("UTF-8");
//				String action = req.getParameter("action");
//				
//				Integer cosNo = new Integer(req.getParameter("cosNo"));
//				System.out.println(cosNo);
				
				String url1 = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath() + "/" + req.getServletPath() + "/" + "listOneCosdetail.jsp?cosNo=";
//				String s1 =  "http://localhost:8081/CEA102G2_Merge/coudet/coudet.do?cosNo=";
				String s2 = String.valueOf(cosNo);
				String s3 = "&action=getOne_For_Display";
				String url = url1 + s2 + s3 ;
				int width = 200;
				int height = 200;
				String format = "jpg";
				// 設定編碼格式與容錯率
				Hashtable<EncodeHintType, Object> hints = new Hashtable<>();
				hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
				hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
				// 開始產生QRCode
				BitMatrix matrix = null;
				try {
					matrix = new MultiFormatWriter().encode(url, BarcodeFormat.QR_CODE, width, height, hints);
				} catch (WriterException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				MatrixToImageWriter.writeToStream(matrix, format, out);
				System.out.println(matrix);
				System.out.println(format);
				System.out.println(out);

				req.setAttribute("cosdetVO", cosdetVO);
				String url2 = "/front-end/Cos/QRCodegenerate.jsp";//產生QRcode
				RequestDispatcher successView = req.getRequestDispatcher(url2);
				successView.forward(req, res);

			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("ShowQRCodeByCosNoAndMemNo：有errorMsgs發生" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/Cos/RateCos.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOneCos_For_UpdateRate".equals(action)){

		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);
		
		try {
			Integer cosNo = new Integer(req.getParameter("cosNo"));
			System.out.println("CosdetServlet no.449：" + cosNo);
			
			Integer memNo = new Integer(req.getParameter("memNo"));
			System.out.println("CosdetServlet no.452：" + memNo);

			CosdetService cosdetSvc = new CosdetService();
			CosdetVO cosdetVO = cosdetSvc.findQRCodeByCosNoAndCosNo(cosNo, memNo);//這邊雖然是QRCode...但其實是從一個cosNo跟memNo找到一組資料
			System.out.println("CosdetServlet no.356：" + cosdetVO);

			req.setAttribute("cosdetVO", cosdetVO);
			boolean openCosModal=true;
			req.setAttribute("openCosModal",openCosModal );
			String url = "/front-end/member/memberPage.jsp";
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
				System.out.println("getOneCos_For_UpdateRate取cosNo no.477：" + cosNo);
				
				Integer memNo = null;
				try {
					memNo = new Integer(req.getParameter("memNo").trim());
				} catch (NumberFormatException e) {
					memNo = 0;
					errorMsgs.add("updateCosRate：memNo出現NumberFormatException");
				}
				System.out.println("getOneCos_For_UpdateRate取memNo no.486：" + memNo);
				
				Integer cosComment = null;
				try {
						cosComment = new Integer(req.getParameter("cosComment").trim());
				} catch (NumberFormatException e) {
					memNo = 0;
					errorMsgs.add("updateCosRate：cosComment出現null");
				}
				System.out.println("getOneCos_For_UpdateRate取cosComment no.495：" + cosComment);
				
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
				System.out.println("cosdetVO1.getCosComment()求出平均分數："+cosdetVO1.getCosComment());
				System.out.println("cosRate"+cosRate);
				cosVO1.setCosRate(cosdetVO1.getCosComment());
				
				cosVO1.setCosNo(cosNo);
				
				CosdetService cosdetSvc1 = new CosdetService();
				cosVO1 = cosdetSvc1.updateCosRateForCosTable(cosRate, cosNo);
				System.out.println(cosNo);
				System.out.println(cosRate);
				System.out.println("updateCosRateForCosTable：已做到419");
				
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
