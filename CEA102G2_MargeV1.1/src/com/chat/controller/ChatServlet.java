package com.chat.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.chat.model.ChatService;
import com.chat.model.ChatVO;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class ChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ChatServlet() {
		super();
	}

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
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("chatNo");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入訊息編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/chat/select_chat_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer chatNo = null;
				try {
					chatNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("訊息編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/chat/select_chat_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ChatService chatSvc = new ChatService();
				ChatVO chatVO = chatSvc.getOneChat(chatNo);
				if (chatVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/chat/select_chat_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("chatVO", chatVO); // 資料庫取出的empVO物件,存入req
				String url = "/front-end/chat/listOneChat.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/select_chat_page.jsp");
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
				Integer chatNo = new Integer(req.getParameter("chatNo"));

				/*************************** 2.開始查詢資料 ****************************************/
				ChatService chatSvc = new ChatService();
				ChatVO chatVO = chatSvc.getOneChat(chatNo);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("chatVO", chatVO); // 資料庫取出的empVO物件,存入req

				String url = "/front-end/chat/update_chat_input.jsp";
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
				Integer chatNo= new Integer(req.getParameter("chatNo"));
				
				Integer chatSender = new Integer(req.getParameter("chatSender"));

				Integer chatReceiver = new Integer(req.getParameter("chatReceiver"));


				String chatText = req.getParameter("chatText").trim();
				if (chatText == null || chatText.trim().length() == 0) {
					errorMsgs.add("內容請勿空白");
				}

				/* 圖片處理段落 */
				byte[] chatPic = null;
				Part part = req.getPart("chatPic");
				InputStream in = part.getInputStream();
				if (in.available() > 0) {
					chatPic = new byte[in.available()];
					in.read(chatPic);
					in.close();
					System.out.println("buffer length: " + chatPic.length);
				}

				/* 將已填入內容包成VO */
				ChatVO chatVO = new ChatVO();
				chatVO.setChatSender(chatSender);
				chatVO.setChatReceiver(chatReceiver);
				chatVO.setChatText(chatText);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("chatVO", chatVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/chat/update_chat_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				ChatService chatSvc = new ChatService();
				chatVO = chatSvc.updateChat(chatNo, chatSender, chatReceiver, chatText, chatPic);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
//				ChatService deptSvc = new ChatService();
//				if(requestURL.equals("/chat/listEmps_ByDeptno.jsp") || requestURL.equals("/chat/listAllDept.jsp"))
//					req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(deptno)); // 資料庫取出的list物件,存入request

				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/chat/update_chat_input.jsp");
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
				Integer chatSender = new Integer(req.getParameter("chatSender"));

				Integer chatReceiver = new Integer(req.getParameter("chatReceiver"));

				String chatText = req.getParameter("chatText").trim();
				if (chatText == null || chatText.trim().length() == 0) {
					errorMsgs.add("內容請勿空白");
				}

				/* 圖片處理段落 */
				byte[] chatPic = null;
				Part part = req.getPart("chatPic");
				InputStream in = part.getInputStream();
				if (in.available() > 0) {
					chatPic = new byte[in.available()];
					in.read(chatPic);
					in.close();
					System.out.println("buffer length: " + chatPic.length);
				}
				/* 將已填入內容包成VO */
				ChatVO chatVO = new ChatVO();
				chatVO.setChatSender(chatSender);
				chatVO.setChatReceiver(chatReceiver);
				chatVO.setChatText(chatText);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("chatVO", chatVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/chat/addChat.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				ChatService chatSvc = new ChatService();
				chatVO = chatSvc.addChat(chatSender, chatReceiver, chatText, chatPic);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/chat/listAllChat.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/chat/addChat.jsp");
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
				Integer chatNo = new Integer(req.getParameter("chatNo"));

				/*************************** 2.開始刪除資料 ***************************************/
				ChatService chatSvc = new ChatService();
				ChatVO chatVO = chatSvc.getOneChat(chatNo);
				chatSvc.deleteChat(chatNo);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
//				DeptService deptSvc = new DeptService();
//				if(requestURL.equals("/dept/listEmps_ByDeptno.jsp") || requestURL.equals("/dept/listAllDept.jsp"))
//					req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(empVO.getDeptno())); // 資料庫取出的list物件,存入request

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

}
