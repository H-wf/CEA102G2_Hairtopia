package com.member.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.designer.model.DesignerService;
import com.designer.model.DesignerVO;
import com.member.model.*;
import com.util.mail.*;
import com.util.imageHandle.*;
import com.websocketchat.jedis.JedisHandleMessage;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class MemServlet extends HttpServlet {
	
	

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		/*信箱設定，給驗證信的寄送*/
		String  EmailForSend = "b35698741@gmail.com";
		
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");

		
		
		if("test".equals(action)) {
			String memEmail = req.getParameter("memEmail");
			MemService memSvc = new MemService();
			String confirm = memSvc.validateEmail(memEmail);
			if(confirm != null) {
				out.println("false");
			}else {
				out.println("true");
			}
			
			/* 圖片處理段落 */
			byte[] memPic = null;
			Part part = req.getPart("memPic");
			InputStream in = part.getInputStream();
			if (in.available() > 0) {
				memPic = new byte[in.available()];
				in.read(memPic);
				in.close();
				System.out.println("buffer length_o: " + memPic.length);
				/*對圖檔進行縮圖*/
				memPic = ImageUtil.shrink(memPic, 100);
				System.out.println("buffer length_s: " + memPic.length);
			}
		}
		
		/* Login */
		if ("login".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			// 【取得使用者 帳號(account) 密碼(password)】
			String memEmail = req.getParameter("memEmail");
			String password = req.getParameter("password");

			/*************************** 2.開始查詢資料 *****************************************/
			// 【檢查使用者輸入的帳號(account) 密碼(password)是否有效】
			// 【實際上應至資料庫搜尋比對】
			MemService memSvc = new MemService();
			MemVO memVO = memSvc.validate(memEmail, password);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			if (memVO == null) { // 【帳號 , 密碼無效時】
//		        out.println("<HTML><HEAD><TITLE>Access Denied</TITLE></HEAD>");
//		        out.println("<BODY>你的帳號 , 密碼無效!<BR>");
//		        out.println("請按此重新登入 <A HREF="+req.getContextPath()+"/mem/login.jsp>重新登入</A>");
//		        out.println("</BODY></HTML>");
				errorMsgs.add("帳號或密碼錯誤");
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/member/login.jsp");
				failureView.forward(req, res);
			} else if(memVO.getMemStatus() == 0){
				
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/member/unverified.jsp");
				failureView.forward(req, res);
				
			}else{
				HttpSession session = req.getSession();
				//設計師session
				DesignerService designerSvc = new DesignerService();
				DesignerVO desSession = designerSvc.getOneDesByMemNo(memVO.getMemNo());
				if(desSession!=null) {
					session.setAttribute("desSession", desSession);
				}
				session.setAttribute("account", memEmail);
				session.setAttribute("userSession", memVO);
				try {
					String location = (String) session.getAttribute("location");
					if (location != null) {
						session.removeAttribute("location"); // *工作2: 看看有無來源網頁 (-->如有來源網頁:則重導至來源網頁)
						res.sendRedirect(location);
						return;
					}
				} catch (Exception ignored) {
				}

				res.sendRedirect(req.getContextPath() + "/front-end/index.jsp");
			}
		}
		/* forget password */
		if ("forgetPassword".equals(action)) {

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
			if (memName != null) {
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
//				errorMsgs.add("信箱存在");

				String subject = "密碼通知";
				String password = genAuthCode(10);
				String messageText = "親愛的 "+ memName + " 您好\r\n\n"
						+ "以下是您重設的資料，請勿遺失 .\r\n"
						+ "------------------------\r\n" 
						+ "密碼: " + password
						+ "\r\n" + "------------------------\r\n"
						+ "HairTopia 感謝您的支持";

				/* test用 請改成自己的信箱 */
				ms.sendMail(EmailForSend, subject, messageText);

				/* change password by random generate password */
				memSvc.updatePassword(account, password);
				/* Send the Success view */
				RequestDispatcher SuccessView = req.getRequestDispatcher("/front-end/member/email_send_success.jsp");
				SuccessView.forward(req, res);
				return;
			} else {
				errorMsgs.add("信箱不存在");
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/member/forgetPassword.jsp");
				failureView.forward(req, res);
				return;
			}
		}
		/* sign up */
		if ("signUp".equals(action)) {
			
			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String memName = req.getParameter("memName");
				
				if (memName == null || memName.trim().length() == 0) {
					errorMsgs.put("memName", "請勿空白");
				}else if(memName.trim().length() > 30) {
					errorMsgs.put("memName", "長度過長");
				}

				String memEmail = req.getParameter("memEmail").trim();
				if (memEmail == null || memEmail.trim().length() == 0) {
					errorMsgs.put("memEmail", "信箱請勿空白");
				}else {
					MemService memSvc = new MemService();
					String emailExist =  memSvc.validateEmail(memEmail);
					if(emailExist != null) {
						errorMsgs.put("emailExist", "信箱已註冊");
					}
				}

				String memPswd = req.getParameter("memPswd").trim();
				if (memPswd == null || memPswd.trim().length() == 0) {
					errorMsgs.put("memPswd", "密碼請勿空白");
				}
				
				
				
				/* 將已填入內容包成VO */
				MemVO memVO = new MemVO();
				memVO.setMemName(memName);
				memVO.setMemEmail(memEmail);
				memVO.setMemPswd(memPswd);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memVO", memVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/member/signUp.jsp");
					failureView.forward(req, res);
					return;
				}	
				// memName, memGender, memInform ,memEmail, memPswd, memPhone, memAddr, memPic
				/*************************** 2.開始新增資料 ***************************************/
				MemService newsSvc = new MemService();
				MailService ms = new MailService();
				
				String subject = "註冊認證通知信";
				String VerificationCode = genAuthCode(20);
				String messageText = "感謝您在 HairTopia 申請帳號!\r\n\n"
						+ "以下是您註冊的資料，請勿遺失。\r\n\n"
						+ "您的帳號: " + memEmail + " .\r\n\n"
						+ "啟動連結 (點完以下連結才會完成註冊程序):\r\n"
						+  "http://localhost:8081/CEA102G2_Merge/member/mem.do?action=verify&memEmail="+memEmail+"&verificationCode=" + VerificationCode +"\r\n\n"
						+ "若連結無法點選，請複製上方連結，貼入到瀏覽器中使用。\r\n\n"
						+ "HairTopia 感謝您的支持";

				/* test用 請改成自己的信箱 */
				ms.sendMail(EmailForSend, subject, messageText);
				/*存進Redis 設定時間30分鐘過期*/
				JedisHandleMessage.saveAuthenticationCode(memEmail, VerificationCode);
				
				memVO = newsSvc.signUp(memName, memEmail, memPswd);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/member/unverified.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/member/signUp.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("SendAuthCode".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String memEmail = req.getParameter("memEmail").trim();
				
				/*************************** 2.開始新增資料 ***************************************/
				MemService memSvc = new MemService();
				MailService ms = new MailService();
				String memName = memSvc.validateEmail(memEmail);
				
				String subject = "註冊認證通知信";
				String VerificationCode = genAuthCode(20);
				String messageText = "感謝您在 HairTopia 申請帳號!\r\n\n"
						+ "以下是您註冊的資料，請勿遺失。\r\n\n"
						+ "您的帳號: " + memEmail + " .\r\n\n"
						+ "啟動連結 (點完以下連結才會完成註冊程序):\r\n"
						+  "http://localhost:8081/CEA102G2_Merge/member/mem.do?action=verify&memEmail="+memEmail+"&verificationCode=" + VerificationCode +"\r\n\n"
						+ "若連結無法點選，請複製上方連結，貼入到瀏覽器中使用。\r\n\n"
						+ "HairTopia 感謝您的支持";

				/* test用 請改成自己的信箱 */
				ms.sendMail(EmailForSend, subject, messageText);
				/*存進Redis 設定時間30分鐘過期*/
				JedisHandleMessage.saveAuthenticationCode(memEmail, VerificationCode);
				
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("memEmail", memEmail);
				String url = "/front-end/member/resendregistermail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
				
			} catch (Exception e) {
				errorMsgs.add("Exception" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/index.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("verify".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
			String memEmail = req.getParameter("memEmail").trim();
			
			String verificationCode = req.getParameter("verificationCode").trim();
			
			String confirm = JedisHandleMessage.verifyAuthenticationCode(memEmail);
			if(confirm != null ) {
				if(confirm.equals(verificationCode)) {
					MemService memSvc = new MemService();
					memSvc.updateStatus(memEmail, 1);
				}else {
					errorMsgs.add("驗證碼錯誤!");
				}
			}else {
				errorMsgs.add("驗證碼已過期!");
			}
			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
			String url = "/front-end/member/verify.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
			successView.forward(req, res);
		}
		
		if ("updateSetting".equals(action)) { // 來自update_emp_input.jsp的請求

			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或
																// 【/dept/listEmps_ByDeptno.jsp】 或 【
																// /dept/listAllDept.jsp】

//			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer memNo = new Integer(req.getParameter("memNo"));
				MemService memSvc = new MemService();
				MemVO memVO= memSvc.getOneMem(memNo);
				
				String memName = req.getParameter("memName");
				
				if (memName == null || memName.trim().length() == 0) {
					errorMsgs.put("memName","顯示名稱請勿空白");
				}
				
				String memGender = req.getParameter("memGender");
				Integer sex = 0;
				if (!"null".equals(memGender)) {
					sex = ("male".equals(memGender)) ? 1 : ("female".equals(memGender)) ? 2 : 0;

				}

				String memEmail = req.getParameter("memEmail");
				if (memEmail == null || memEmail.trim().length() == 0) {
					errorMsgs.put("memEmail", "信箱請勿空白");
				}

				
				String memPswd = req.getParameter("memPswd");
				String newMemPswd = req.getParameter("newMemPswd");
				if (memPswd == null || memPswd.trim().length() == 0) {
					if(newMemPswd == null || newMemPswd.trim().length() == 0) {
						memPswd = memVO.getMemPswd();
					}else {
						errorMsgs.put("memPswd", "請輸入現在密碼");
					}
				}else {
					if(newMemPswd == null || newMemPswd.trim().length() == 0) {
						errorMsgs.put("newMemPswd", "請輸入新密碼");
					}else {
						if(!memVO.getMemPswd().equals(memPswd) ) {
							errorMsgs.put("memPswd", "密碼錯誤");
						}else {
							memPswd = newMemPswd;
						}
					}
				}

				String memInform = req.getParameter("memInform");

				String memPhone = req.getParameter("memPhone");

				String memAddr = req.getParameter("memAddr");

				/* 圖片處理段落 */
				byte[] memPic = null;
				Part part = req.getPart("memPic");
				InputStream in = part.getInputStream();
				if (in.available() > 0) {
					memPic = new byte[in.available()];
					in.read(memPic);
					in.close();
					System.out.println("buffer length: " + memPic.length);
					/*對圖檔進行縮圖*/
					memPic = ImageUtil.shrink(memPic, 100);
					System.out.println("buffer length: " + memPic.length);
				}
				
				
//				/* 將已填入內容包成VO */
//				MemVO memVO = new MemVO();
//				memVO.setMemNo(memNo);
//				memVO.setMemName(memName);
//				memVO.setMemGender(sex);
//				memVO.setMemEmail(memEmail);
//				memVO.setMemInform(memInform);
//				memVO.setMemPhone(memPhone);
//				memVO.setMemAddr(memAddr);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("memVO", memVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/member/memberSetting.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				

				/*************************** 2.開始修改資料 *****************************************/
				
				memVO = memSvc.updateMember(memNo, memName, sex, memInform, memEmail, memPswd, memPhone, memAddr, memPic);
				HttpSession session = req.getSession();
				session.setAttribute("userSession", memVO);
				
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
//			} catch (Exception e) {
//				errorMsgs.put("Exception","修改資料失敗:" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/member/memberSetting.jsp");
//				failureView.forward(req, res);
//			}
		}
		


		/* 固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容 */
		/* 固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容 */
		/* 固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容 */
		/* 固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容 */
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("memNo");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入會員編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/member/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer memNo = null;
				try {
					memNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("會員編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/member/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				MemService memSvc = new MemService();
				MemVO memVO = memSvc.getOneMem(memNo);
				if (memVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/member/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("memVO", memVO); // 資料庫取出的empVO物件,存入req
				String url = "/front-end/member/listOneMember.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/member/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp 或 /dept/listEmps_ByDeptno.jsp 的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或
																// 【/dept/listEmps_ByDeptno.jsp】 或 【
																// /dept/listAllDept.jsp】
			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer memNo = new Integer(req.getParameter("memNo"));
				
				/*************************** 2.開始查詢資料 ****************************************/
				MemService newsSvc = new MemService();
				MemVO memVO = newsSvc.getOneMem(memNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("memVO", memVO); // 資料庫取出的empVO物件,存入req

				String url = "/front-end/member/update_member_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料取出時失敗:" + e.getMessage());
				System.out.println(requestURL);
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或
																// 【/dept/listEmps_ByDeptno.jsp】 或 【
																// /dept/listAllDept.jsp】

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer memNo = new Integer(req.getParameter("memNo").trim());
				String memName = req.getParameter("memName");
//			String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (memName == null || memName.trim().length() == 0) {
					errorMsgs.add("顯示名稱: 請勿空白");
				}
//			else if(!newsTitle.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
//				errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
//            }
				String gender = req.getParameter("gender");
				Integer sex = 0;
				if (gender == "null") {
					errorMsgs.add("性別 : 請勿空白");
				} else {
					sex = (gender == "male") ? 1 : (gender == "female") ? 2 : 0;
				}

				String memEmail = req.getParameter("memEmail").trim();
				if (memEmail == null || memEmail.trim().length() == 0) {
					errorMsgs.add("信箱請勿空白");
				}

				String memPswd = req.getParameter("memPswd").trim();
				if (memPswd == null || memPswd.trim().length() == 0) {
					errorMsgs.add("密碼請勿空白");
				}

				String memInform = req.getParameter("memInform").trim();

				String memPhone = req.getParameter("memPhone").trim();

				String memAddr = req.getParameter("memAddr").trim();

				/* 圖片處理段落 */
				byte[] memPic = null;
				Part part = req.getPart("memPic");
				InputStream in = part.getInputStream();
				if (in.available() > 0) {
					memPic = new byte[in.available()];
					in.read(memPic);
					in.close();
					System.out.println("buffer length: " + memPic.length);
					/*對圖檔進行縮圖*/
					memPic = ImageUtil.shrink(memPic, 100);
					System.out.println("buffer length: " + memPic.length);
				}
				
				
				/* 將已填入內容包成VO */
				MemVO memVO = new MemVO();
				memVO.setMemNo(memNo);
				memVO.setMemName(memName);
				memVO.setMemGender(sex);
				memVO.setMemEmail(memEmail);
				memVO.setMemPswd(memPswd);
				memVO.setMemInform(memInform);
				memVO.setMemPhone(memPhone);
				memVO.setMemAddr(memAddr);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memVO", memVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/member/update_member_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				MemService newsSvc = new MemService();
				memVO = newsSvc.updateMember(memNo, memName, sex, memInform, memEmail, memPswd, memPhone, memAddr, memPic);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
//			MemService deptSvc = new MemService();
//			if(requestURL.equals("/member/listEmps_ByDeptno.jsp") || requestURL.equals("/member/listAllDept.jsp"))
//				req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(deptno)); // 資料庫取出的list物件,存入request

				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/member/update_member_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // 來自addEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String memName = req.getParameter("memName");
//			String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (memName == null || memName.trim().length() == 0) {
					errorMsgs.add("會員名稱: 請勿空白");
				}
//			else if(!newsTitle.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
//				errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
//            }
				String gender = req.getParameter("gender");
				Integer sex = 0;
				if (gender == null) {
					errorMsgs.add("性別 : 請勿空白");
				} else {
					sex = (gender == "male") ? 1 : (gender == "female") ? 2 : 0;
				}

				String memEmail = req.getParameter("memEmail").trim();
				if (memEmail == null || memEmail.trim().length() == 0) {
					errorMsgs.add("信箱請勿空白");
				}

				String memPswd = req.getParameter("memPswd").trim();
				if (memPswd == null || memPswd.trim().length() == 0) {
					errorMsgs.add("密碼請勿空白");
				}

				String memInform = req.getParameter("memInform").trim();

				String memPhone = req.getParameter("memPhone").trim();

				String memAddr = req.getParameter("memAddr").trim();
				/* 圖片處理段落 */
				byte[] memPic = null;
				Part part = req.getPart("memPic");
				InputStream in = part.getInputStream();
				if (in.available() > 0) {
					memPic = new byte[in.available()];
					in.read(memPic);
					in.close();
					System.out.println("buffer length: " + memPic.length);
				}
				// byte[] memPic =
				/* 將已填入內容包成VO */
				MemVO memVO = new MemVO();
				memVO.setMemName(memName);
				memVO.setMemGender(sex);
				memVO.setMemEmail(memEmail);
				memVO.setMemPswd(memPswd);
				memVO.setMemInform(memInform);
				memVO.setMemPhone(memPhone);
				memVO.setMemAddr(memAddr);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memVO", memVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/member/addMember.jsp");
					failureView.forward(req, res);
					return;
				}	
				// memName, memGender, memInform ,memEmail, memPswd, memPhone, memAddr, memPic
				/*************************** 2.開始新增資料 ***************************************/
				MemService newsSvc = new MemService();
				memVO = newsSvc.addMember(memName, sex, memInform, memEmail, memPswd, memPhone, memAddr, memPic);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/member/listAllMember.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/member/addMember.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { // 來自listAllEmp.jsp 或 /dept/listEmps_ByDeptno.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL"); // 送出刪除的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或
																// 【/dept/listEmps_ByDeptno.jsp】 或 【
																// /dept/listAllDept.jsp】
			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer memNo = new Integer(req.getParameter("memNo"));

				/*************************** 2.開始刪除資料 ***************************************/
				MemService memSvc = new MemService();
				MemVO memVO = memSvc.getOneMem(memNo);
				memSvc.deleteMember(memNo);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
//			DeptService deptSvc = new DeptService();
//			if(requestURL.equals("/dept/listEmps_ByDeptno.jsp") || requestURL.equals("/dept/listAllDept.jsp"))
//				req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(empVO.getDeptno())); // 資料庫取出的list物件,存入request

				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
	}
	/* 固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容 */
	/* 固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容 */
	/* 固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容 */
	/* 固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容固定內容 */

	public String genAuthCode(int length) {
		char[] authCode = new char[length];
		byte[] randNum = new byte[length];
		// random 8 numbers to choice character
		for (int i = 0; i < randNum.length; i++) {
			randNum[i] = (byte) (Math.random() * 62);
			// System.out.print(randNum[i] + " ");
		}
//		System.out.println();
		// set a inner list 0-9 ->(char)0-9, 10-35 ->(char)A-Z, 36-61 -> (char)a-z
		// purpose：Save memory
		for (int i = 0; i < length; i++) {
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