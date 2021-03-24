package com.salon.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


import com.designer.model.*;
import com.salon.model.*;
import com.google.gson.Gson;


@MultipartConfig

public class SalonServlet extends HttpServlet{
	Gson gson = new Gson();

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
	
		
		if ("getOne_For_Display".equals(action)) { // 來自select_salon_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("salNo");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入沙龍編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/salon/select_salon_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer salNo = null;
				try {
					salNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("沙龍編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/salon/select_salon_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				SalonService salonSvc = new SalonService();
				SalonVO salonVO = salonSvc.getOneSalon(salNo);
				if (salonVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/salon/select_salon_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("salonVO", salonVO); // 資料庫取出的salonVO物件,存入req
				String url = "/front-end/salon/listOneSalon.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneSalon.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/salon/select_salon_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("insert".equals(action)) { // 來自addSalon.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String salName = req.getParameter("salName");
				String salNameReg = "^[(\\u4e00-\\u9fa5)(\\u0020)(a-zA-Z0-9_)]{2,30}$";
				if (salName == null || salName.trim().length() == 0) {
					errorMsgs.add("髮廊名稱請勿空白");
				} else if(!salName.trim().matches(salNameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("髮廊名稱長度必需在2到30之間");
	            }
				
				String salAdd = req.getParameter("salAdd").trim();
				if (salAdd == null || salAdd.trim().length() == 0) {
					errorMsgs.add("髮廊地址請勿空白");
				}
				
				String salTime = req.getParameter("salTime").trim();
				if (salTime == null || salTime.trim().length() == 0) {
					errorMsgs.add("營業時間請勿空白");
				}
				
				String salPhone = req.getParameter("salPhone").trim();
				if (salPhone == null || salPhone.trim().length() == 0) {
					errorMsgs.add("髮廊電話請勿空白");
				}
				
				String salLat=req.getParameter("salLat");
				String salLng=req.getParameter("salLng");
				Integer salStatus = new Integer(1);

				SalonVO salonVO = new SalonVO();
				salonVO.setSalName(salName);
				salonVO.setSalAdd(salAdd);
				salonVO.setSalTime(salTime);
				salonVO.setSalPhone(salPhone);
				salonVO.setSalStatus(salStatus);
				salonVO.setSalLat(salLat);
				salonVO.setSalLng(salLng);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("salonVO", salonVO); // 含有輸入格式錯誤的salonVO物件,也存入req(資料輸入錯誤不用全新重寫)
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/salon/addSalon.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				SalonService salonSvc = new SalonService();
				salonVO = salonSvc.addSalon(salName, salAdd, salTime, salPhone, salStatus,salLat,salLng);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/salon/listAllSalon.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/salon/addSalon.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllSalon.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer salNo = new Integer(req.getParameter("salNo"));
				
				/***************************2.開始查詢資料****************************************/
				SalonService salSvc = new SalonService();
				SalonVO salonVO = salSvc.getOneSalon(salNo);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("salonVO", salonVO);         // 資料庫取出的salonVO物件,存入req
				String url = "/front-end/salon/update_salon_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_salon_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/salon/listAllSalon.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // 來自update_salon_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer salNo = new Integer(req.getParameter("salNo").trim());
				
				String salName = req.getParameter("salName");
				String salNameReg = "^[(\\u4e00-\\u9fa5)(\\u0020)(a-zA-Z0-9_)]{2,10}$";
				if (salName == null || salName.trim().length() == 0) {
					errorMsgs.add("髮廊名稱請勿空白");
				} else if(!salName.trim().matches(salNameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("髮廊名稱長度必需在2到30之間");
	            }
				
				String salAdd = req.getParameter("salAdd").trim();
				if (salAdd == null || salAdd.trim().length() == 0) {
					errorMsgs.add("髮廊地址請勿空白");
				}	
				
				String salTime = req.getParameter("salTime").trim();
				if (salTime == null || salTime.trim().length() == 0) {
					errorMsgs.add("營業時間請勿空白");
				}
				
				String salPhone = req.getParameter("salPhone").trim();
				if (salPhone == null || salPhone.trim().length() == 0) {
					errorMsgs.add("髮廊電話請勿空白");
				}
				
				Integer salStatus = new Integer(req.getParameter("salStatus"));

				SalonVO salonVO = new SalonVO();
				salonVO.setSalNo(salNo);
				salonVO.setSalName(salName);
				salonVO.setSalAdd(salAdd);
				salonVO.setSalTime(salTime);
				salonVO.setSalPhone(salPhone);
				salonVO.setSalStatus(salStatus);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("salonVO", salonVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("front-end/salon/update_salon_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				SalonService salSvc = new SalonService();
				salonVO = salSvc.updateSalon(salNo, salName, salAdd, salTime, salPhone, salStatus);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("salonVO", salonVO); // 資料庫update成功後,正確的的salonVO物件,存入req
				String url = "/front-end/salon/listOneSalon.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneSalon.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/salon/update_salon_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer salNo = new Integer(req.getParameter("salNo"));
				
				/***************************2.開始刪除資料***************************************/
				SalonService salonSvc = new SalonService();
				salonSvc.deleteSalon(salNo);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/salon/listAllSalon.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/salon/listAllSalon.jsp");
				failureView.forward(req, res);
			}
		}
		

		if ("serchByAjax".equals(action)) { // 來自listAllEmp.jsp

		

			
				/***************************1.接收請求參數***************************************/
				String keyWord = (req.getParameter("keyWord"));
	
				/***************************2.開始刪除資料***************************************/
				SalonService salonSvc = new SalonService();
				List<SalonVO> ajaxList= salonSvc.getAllbyAjax(keyWord);
		
				String jsonStr = gson.toJson(ajaxList);
	
				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				PrintWriter out = res.getWriter();
				out.print(jsonStr);
				out.flush();
				out.close();
				return;

				
			
		}
		
		if("addDesAndSal".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
//			
			try {
			//========================接收參數 錯誤處理=========================
				int switchcode = 0;
				Integer salNo = new Integer(0);
				String salNoStr = req.getParameter("salNo");
				if("nodata".equals(salNoStr)) {
					switchcode = 1;	
					//新增Salon & Des
				}else {
					salNo = new Integer(salNoStr);
					switchcode = 2;
					
				}
				
				
				String salName = req.getParameter("salName");
				String salNameReg = "^[(\\u4e00-\\u9fa5)(\\u0020)(a-zA-Z0-9_)]{2,30}$";
				if (salName == null || salName.trim().length() == 0) {
					errorMsgs.add("髮廊名稱請勿空白");
				} else if(!salName.trim().matches(salNameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("髮廊名稱長度必需在2到30之間");
	            }

				
				String salAdd = req.getParameter("salAdd").trim();
				if (salAdd == null || salAdd.trim().length() == 0) {
					errorMsgs.add("髮廊地址請勿空白");
				}
		
				String salTime = req.getParameter("salTime").trim();
				if (salTime == null || salTime.trim().length() == 0) {
					errorMsgs.add("營業時間請勿空白");
				}
			
				String salPhone = req.getParameter("salPhone").trim();
				if (salPhone == null || salPhone.trim().length() == 0) {
					errorMsgs.add("髮廊電話請勿空白");
				}
	
				Integer salStatus = new Integer(1);
				String salLat = req.getParameter("salLat");
				String salLng = req.getParameter("salLng");
				
				
			

				

				
			//=======================準備包裝到salonVO=========================
				SalonVO salonVO = new SalonVO();
				salonVO.setSalName(salName);
				salonVO.setSalAdd(salAdd);
				salonVO.setSalPhone(salPhone);
				salonVO.setSalTime(salTime);
				salonVO.setSalLat(salLat);
				salonVO.setSalLng(salLng);
				salonVO.setSalStatus(salStatus);
				salonVO.setSalNo(salNo);
				
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("salonVO", salonVO); 

					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/designer/addDesAndSal.jsp");
					failureView.forward(req, res);
					return;
				}
			
				
			//===============================接受設計師資料包裝VO====================
				Integer memNo =new Integer( req.getParameter("memNo").trim());
				DesignerService designerSvc = new DesignerService();
				DesignerVO designerTest = designerSvc.getOneDesByMemNo(memNo);
				if(designerTest != null) {
					errorMsgs.add("你已是成為設計師，請勿重複申請。");
				}
				
				
				String desName = req.getParameter("desName");

				if (desName == null || desName.trim().length() == 0) {
					errorMsgs.add("名字請勿空白");
				} else if (desName.trim().length() <= 2 || desName.trim().length() >= 20) {
					errorMsgs.add("名字長度必需在2到20之間");
				}


				String desInfor = req.getParameter("desInfor").trim();
				if (desInfor == null || desInfor.trim().isEmpty()) {
					errorMsgs.add("自介請勿空白");
				}

				String desSchedule = req.getParameter("desSchedule").trim();
				if (desSchedule == null || desSchedule.trim().isEmpty()) {
					errorMsgs.add("班表請勿空白");
				}

				byte[] desPic = null;

				Part part = req.getPart("desPic");
				if (part.getSize() != 0) {
					try {
						InputStream is = part.getInputStream();
						desPic = new byte[is.available()];
						is.read(desPic);
						is.close();
					} catch (Exception e) {
						errorMsgs.add("上傳圖片發生錯誤");
					}

				} else {
					errorMsgs.add("請上傳設計師照片");

				}

				DesignerVO designerVO = new DesignerVO();
				
				designerVO.setDesInfor(desInfor);
				designerVO.setDesSchedule(desSchedule);
				designerVO.setDesPic(desPic);
				designerVO.setMemNo(memNo);
				designerVO.setDesName(desName);
				

				
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("salonVO", salonVO); 

					req.setAttribute("designerVO", designerVO);// 含有輸入格式錯誤的salonVO物件,也存入req(資料輸入錯誤不用全新重寫)

					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/designer/addDesAndSal.jsp");
					failureView.forward(req, res);
					return;
				}
	//==================================準備資料完畢 呼叫SVC============================
				switch(switchcode) {
				case 1:
					List<DesignerVO> listDes = new LinkedList<DesignerVO>();
					listDes.add(designerVO);

					SalonService salonSvc = new SalonService();
					salonSvc.addSalonWithDes(salonVO, listDes);
					designerVO = designerSvc.getOneDesByMemNo(memNo);
					break;
				case 2:
					DesignerService desSvc = new DesignerService();
					desSvc.addDesigner(memNo, salNo, desName, desInfor, desSchedule, desPic);
					designerVO = desSvc.getOneDesByMemNo(memNo);
					break;
				default:
					errorMsgs.add("新增資料失敗:switch");
					
					
				}
				
				
				req.setAttribute("designerVO", designerVO);         // 資料庫取出的salonVO物件,存入req
				String url = "/front-end/index.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_salon_input.jsp
				successView.forward(req, res);	
				
			} catch (Exception e) {
				errorMsgs.add("資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/designer/addDesAndSal.jsp");
				failureView.forward(req, res);		
			}
			
		}
		
		if ("serchByAjaxSalname".equals(action)) { // 來自listAllEmp.jsp


	

			
				/***************************1.接收請求參數***************************************/
				String salName = (req.getParameter("salName".trim()));
				SalonVO salonAjax = new SalonVO();

	
				/***************************2.開始刪除資料***************************************/
				SalonService salonSvc = new SalonService();
				salonAjax= salonSvc.getOneSalon(salName);
		
				String jsonStr = gson.toJson(salonAjax);

				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				PrintWriter out = res.getWriter();
				out.print(jsonStr);
				out.flush();
				out.close();
				return;

				
			
		}

		if ("nav_serchByAjax".equals(action)) { // 來自listAllEmp.jsp


			
			/***************************1.接收請求參數***************************************/
			String keyWord = (req.getParameter("keyWord"));
			/***************************2.開始查資料***************************************/
			SalonService salSvc = new SalonService();
			List<String> ajaxList= salSvc.getSalAJAX(keyWord);
	
			String jsonStr = gson.toJson(ajaxList);

			res.setContentType("text/plain");
			res.setCharacterEncoding("UTF-8");
			PrintWriter out = res.getWriter();
			out.print(jsonStr);
			out.flush();
			out.close();
			return;
	}
		
		if ("serchByAjax".equals(action)) { // 來自listAllEmp.jsp

			

			
			/***************************1.接收請求參數***************************************/
			String keyWord = (req.getParameter("keyWord"));

			/***************************2.開始刪除資料***************************************/
			SalonService salonSvc = new SalonService();
			List<SalonVO> ajaxList= salonSvc.getAllbyAjax(keyWord);
	
			String jsonStr = gson.toJson(ajaxList);

			res.setContentType("text/plain");
			res.setCharacterEncoding("UTF-8");
			PrintWriter out = res.getWriter();
			out.print(jsonStr);
			out.flush();
			out.close();
			return;

			
		
	}
	
	if("addDesAndSal".equals(action)) {
		List<String> errorMsgs = new LinkedList<String>();
		// Store this set in the request scope, in case we need to
		// send the ErrorPage view.
		req.setAttribute("errorMsgs", errorMsgs);
		
//		
		try {
		//========================接收參數 錯誤處理=========================
			int switchcode = 0;
			Integer salNo = new Integer(0);
			String salNoStr = req.getParameter("salNo");
			if("nodata".equals(salNoStr)) {
				switchcode = 1;	
				//新增Salon & Des
			}else {
				salNo = new Integer(salNoStr);
				switchcode = 2;
				
			}
			
			
			String salName = req.getParameter("salName");
			String salNameReg = "^[(\\u4e00-\\u9fa5)(\\u0020)(a-zA-Z0-9_)]{2,30}$";
			if (salName == null || salName.trim().length() == 0) {
				errorMsgs.add("髮廊名稱請勿空白");
			} else if(!salName.trim().matches(salNameReg)) { //以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("髮廊名稱長度必需在2到30之間");
            }

			
			String salAdd = req.getParameter("salAdd").trim();
			if (salAdd == null || salAdd.trim().length() == 0) {
				errorMsgs.add("髮廊地址請勿空白");
			}
	
			String salTime = req.getParameter("salTime").trim();
			if (salTime == null || salTime.trim().length() == 0) {
				errorMsgs.add("營業時間請勿空白");
			}
		
			String salPhone = req.getParameter("salPhone").trim();
			if (salPhone == null || salPhone.trim().length() == 0) {
				errorMsgs.add("髮廊電話請勿空白");
			}

			Integer salStatus = new Integer(1);
			String salLat = req.getParameter("salLat");
			String salLng = req.getParameter("salLng");

			

			
		//=======================準備包裝到salonVO=========================
			SalonVO salonVO = new SalonVO();
			salonVO.setSalName(salName);
			salonVO.setSalAdd(salAdd);
			salonVO.setSalPhone(salPhone);
			salonVO.setSalTime(salTime);
			salonVO.setSalLat(salLat);
			salonVO.setSalLng(salLng);
			salonVO.setSalStatus(salStatus);
			salonVO.setSalNo(salNo);
		
			
		//===============================接受設計師資料包裝VO====================
			Integer memNo =new Integer( req.getParameter("memNo").trim());
			DesignerService designerSvc = new DesignerService();
			DesignerVO designerTest = designerSvc.getOneDesByMemNo(memNo);
			if(designerTest != null) {
				errorMsgs.add("你已是成為設計師，請勿重複申請。");
			}
			
			
			String desName = req.getParameter("desName");

			if (desName == null || desName.trim().length() == 0) {
				errorMsgs.add("名字請勿空白");
			} else if (desName.trim().length() <= 2 || desName.trim().length() >= 20) {
				errorMsgs.add("名字長度必需在2到20之間");
			}


			String desInfor = req.getParameter("desInfor").trim();
			if (desInfor == null || desInfor.trim().isEmpty()) {
				errorMsgs.add("自介請勿空白");
			}

			String desSchedule = req.getParameter("desSchedule").trim();
			if (desSchedule == null || desSchedule.trim().isEmpty()) {
				errorMsgs.add("班表請勿空白");
			}

			byte[] desPic = null;

			Part part = req.getPart("desPic");
			if (part.getSize() != 0) {
				try {
					InputStream is = part.getInputStream();
					desPic = new byte[is.available()];
					is.read(desPic);
					is.close();
				} catch (Exception e) {
					errorMsgs.add("上傳圖片發生錯誤");
				}

			} else {
				errorMsgs.add("請上傳設計師照片");

			}

			DesignerVO designerVO = new DesignerVO();
			
			designerVO.setDesInfor(desInfor);
			designerVO.setDesSchedule(desSchedule);
			designerVO.setDesPic(desPic);
			designerVO.setMemNo(memNo);
			designerVO.setDesName(desName);
			
			
		
			
			
			
	
			
			if (!errorMsgs.isEmpty()) {

				req.setAttribute("salonVO", salonVO); 

				req.setAttribute("designerVO", designerVO);// 含有輸入格式錯誤的salonVO物件,也存入req(資料輸入錯誤不用全新重寫)

				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/designer/addDesAndSal.jsp");
				failureView.forward(req, res);
				return;
			}
//==================================準備資料完畢 呼叫SVC============================
			switch(switchcode) {
			case 1:
				List<DesignerVO> listDes = new LinkedList<DesignerVO>();
				listDes.add(designerVO);

				SalonService salonSvc = new SalonService();
				salonSvc.addSalonWithDes(salonVO, listDes);
				designerVO = designerSvc.getOneDesByMemNo(memNo);
				break;
			case 2:
				DesignerService desSvc = new DesignerService();
				desSvc.addDesigner(memNo, salNo, desName, desInfor, desSchedule, desPic);
				designerVO = desSvc.getOneDesByMemNo(memNo);
				break;
			default:
				errorMsgs.add("新增資料失敗:switch");
				
				
			}
			
			
			req.setAttribute("designerVO", designerVO);         // 資料庫取出的salonVO物件,存入req
			String url = "/front-end/designer/listOneDesigner.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_salon_input.jsp
			successView.forward(req, res);	
			
		} catch (Exception e) {
			errorMsgs.add("資料失敗:"+e.getMessage());
			RequestDispatcher failureView = req
					.getRequestDispatcher("/front-end/designer/addDesAndSal.jsp");
			failureView.forward(req, res);		
		}
		
	}
	
	if ("serchByAjaxSalname".equals(action)) { // 來自listAllEmp.jsp




		
			/***************************1.接收請求參數***************************************/
			String salName = (req.getParameter("salName".trim()));
			SalonVO salonAjax = new SalonVO();


			/***************************2.開始刪除資料***************************************/
			SalonService salonSvc = new SalonService();
			salonAjax= salonSvc.getOneSalon(salName);
	
			String jsonStr = gson.toJson(salonAjax);

			res.setContentType("text/plain");
			res.setCharacterEncoding("UTF-8");
			PrintWriter out = res.getWriter();
			out.print(jsonStr);
			out.flush();
			out.close();
			return;
	}
	
	if("navSearch".equals(action)) {
		/***************************1.接收請求參數***************************************/
		String keyword = (req.getParameter("keyword"));
		/***************************2.開始查資料***************************************/
		SalonService salSvc = new SalonService();
		List<SalonVO> salList = salSvc.getSalSearch(keyword);
		
		req.setAttribute("salList", salList);
		
		String url = "/front-end/salon/listAllSalon_Search.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllDesigner.jsp
		successView.forward(req, res);
	}
	

	}

}
