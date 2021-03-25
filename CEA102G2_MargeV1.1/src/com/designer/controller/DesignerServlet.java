package com.designer.controller;

import java.io.IOException;

import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.google.gson.Gson;

import com.designer.model.*;
import com.salon.model.*;
import com.member.model.*;

@MultipartConfig

public class DesignerServlet extends HttpServlet {
	
	Gson gson = new Gson();
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action) || "getOne_For_Display_Back".equals(action)) { // 來自select_lec_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("desNo");
				if (str == null || str.trim().isEmpty()) {
					errorMsgs.add("請輸入設計師編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					if ("getOne_For_Display_Back".equals(action)) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/designer/select_des_page.jsp");
						failureView.forward(req, res);
						return;// 程式中斷
					} else if ("getOne_For_Display".equals(action)) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front-end/designer/select_des_page.jsp");
						failureView.forward(req, res);
						return;// 程式中斷
					}
				}

				Integer desNo = null;
				try {
					desNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("設計師格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					if ("getOne_For_Display_Back".equals(action)) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/designer/select_des_page.jsp");
						failureView.forward(req, res);
						return;// 程式中斷
					} else if ("getOne_For_Display".equals(action)) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front-end/designer/select_des_page.jsp");
						failureView.forward(req, res);
						return;// 程式中斷
					}
				}

				/*************************** 2.開始查詢資料 *****************************************/
				DesignerService desSvc = new DesignerService();
				DesignerVO desVO = desSvc.getOneDesByDesNo(desNo);
/*取得髮廊VO*/
				SalonVO salVo = new SalonService().getOneSalon(desVO.getSalNo());
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					if ("getOne_For_Display_Back".equals(action)) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/back-end/designer/select_des_page.jsp");
						failureView.forward(req, res);
						return;// 程式中斷
					} else if ("getOne_For_Display".equals(action)) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front-end/designer/select_des_page.jsp");
						failureView.forward(req, res);
						return;// 程式中斷
					}
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("designerVO", desVO); // 資料庫取出的lecVO物件,存入req
				req.setAttribute("salVo", salVo);
				String url="";
//MemDAO mamdao = new MemDAO();
//MemVO memVO = mamdao.findByPrimaryKey(2);
//HttpSession session = req.getSession(); 
//session.setAttribute("memVO", memVO);
				if("getOne_For_Display_Back".equals(action)) {
//				 url = "/back-end/designer/listOneDesignerBack.jsp";
				 url = "/front-end/designer/designerPage.jsp";
				 
				}else if("getOne_For_Display".equals(action)) {


//				 url = "/front-end/designer/select_des_page.jsp" ;
				 url = "/front-end/designer/designerPage.jsp";
				}
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneLec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				String url="";
				if("getOne_For_Display_Back".equals(action)) {
					url = "/back-end/designer/listOneDesignerBack.jsp";
				}else if("getOne_For_Display".equals(action)) {
					 url = "/front-end/designer/select_des_page.jsp" ;
					}
				RequestDispatcher failureView = req.getRequestDispatcher(url);
				failureView.forward(req, res);
			}

		}

		if ("insert".equals(action)) { // 來自addDesigner.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/

				Integer memNo = new Integer(req.getParameter("memNo"));
				
				DesignerService designerSvc = new DesignerService();
				DesignerVO designerVO = designerSvc.getOneDesByMemNo(memNo);
				if(designerVO != null) {
					errorMsgs.add("你已是成為設計師，請勿重複申請。");
				}

				Integer salNo = new Integer(req.getParameter("salNo"));

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

				 designerVO = new DesignerVO();

				designerVO.setMemNo(memNo);
				designerVO.setSalNo(salNo);
				designerVO.setDesInfor(desInfor);
				designerVO.setDesName(desName);
				designerVO.setDesSchedule(desSchedule);
				designerVO.setDesPic(desPic);
				
				
				
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("designerVO", designerVO); // 含有輸入格式錯誤的designerVO物件,也存入req(資料輸入錯誤不用全新重寫)
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/designer/addDesigner.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				designerSvc = new DesignerService();
				designerVO = designerSvc.addDesigner(memNo, salNo, desName, desInfor, desSchedule, desPic);
				designerVO = designerSvc.getOneDesByMemNo(memNo);
				req.setAttribute("designerVO", designerVO);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/designer/listOneDesigner.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllDesigner.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/designer/addDesigner.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listOneDesigner.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer desNo = new Integer(req.getParameter("desNo"));

				/*************************** 2.開始查詢資料 ****************************************/
				DesignerService designerSvc = new DesignerService();
				DesignerVO designerVO = designerSvc.getOneDesByDesNo(desNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("designerVO", designerVO); // 資料庫取出的designerVO物件,存入req
				String url = "/front-end/designer/update_designer_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_designer_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/designer/listOneDesigner.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update_Back".equals(action)) { // 來自listOneDesigner.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer desNo = new Integer(req.getParameter("desNo"));

				/*************************** 2.開始查詢資料 ****************************************/
				DesignerService designerSvc = new DesignerService();
				DesignerVO designerVO = designerSvc.getOneDesByDesNo(desNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("designerVO", designerVO); // 資料庫取出的designerVO物件,存入req
				String url = "/back-end/designer/update_designer_input_Back.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_designer_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/designer/listOneDesignerBack.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_designer_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer desNo = new Integer(req.getParameter("desNo"));
				Integer salNo = new Integer(req.getParameter("salNo"));

				String desName = req.getParameter("desName");
				String desNameReg = "^[(\\u4e00-\\u9fa5)(\\u0020)(a-zA-Z0-9_)]{2,20}$";
				if (desName == null || desName.trim().length() == 0) {
					errorMsgs.add("名字請勿空白");
				} else if (!desName.trim().matches(desNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("名字只能是中、英文字母、數字和_ , 且長度必需在2到20之間");
				}

				String desInfor = req.getParameter("desInfor").trim();
				if (desInfor == null || desInfor.trim().isEmpty() == true) {
					errorMsgs.add("自介請勿空白");
				}

				String desSchedule = req.getParameter("desSchedule");
				if (desSchedule == null || desSchedule.trim().length() == 0) {
					errorMsgs.add("班表請勿空白");
				}

				byte[] desPic = null;
				try {
					Part part = req.getPart("desPic");
					if (part.getSize() != 0) {
						// 此段檢查JSP送資料時是否有上傳圖片

						InputStream is = part.getInputStream();
						desPic = new byte[is.available()];
						is.read(desPic);
						is.close();
					} else {
						// 圖片未上傳走的路徑
						DesignerVO designerVO = new DesignerVO();
						designerVO.setDesNo(desNo);
						designerVO.setSalNo(salNo);
						designerVO.setDesName(desName);
						designerVO.setDesInfor(desInfor);
						designerVO.setDesSchedule(desSchedule);
					}
				} catch (Exception e) {
					errorMsgs.add("有問題");
				}

				// 有上傳圖片的路徑
				DesignerVO designerVO = new DesignerVO();
				designerVO.setDesNo(desNo);
				designerVO.setSalNo(salNo);
				designerVO.setDesName(desName);
				designerVO.setDesInfor(desInfor);
				designerVO.setDesSchedule(desSchedule);
				designerVO.setDesPic(desPic);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("designerVO", designerVO); // 含有輸入格式錯誤的serviceVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/designer/designer.do?action=getOne_For_Update&desNo="+desNo);
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				DesignerService designerSvc = new DesignerService();

				if (desPic != null) {
					designerSvc.update(salNo, desName, desInfor, desSchedule, desPic, desNo);
				} else {
					designerSvc.updateWithoutPic(salNo, desName, desInfor, desSchedule, desNo);
				}
				designerVO = designerSvc.getOneDesByDesNo(desNo);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("designerVO", designerVO); // 資料庫update成功後,正確的的designerVO物件,存入req
				String url = "/designer/designer.do?action=getOne_For_Update&desNo="+desNo;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneSalon.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {

				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/index.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update_Status".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer desNo = new Integer(req.getParameter("desNo"));	
				/*************************** 2.開始修改資料 *****************************************/
				DesignerService designerSvc = new DesignerService();
				DesignerVO designerVO = new DesignerVO();
				designerVO = designerSvc.getOneDesByDesNo(desNo);
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("designerVO", designerVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/back-end/designer/update_designer_input_Back.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/designer/listOneDesignerBack.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("Update_Status".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);

//			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer desNo = new Integer(req.getParameter("desNo"));	
				String str = req.getParameter("desStatus");	
				Integer desStatus = null;
				try {
					desStatus = new Integer(str);
				}catch(Exception e) {
					desStatus = 0 ;
				}


				/*************************** 2.開始修改資料 *****************************************/
				DesignerService designerSvc = new DesignerService();
				DesignerVO designerVO = new DesignerVO();
				designerSvc.updateOneStatus(desStatus,desNo);
				designerVO=designerSvc.getOneDesByDesNo(desNo);
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("designerVO", designerVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/back-end/designer/listAllDesigner.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/designer/listAllDesigner.jsp");
//				failureView.forward(req, res);
//			}
		}
		if ("delete".equals(action)) { // 來自listAll_lec.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer desNo = new Integer(req.getParameter("desNo"));

				/*************************** 2.開始刪除資料 ***************************************/
				DesignerService desSvc = new DesignerService();
				desSvc.deleteDesigner(desNo);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/designer/listAllDesigner.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/designer/listAllDesigner.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("nav_serchByAjax".equals(action)) { // 來自listAllEmp.jsp


			
			/***************************1.接收請求參數***************************************/
			String keyWord = (req.getParameter("keyWord"));
			/***************************2.開始刪除資料***************************************/
			DesignerService desSvc = new DesignerService();
			List<String> ajaxList= desSvc.getNameAJAX(keyWord);
	
			String jsonStr = gson.toJson(ajaxList);

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
		DesignerService desSvc = new DesignerService();
		List<DesignerVO> desList = desSvc.searchDes(keyword);
		
		req.setAttribute("desList", desList);
		
		String url = "/front-end/designer/SearchDes.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllDesigner.jsp
		successView.forward(req, res);
	}

	}

}
