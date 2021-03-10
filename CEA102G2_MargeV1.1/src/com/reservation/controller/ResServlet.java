package com.reservation.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.designer.model.DesignerService;
import com.designer.model.DesignerVO;
import com.reservation.model.ResService;
import com.reservation.model.ResVO;
import com.service.model.ServiceService;
import com.service.model.ServiceVO;

public class ResServlet extends HttpServlet{
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException{
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("insert".equals(action)) { // 來自addRes.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				Integer memNo = new Integer(req.getParameter("memNo"));
				Integer serNo = new Integer(req.getParameter("serNo"));
				
				java.sql.Date resDate = null;
				try {
					resDate = java.sql.Date.valueOf(req.getParameter("resDate").trim());
				} catch (IllegalArgumentException e) {
					resDate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入預約時間!");
				}
				
				
				Integer resTime = new Integer(req.getParameter("resTime"));
				/*******************透過ServiceService取得金額及設計師等相關資料*******************/
				ServiceService serviceSvc = new ServiceService();
				ServiceVO serviceVO = serviceSvc.getOneServiceBySerNo(serNo);
				Integer desNo = new Integer(serviceVO.getDesNo());
				Integer resPrice = new Integer(serviceVO.getSerPrice());
				
				ResVO resVO = new ResVO();
				
				resVO.setMemNo(memNo);
				resVO.setSerNo(serNo);
				resVO.setDesNo(desNo);
				resVO.setResDate(resDate);
				resVO.setResTime(resTime);
				resVO.setResPrice(resPrice);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("resVO", resVO); // 含有輸入格式錯誤的ResVO物件,也存入req(資料輸入錯誤不用全新重寫)
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reservation/addRes.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ResService resSvc = new ResService();
				resVO = resSvc.addRes(memNo, serNo, desNo, resDate, resTime, resPrice);
				List<ResVO> list = resSvc.getAllResByMemNo(resVO.getMemNo());
				req.setAttribute("list",list);
				req.setAttribute("memNo", memNo);
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/reservation/listAllResByMem.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllResByMem.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reservation/addRes.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("delete".equals(action)) { // 來自listAllRes.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer resNo = new Integer(req.getParameter("resNo"));
				
				/***************************2.開始刪除資料***************************************/
				ResService resSvc = new ResService();
				resSvc.deleteRes(resNo);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/reservation/listAllRes.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reservation/listAllRes.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("resNo");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入預約編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reservation/select_res_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer resNo = null;
				try {
					resNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("預約編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reservation/select_res_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				ResService resSvc = new ResService();
				ResVO resVO = resSvc.getOneRes(resNo);
				if (resVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reservation/select_res_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("resVO", resVO); // 資料庫取出的empVO物件,存入req
				String url = "/front-end/reservation/listOneRes.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reservation/select_res_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Display_Of_Mem".equals(action)) { // 來自listAllResByMem.jsp的請求


			try {
				
				Integer resNo = new Integer(req.getParameter("resNo"));
				
				ResService resSvc = new ResService();
				ResVO resVO = resSvc.getOneRes(resNo);
				Integer memNo = resVO.getMemNo();
				List<ResVO> list=resSvc.getAllResByMemNo(memNo);
				
				req.setAttribute("resVO", resVO); // 資料庫取出的resVO物件,存入req
				req.setAttribute("list", list);
				//Bootstrap_modal
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				String url = "/front-end/reservation/listAllResByMem.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);
				return;

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		if ("getOne_For_Display_Of_Des".equals(action)) { // 來自listAllResByDes.jsp的請求
			
			
			try {
				
				Integer resNo = new Integer(req.getParameter("resNo"));
				
				ResService resSvc = new ResService();
				ResVO resVO = resSvc.getOneRes(resNo);
				Integer desNo = resVO.getDesNo();
				List<ResVO> list=resSvc.getAllResByDesNo(desNo);
				
				req.setAttribute("desNo", desNo); 
				req.setAttribute("resVO", resVO); // 資料庫取出的resVO物件,存入req
				req.setAttribute("list", list);
				//Bootstrap_modal
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				String url = "/front-end/reservation/listAllResByDes.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);
				return;
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
		if ("queryByDesNo".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer desNo = new Integer(req.getParameter("desNo"));
				
				/*************************** 2.開始查詢資料 ***************************************/
				ResService resSvc = new ResService();
				List<ResVO> list=resSvc.getAllResByDesNo(desNo);
				req.setAttribute("list", list);
				req.setAttribute("desNo", desNo);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				String url = "/front-end/reservation/listAllResByDes.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("查詢資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/reservation/select_res_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("queryByMemNo".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer memNo = new Integer(req.getParameter("memNo"));
				
				/*************************** 2.開始查詢資料 ***************************************/
				ResService resSvc = new ResService();
				List<ResVO> list=resSvc.getAllResByMemNo(memNo);
				req.setAttribute("list", list);
				req.setAttribute("memNo", memNo);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				String url = "/front-end/reservation/listAllResByMem.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("查詢資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/reservation/select_res_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update_Confirm".equals(action)) { // 來自listAllResByDes.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer resNo = new Integer(req.getParameter("resNo").trim());
				ResService resSvc = new ResService();
				ResVO resVO = resSvc.getOneRes(resNo);
				Integer resStatus = new Integer(1);
				String resCode = "";
				/***************************產生隨機驗證碼**************************************/
				//建立3個陣列，分別放入大寫英文、小寫英文、數字
				int[][] code=new int[3][];
				code[0]=new int[26];
				code[1]=new int[26];
				code[2]=new int[10];	
				
				for(int i=0 ; i<code[0].length ; i++) {
					code[0][i]=65+i;
				}
				for(int i=0 ; i<code[1].length ; i++) {
					code[1][i]=97+i;
				}
				for(int i=0 ; i<code[2].length ; i++) {
					code[2][i]=i;
				}
				
				//for迴圈跑5次挑出5個隨機碼
				for(int num=0 ; num<5 ; num++) {
					
					int pick = (int)(Math.random()*3);	//int pick隨機選出一個陣列
					
					if(pick == 0) {						//if選到大寫陣列，隨機挑出一個元素並轉成char呈現印出
						int pickIn = (int)(Math.random()*26);
						resCode += (char)code[0][pickIn];
					}
					else if(pick == 1) {				//if選到小寫陣列，隨機挑出一個元素並轉成char呈現印出
						int pickIn = (int)(Math.random()*26);
						resCode += (char)code[1][pickIn];
					}
					else {								//if選到數字，隨機挑出一個元素並印出
						int pickIn = (int)(Math.random()*10);
						resCode += code[2][pickIn];
					}
				}
				
				System.out.println(resCode);

				resVO.setResCode(resCode);
				resVO.setResStatus(resStatus);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
//					Integer desNo = resVO.getDesNo();
//					List<ResVO> list = resSvc.getAllResByDesNo(resVO.getDesNo());
//					req.setAttribute("list", list);
//					req.setAttribute("desNo", desNo);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reservation/listAllResByDes.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				
				resVO = resSvc.updateResConfirm(resStatus, resCode, resNo);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
//				req.setAttribute("resVO", resVO); // 資料庫update成功後,正確的的resVO物件,存入req
				Integer desNo = resVO.getDesNo();
				List<ResVO> list = resSvc.getAllResByDesNo(resVO.getDesNo());
				req.setAttribute("list", list);
				req.setAttribute("desNo", desNo);
				String url = "/front-end/reservation/listAllResByDes.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listAllEmpByDes.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reservation/listAllResByDes.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("cancelByDes".equals(action)) { // 來自listAllResBy.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer resNo = new Integer(req.getParameter("resNo").trim());
				ResService resSvc = new ResService();
				ResVO resVO = resSvc.getOneRes(resNo);
				Integer resStatus = new Integer(4);
				
				resVO.setResStatus(resStatus);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reservation/listAllResByDes.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				
				resVO = resSvc.updateResStatus(resStatus, resNo);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				
				Integer desNo = resVO.getDesNo();
				List<ResVO> list = resSvc.getAllResByDesNo(resVO.getDesNo());
				req.setAttribute("list", list);
				req.setAttribute("desNo", desNo);
				String url = "/front-end/reservation/listAllResByDes.jsp";
				
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listAllEmpBy.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reservation/listAllResByDes.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("cancelByMem".equals(action)) { // 來自listAllResBy.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer resNo = new Integer(req.getParameter("resNo").trim());
				ResService resSvc = new ResService();
				ResVO resVO = resSvc.getOneRes(resNo);
				Integer resStatus = new Integer(5);
				resVO.setResStatus(resStatus);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reservation/listAllResByMem.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				
				resVO = resSvc.updateResStatus(resStatus, resNo);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				Integer memNo = resVO.getMemNo();
				List<ResVO> list = resSvc.getAllResByMemNo(resVO.getMemNo());
				req.setAttribute("list", list);
				req.setAttribute("memNo", memNo);
				String url = "/front-end/reservation/listAllResByMem.jsp";
				
				
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listAllEmpBy.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reservation/listAllResByMem.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("resCodeVerify".equals(action)) { // 來自listAllResBy.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer resNo = new Integer(req.getParameter("resNo").trim());
				/******************************取得正確驗證碼做比對******************************/
				ResService resSvc = new ResService();
				ResVO resVO = resSvc.getOneRes(resNo);
				String resCode = resVO.getResCode();
				
				String inputCode = req.getParameter("resCode");
				String resCodeReg = "^[(a-zA-Z0-9_)]{5}$";
				if (inputCode == null || inputCode.trim().length() == 0) {
					errorMsgs.add("請填入驗證碼");
				} else if(!inputCode.trim().matches(resCodeReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("驗證碼為5位亂碼");
	            } else if(!(inputCode.equals(resCode))) {
	            	errorMsgs.add("驗證碼錯誤");
	            }
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					//轉交回原本頁面
					Integer desNo = resVO.getDesNo();
					List<ResVO> list=resSvc.getAllResByDesNo(desNo);
					req.setAttribute("list", list);
					req.setAttribute("desNo", desNo);
					req.setAttribute("resVO", resVO);
					
					//Bootstrap_modal
					boolean openModal=true;
					req.setAttribute("openModal",openModal );
					
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reservation/listAllResByDes.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer resStatus = new Integer(2);
				resVO.setResStatus(resStatus);
				
				/***************************2.開始修改資料*****************************************/
				
				resVO = resSvc.updateResStatus(resStatus, resNo);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				
				Integer desNo = resVO.getDesNo();
				List<ResVO> list = resSvc.getAllResByDesNo(resVO.getDesNo());
				req.setAttribute("list", list);
				req.setAttribute("desNo", desNo);
				req.setAttribute("resVO", resVO);
				
				//Bootstrap_modal
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				String url = "/front-end/reservation/listAllResByDes.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listAllEmpBy.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reservation/listAllResByMem.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("completeRes".equals(action)) { // 來自listAllResBy.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer resNo = new Integer(req.getParameter("resNo").trim());
				ResService resSvc = new ResService();
				ResVO resVO = resSvc.getOneRes(resNo);
				Integer resStatus = new Integer(3);
				resVO.setResStatus(resStatus);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reservation/listAllResByMem.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				
				resVO = resSvc.updateResStatus(resStatus, resNo);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				Integer memNo = resVO.getMemNo();
				List<ResVO> list = resSvc.getAllResByMemNo(resVO.getMemNo());
				req.setAttribute("resVO", resVO);
				req.setAttribute("list", list);
				req.setAttribute("memNo", memNo);
				
				//Bootstrap_modal
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				String url = "/front-end/reservation/listAllResByMem.jsp";
				
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listAllEmpBy.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reservation/listAllResByMem.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("reviewRes".equals(action)) { // 來自listAllResBy.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				//取得當筆預約的評分
				Integer resNo = new Integer(req.getParameter("resNo").trim());
				Integer resCom = new Integer(req.getParameter("resCom").trim());
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reservation/listAllResByMem.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				//修改當筆預約的評分
				ResService resSvc = new ResService();
				ResVO resVO = resSvc.updateResCom(resCom, resNo);
				
				//取得設計師原有評分及評價人數並進行修改
				Integer desNo = new Integer(resVO.getDesNo());
				DesignerService desSvc = new DesignerService();
				DesignerVO desVO = desSvc.getOneDesByDesNo(desNo);
				Integer currentCount = desVO.getDesCount();
				Integer currentScore = desVO.getDesTolScore();
				Integer desCount = currentCount + 1;
				Integer desTolScore = new Integer(resVO.getResCom())+currentScore;
				desSvc.updateOneScore(desCount, desTolScore, desNo);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				Integer memNo = resVO.getMemNo();
				List<ResVO> list = resSvc.getAllResByMemNo(resVO.getMemNo());
				req.setAttribute("resVO", resVO);
				req.setAttribute("list", list);
				req.setAttribute("memNo", memNo);
				
				//Bootstrap_modal
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				String url = "/front-end/reservation/listAllResByMem.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listAllEmpBy.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reservation/listAllResByMem.jsp");
				failureView.forward(req, res);
			}
		}
		
		
	}
}
