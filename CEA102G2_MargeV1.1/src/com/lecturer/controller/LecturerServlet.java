package com.lecturer.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import com.lecturer.model.*;

/**
 * Servlet implementation class LecturerServelet
 */

@MultipartConfig

public class LecturerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public LecturerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		

		if ("getOne_For_Display".equals(action)) { // 來自select_lec_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("lecNo");
				if (str == null || (str.trim()).isEmpty() == true) {
					errorMsgs.add("請輸入講師編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Lecturer/select_lec_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer lecNo = null;
				try {
					lecNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("講師編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Lecturer/select_lec_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				LecturerService lecSvc = new LecturerService();
				LecturerVO lecVO = lecSvc.getOneLecturer(lecNo);
				if (lecVO == null) {
					errorMsgs.add("查無講師資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Lecturer/select_lec_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("lecVO", lecVO); // 資料庫取出的lecVO物件,存入req
				String url = "/back-end/Lecturer/listOneLec.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneLec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Lecturer/select_lec_page.jsp");
				failureView.forward(req, res);
			}

		}

		if ("getOne_For_Update".equals(action)) { // 來自listAll_lec.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer lecNo = new Integer(req.getParameter("lecNo"));
			

				/*************************** 2.開始查詢資料 ****************************************/
				LecturerService lecSvc = new LecturerService();
				LecturerVO lecVO = lecSvc.getOneLecturer(lecNo);
				
			
				

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("lecVO", lecVO); // 資料庫取出的lecVO物件,存入req
				String url = "/back-end/Lecturer/update_lec_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_lec_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Lecturer/listAll_lec.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_lec_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				Integer lecNo = new Integer(req.getParameter("lecNo").trim());
				

				String lecName = req.getParameter("lecName");

				String lecNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (lecName == null || lecName.trim().isEmpty() == true ) {
					
					errorMsgs.add("講師姓名: 請勿空白");
				} else if (!lecName.trim().matches(lecNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("講師姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String lecIntro = req.getParameter("lecIntro").trim();
				if (lecIntro == null || lecIntro.trim().isEmpty() == true) {
					errorMsgs.add("簡介請勿空白");
				}

				Integer lecStatus = null;
				try {
					lecStatus = new Integer(req.getParameter("lecStatus").trim());
				} catch (NumberFormatException e) {
					lecStatus = 0;
					errorMsgs.add("狀態請填數字");
				}

				byte[] lecPic = null;
				try {
					Part part = req.getPart("upfile1");

					if (part.getSize() != 0) {
						//此段檢查JSP送資料時是否有上傳圖片
						
						InputStream is = part.getInputStream();
						lecPic = new byte[is.available()];
						is.read(lecPic);
						is.close();
					} else {
						//圖片未上傳走的路徑
						LecturerVO lecVO = new LecturerVO();
						lecVO.setLecNo(lecNo);
						lecVO.setLecName(lecName);
						lecVO.setLecIntro(lecIntro);
						lecVO.setLecStatus(lecStatus);

					}
				} catch (Exception e) {
					errorMsgs.add("有問題");
				}
				//有上傳圖片走的路徑
				LecturerVO lecVO = new LecturerVO();
				lecVO.setLecNo(lecNo);
				lecVO.setLecName(lecName);
				lecVO.setLecPic(lecPic);
				lecVO.setLecIntro(lecIntro);
				lecVO.setLecStatus(lecStatus);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("lecVO", lecVO); // 含有輸入格式錯誤的lecVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Lecturer/update_lec_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				/*************************** 2.開始修改資料 *****************************************/
				LecturerService lecSvc = new LecturerService();
				//下方if判斷式判斷以哪一個指令更新資料
				if (lecPic != null) {
					lecVO = lecSvc.updateLecturer(lecNo, lecName, lecPic, lecIntro, lecStatus);
				} else {
					lecVO = lecSvc.updateLecturerWoPic(lecNo, lecName, lecIntro, lecStatus);
				}

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("lecVO", lecVO); // 資料庫update成功後,正確的的lecVO物件,存入req
				String url = "/back-end/Lecturer/listOneLec.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneLec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Lecturer/update_lec_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // 來自addLec.jsp的請求
			

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String lecName = req.getParameter("lecName");

				String lecNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (lecName == null || lecName.trim().isEmpty() == true) {
					errorMsgs.add("講師姓名: 請勿空白");
				} else if (!lecName.trim().matches(lecNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("講師姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String lecIntro = req.getParameter("lecIntro").trim();

				if (lecIntro == null || lecIntro.trim().isEmpty() == true) {
					errorMsgs.add("簡介請勿空白");
				}

				Integer lecStatus = null;
				try {
					lecStatus = new Integer(req.getParameter("lecStatus").trim());
				} catch (NumberFormatException e) {
					lecStatus = 0;
					errorMsgs.add("狀態請填整數");
				}

				byte[] lecPic = null;
				try {
					Part part = req.getPart("upfile1");
				
					InputStream is = part.getInputStream();
					lecPic = new byte[is.available()];
					is.read(lecPic);
					is.close();
					}catch (Exception e) {
						errorMsgs.add("有問題");
					}
					if(lecPic.length == 0)
					lecPic = null;	
					LecturerVO lecVO = new LecturerVO();
					lecVO.setLecName(lecName);
					lecVO.setLecPic(lecPic);
					lecVO.setLecIntro(lecIntro);
					lecVO.setLecStatus(lecStatus);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("lecVO", lecVO); // 含有輸入格式錯誤的LecVO物件,也存入req
					
					
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Lecturer/addLec.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				LecturerService lecSvc = new LecturerService();
				lecVO = lecSvc.addLecturer(lecName, lecPic, lecIntro, lecStatus);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Lecturer/listAll_lec.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAll_lec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());

				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Lecturer/addLec.jsp");
				failureView.forward(req, res);

			}

		}

		if ("delete".equals(action)) { // 來自listAll_lec.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer lecNo = new Integer(req.getParameter("lecNo"));

				/*************************** 2.開始刪除資料 ***************************************/
				LecturerService lecSvc = new LecturerService();
				lecSvc.deleteLecturer(lecNo);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Lecturer/listAll_lec.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Lecturer/listAll_lec.jsp");
				failureView.forward(req, res);
			}
		}

	}


}
