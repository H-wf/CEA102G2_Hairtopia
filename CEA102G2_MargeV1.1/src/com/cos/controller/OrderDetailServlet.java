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
import com.util.mail.MailService;
import com.cos.model.CosService;
import com.cos.model.CosVO;

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
		HashSet<CosdetVO> buylist = (HashSet<CosdetVO>) session.getAttribute("shoppingcart");
		
		if(buylist==null) {
			buylist = new HashSet<>();
		}
		
		if (action.equals("DELETE")||action.equals("ADD")) {
			String url = null;
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
//			//會員登入頁面後擷取帳戶(先關閉，因為還沒有加入過濾器)
//			Object account = session.getAttribute("account");
//			if (account == null) {
//				res.sendRedirect(req.getContextPath() + "/front-end/member/login.jsp");
//				return;
//			}
			// 刪除購物車中的訂單明細
			if (action.equals("DELETE")) {
				String del = req.getParameter("del");
				int d = Integer.parseInt(del);
				
				for( CosdetVO vo:buylist) {
					
					int cosNo = vo.getCosNo();
					if(cosNo==d) {
						buylist.remove(vo);
						break;
					}
					
				}
				url= "/front-end/Cos/Cart.jsp";
			}
			// 新增訂單明細至購物車中
			else if (action.equals("ADD")) {
				
				// 取得後來新增的訂單明細
				Integer cosNo = new Integer(req.getParameter("cosNo"));
//				System.out.println(cosNo);
				
				Integer cosDetailPrice = new Integer(req.getParameter("cosDetailPrice"));
//				System.out.println(cosDetailPrice);
				
				CosdetVO cosdetVO = new CosdetVO();
				cosdetVO.setCosNo(new Integer(cosNo));
				cosdetVO.setCosDetailPrice(new Integer(cosDetailPrice));
				buylist.add(cosdetVO);
				url = "/front-end/Cos/listAllCosApplyFromfront.jsp";
					
			}
			
			session.setAttribute("shoppingcart", buylist);
			
			RequestDispatcher rd = req.getRequestDispatcher(url);
			rd.forward(req, res);
			
		}

		// 結帳，計算購物車訂單明細價錢總數
		else if (action.equals("CHECKOUT")) {
			Integer total = 0;
			for (CosdetVO order:buylist) {
				Integer cosDetailPrice = order.getCosDetailPrice();
				total += (cosDetailPrice);
			}

			String ordAmt = String.valueOf(total);
			req.setAttribute("ordAmt", ordAmt);
			String url = "/front-end/Cos/Checkout.jsp";
			RequestDispatcher rd = req.getRequestDispatcher(url);
			rd.forward(req, res);
		}
		
		
		if (action.equals("SENDMAIL")) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			String account = req.getParameter("account");
			/*************************** 2.開始查詢資料 *****************************************/
			MemService memSvc = new MemService();
			MailService ms = new MailService();
			String memName = memSvc.validateEmail(account);
			
			CosService cosSvc = new CosService();
			// buylist -> cosdet 
			for(CosdetVO vo : buylist) {
				Integer cosNo = vo.getCosNo();
//				System.out.println(cosNo);
//				if(vo.getMemNo()==null) {
//				Integer memNo = 122248764;
//				}
//				Integer memNo = null;
//				System.out.println(memNo);
				Integer cosDetailPrice = vo.getCosDetailPrice();
				
				//insert into cosdet table
				CosdetVO cosdetVO = new CosdetVO();
				cosdetVO.setCosNo(cosNo);
				cosdetVO.setMemNo(1000);//因為memNo還沒抓到，因此先用1000代替
				cosdetVO.setCosDetailPrice(cosDetailPrice);
				
				CosdetService cosdetSvc = new CosdetService();
				cosdetVO = cosdetSvc.insertCosDetNoComment(cosNo, 1000, cosDetailPrice);
//				System.out.println("成功送入cosdet");
//				String url = "/back-end/Cosdetail/listAllCosdetail.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);
//				successView.forward(req, res);
				
				//get cos cosCount=?
				CosVO cosVO = new CosVO();
				cosVO.setCosNo(cosNo);
				CosService cosSvc1 = new CosService();
				CosVO cosVO1 = cosSvc1.FindCountApplyNo(cosNo);
				Integer cosCount = cosVO1.getCosCount();
				cosVO.setCosCount(cosCount);
				
				CosService cosSvc2 = new CosService();
				cosVO = cosSvc2.AddCountApplyNo(cosNo, cosCount);
				System.out.println("成功送入cos人數");
			}
			
			String url = "/front-end/Cos/listOneCosfront.jsp";
			
			if (memName != null) {
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
//				errorMsgs.add("信箱存在");

				String subject = "課程通知";
				String password = genAuthCode();
				String messageText = "感謝您報名課程"
						+ "您的課程為\r\n" + "  \r\n"
						//+ "------------------------\r\n" + "cosNo: " + cosNo + "\r\n"
						+ "\r\n" + "可至課程查詢確認時間\r\n" + "  \r\n";
//						+ "Please click this link to activate your account:\r\n"
//						+ "http://www.yourwebsite.com/verify.php?email='.$email.'&hash='.$hash.";
//				ms.sendMail(account, subject, messageText);

				/* test用 請改成自己的信箱 */
				ms.sendMail("herdsofreindeer@gmail.com", subject, messageText);

				/* change password by random generate password */
				memSvc.updatePassword(account, password);
				/* Send the Success view */
				RequestDispatcher SuccessView = req.getRequestDispatcher("/front-end/Cos/pass.jsp");
				SuccessView.forward(req, res);
			} else {
				errorMsgs.add("信箱不存在");
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Cos/passnowork.jsp");
				failureView.forward(req, res);
				
			}
		}
		
		
		
	}

	private String genAuthCode() {
		char[] authCode = new char[8];
		byte[] randNum = new byte[8];
		// random 8 numbers to choice character
		for (int i = 0; i < randNum.length; i++) {
			randNum[i] = (byte) (Math.random() * 62);
			// System.out.print(randNum[i] + " ");
		}
//		System.out.println();
		// set a inner list 0-9 ->(char)0-9, 10-35 ->(char)A-Z, 36-61 -> (char)a-z
		// purpose：Save memory
		for (int i = 0; i < 8; i++) {
			if (randNum[i] >= 0 && randNum[i] <= 9) {
				authCode[i] = (char) (randNum[i] + 48);
			} else if (randNum[i] >= 10 && randNum[i] <= 35) {
				authCode[i] = (char) (randNum[i] + 55);
			} else if (randNum[i] >= 36 && randNum[i] <= 61) {
				authCode[i] = (char) (randNum[i] + 61);
			}
		}

		return new String(authCode);
	}

}
