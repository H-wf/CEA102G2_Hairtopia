package com.post.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.post.model.*;
import com.salon.model.*;
import com.tag.model.*;
import com.tagdet.model.*;
import com.comment.model.*;
import com.designer.model.*;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;

@MultipartConfig
public class PostServlet extends HttpServlet {
	Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd hh:mm:ss").create();
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_DisplayByDesNo".equals(action) || "getOne_For_DisplayByDesNo_back".equals(action)) { /// 來自listAll_byDesNo.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("desNo");

				if (str == null || (str.trim()).isEmpty() == true) {
					errorMsgs.add("請輸入設計師編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					String url = "";
					if ("getOne_For_DisplayByDesNo".equals(action)) {
						url = "/front-end/Post/select_post_page.jsp";
					} else if ("getOne_For_DisplayByDesNo_back".equals(action)) {
						url = "/back-end/Post/select_post_pageBack.jsp";
					}
					RequestDispatcher failureView = req.getRequestDispatcher(url);
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer desNo = null;
				try {
					desNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("設計師編號號格式不正確");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					String url = "";
					if ("getOne_For_DisplayByDesNo".equals(action)) {
						url = "/front-end/Post/select_post_page.jsp";
					} else if ("getOne_For_DisplayByDesNo_back".equals(action)) {
						url = "/back-end/Post/select_post_pageBack.jsp";
					}
					RequestDispatcher failureView = req.getRequestDispatcher(url);
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				PostService postSvc = new PostService();
				List<PostVO> list = postSvc.getAll(desNo);

				if (list == null) {
					errorMsgs.add("查無貼文資料");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					String url = "";
					if ("getOne_For_DisplayByDesNo".equals(action)) {
						url = "/front-end/Post/select_post_page.jsp";
					} else if ("getOne_For_DisplayByDesNo_back".equals(action)) {
						url = "/back-end/Post/select_post_pageBack.jsp";
					}
					RequestDispatcher failureView = req.getRequestDispatcher(url);
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/

				req.setAttribute("list", list); // 資料庫取出的lecVO物件,存入req
				String url = "";
				if ("getOne_For_DisplayByDesNo".equals(action)) {
					url = "/front-end/Post/listAll_postByDesNo.jsp";
				} else if ("getOne_For_DisplayByDesNo_back".equals(action)) {
					url = "/back-end/Post/listAll_postByDesNoBack.jsp";
				}
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneLec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				String url = "";
				if ("getOne_For_DisplayByDesNo".equals(action)) {
					url = "/front-end/Post/select_post_page.jsp";
				} else if ("getOne_For_DisplayByDesNo_back".equals(action)) {
					url = "/back-end/Post/select_post_pageBack.jsp";
				}
				RequestDispatcher failureView = req.getRequestDispatcher(url);
				failureView.forward(req, res);

			}

		}

		if ("getOne_For_Display".equals(action) || "getOne_For_Display_back".equals(action) || "Display_fromListAll".equals(action) || "Display_fromDesPage".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("postNo");

				if (str == null || (str.trim()).isEmpty() == true) {
					errorMsgs.add("請輸入貼文編號");
				}

				Integer postNo = null;
				try {
					postNo = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("貼文編號號格式不正確");
				}

				/*************************** 2.開始查詢資料 *****************************************/
			/*查貼文*/
				PostService postSvc = new PostService();
				PostVO postVO = postSvc.getOnePost(postNo);

				if (postVO == null) {
					errorMsgs.add("查無貼文資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					String url = "";
					if("getOne_For_Display".equals(action)) {
						url = "/front-end/Post/select_post_page.jsp";
					}else if ("getOne_For_Display_back".equals(action)) {
						url = "/back-end/Post/select_post_pageBack.jsp";
					}
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Post/select_post_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

			/*如從設計師頁面的請求，查設計師Vo*/
				if("Display_fromDesPage".equals(action)) {
					DesignerService desSvc = new DesignerService();
					DesignerVO designerVO = desSvc.getOneDesByDesNo(postVO.getDesNo());
					req.setAttribute("designerVO", designerVO);
				}
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/

				req.setAttribute("postVO", postVO); // 資料庫取出的lecVO物件,存入req
				boolean openModal=true;
				req.setAttribute("openModal",openModal);
				
				String url = "";
				if ("getOne_For_Display".equals(action)) {
					url = "/front-end/Post/listPostWithComments_front.jsp";
				} else if ("getOne_For_Display_back".equals(action)) {
					url = "/back-end/Post/listPostWithComments.jsp";
				}else if ("Display_fromListAll".equals(action)) {
					url = "/front-end/Post/listAllPost.jsp";
				}else if("Display_fromDesPage".equals(action)) {
					url = "/front-end/designer/designerPage.jsp";
				}
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				String url = "";
				if("getOne_For_Display".equals(action)) {
					url = "/front-end/Post/select_post_page.jsp";
				}else if ("getOne_For_Display_back".equals(action)) {
					url = "/back-end/Post/select_post_pageBack.jsp";
				}
				RequestDispatcher failureView = req.getRequestDispatcher(url);
				failureView.forward(req, res);
			}

		}

		if ("getOne_For_Update".equals(action) || "getOne_For_UpdateBack".equals(action)
				|| "updatePror".equals(action)) { // 來自listAll_lec.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer postNo = new Integer(req.getParameter("postNo"));

				/*************************** 2.開始查詢資料 ****************************************/
				PostService postSvc = new PostService();
				PostVO postVO = postSvc.getOnePost(postNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("postVO", postVO); // 資料庫取出的lecVO物件,存入req
				String url = "";
				if ("getOne_For_Update".equals(action)) {
					url = "/front-end/Post/update_post_input.jsp";
				} else if ("getOne_For_UpdateBack".equals(action)) {
					url = "/back-end/Post/update_post_inputBack.jsp";
				} else if ("updatePror".equals(action)) {
					url = "/front-end/Post/listOne_post_pror.jsp";
				}

				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_lec_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				String url = "";
				if("getOne_For_Update".equals(action)) {
					url = "/front-end/Post/listAll_postByDesNo.jsp";
				}else if("getOne_For_UpdateBack".equals(action)) {
					url = "/back-end/Post/listAll_post_back.jsp";
					
				}else if("updatePror".equals(action)) {
					url= "/front-end/Post/listAll_postByDesNo.jsp";
				}
				RequestDispatcher failureView = req.getRequestDispatcher(url);
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

				Integer postNo = new Integer(req.getParameter("postNo").trim());
				Integer desNo = new Integer(req.getParameter("desNo").trim());
				Boolean postPror = new Boolean(req.getParameter("postPror"));

				String postCon = req.getParameter("postCon");
				if (postCon == null || postCon.trim().isEmpty() == true) {
					errorMsgs.add("貼文內容: 請勿空白");
				} else if (postCon.length() > 2200) {
					errorMsgs.add("貼文內容:長度必需在2到2200之間");
				}

				Integer postStatus = null;
				try {
					postStatus = new Integer(req.getParameter("postStatus").trim());
				} catch (NumberFormatException e) {
					postStatus = 0;
					errorMsgs.add("貼文狀態編號請填數字.");
				}

				byte[] postPic1 = null;
				try {
					Part part = req.getPart("upfile1");

					InputStream is = part.getInputStream();
					postPic1 = new byte[is.available()];
					is.read(postPic1);
					is.close();
				} catch (Exception e) {
					errorMsgs.add("postPic1有問題");
				}

				byte[] postPic2 = null;
				try {
					Part part = req.getPart("upfile2");

					InputStream is = part.getInputStream();
					postPic2 = new byte[is.available()];
					is.read(postPic2);
					is.close();
				} catch (Exception e) {
					errorMsgs.add("postPic2有問題");
				}

				byte[] postPic3 = null;
				try {
					Part part = req.getPart("upfile3");

					InputStream is = part.getInputStream();
					postPic3 = new byte[is.available()];
					is.read(postPic3);
					is.close();
				} catch (Exception e) {
					errorMsgs.add("postPic3有問題");
				}
//				if (postPic1.length == 0 && postPic2.length == 0 && postPic3.length == 0) {
//					errorMsgs.add("請至少上傳一張照片");
//				}

				// ====================調整上傳檔案的順序,避免可能只使用上傳2或上傳3按鈕====================
				if (postPic1.length == 0 && postPic2.length != 0) {
					postPic1 = postPic2;
					postPic2 = new byte[0];
				}

				if (postPic1.length == 0 && postPic3.length != 0) {
					postPic1 = postPic3;
					postPic3 = new byte[0];
				}

				if (postPic3.length != 0 && postPic2.length == 0) {
					postPic2 = postPic3;
					postPic3 = new byte[0];
				}
				// ====================順序調整結束==============================
				// ====================以下依照上傳的圖片數量走不同路徑新增貼文=========
				int switchCode = 0;
				PostVO postVO = new PostVO();
				if (postPic2.length != 0 && postPic3.length == 0) {
					postVO.setDesNo(desNo);
					postVO.setPostCon(postCon);
					postVO.setPostStatus(postStatus);
					postVO.setPostPror(postPror);
					postVO.setPostPic1(postPic1);
					postVO.setPostPic2(postPic2);
		
					switchCode = 2;
				} else if (postPic1.length == 0 && postPic2.length == 0 && postPic3.length == 0) {
					postVO.setDesNo(desNo);
					postVO.setPostCon(postCon);
					postVO.setPostStatus(postStatus);
					postVO.setPostPror(postPror);
					switchCode = 0;
				
				} else if (postPic2.length == 0 && postPic3.length == 0) {
					postVO.setDesNo(desNo);
					postVO.setPostCon(postCon);
					postVO.setPostStatus(postStatus);
					postVO.setPostPror(postPror);
					postVO.setPostPic1(postPic1);
				
					switchCode = 1;
				}else{
				
					postVO.setDesNo(desNo);
					postVO.setPostCon(postCon);
					postVO.setPostStatus(postStatus);
					postVO.setPostPror(postPror);
					postVO.setPostPic1(postPic1);
					postVO.setPostPic2(postPic2);
					postVO.setPostPic3(postPic3);
					System.out.println("3");
					switchCode = 3;
				}
				// ==================新增貼文路徑透過switccode賦值===============================
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("postVO", postVO); //

					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Post/update_post_input.jsp");
					failureView.forward(req, res);
					return;
				}
				PostService postSvc = new PostService();
				switch (switchCode) {
				case 3:
					postVO = postSvc.updatePost(postNo, desNo, postCon, postPic1, postPic2, postPic3, postStatus,
							postPror);
					break;
				case 2:
					postVO = postSvc.updatePost(postNo, desNo, postCon, postPic1, postPic2, postStatus, postPror);
					break;
				case 1:
					postVO = postSvc.updatePost(postNo, desNo, postCon, postPic1, postStatus, postPror);

					break;
				case 0:
					postVO = postSvc.updatePost(postNo, desNo, postCon,  postStatus, postPror);	
				default:
					errorMsgs.add("swithch goes wrong");

				}
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("postVO", postVO); // 資料庫update成功後,正確的的lecVO物件,存入req
				String url = "/front-end/Post/listOnePost.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneLec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Post/update_post_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("updateBack".equals(action) || "updateProrCheck".equals(action)) { // 來自update_lec_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				Integer postNo = new Integer(req.getParameter("postNo").trim());
				Integer desNo = new Integer(req.getParameter("desNo").trim());
				Integer postStatus = null;
				try {
					postStatus = new Integer(req.getParameter("postStatus").trim());
				} catch (NumberFormatException e) {
					postStatus = 0;
					errorMsgs.add("貼文狀態編號請填數字.");
				}
				String postCon = req.getParameter("postCon");
				Boolean postPror = new Boolean(req.getParameter("postPror"));

				PostVO postVO = new PostVO();
				postVO.setDesNo(postNo);
				postVO.setPostStatus(postStatus);

				if (!errorMsgs.isEmpty()) {

					req.setAttribute("postVO", postVO); //

					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Post/update_post_input.jsp");
					failureView.forward(req, res);
					return;
				}
				PostService postSvc = new PostService();
				postVO = postSvc.updatePost(postNo, desNo,postCon, postStatus, postPror);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("postVO", postVO); // 資料庫update成功後,正確的的lecVO物件,存入req
				String url = "";
				if ("updateProrCheck".equals(action)) {
					url = "/front-end/Post/listOnePost.jsp";
				} else if ("updateBack".equals(action)) {
					url = "/back-end/Post/listAll_post_back.jsp";
				}

				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneLec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Post/update_post_inputBack.jsp");
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
				Integer desNo = new Integer(req.getParameter("desNo"));
				String postCon = req.getParameter("postCon").trim();
				if (postCon == null || postCon.trim().isEmpty() == true) {
					errorMsgs.add("貼文內容: 請勿空白");
				} else if (postCon.length() > 2200) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("貼文內容: 字數不得超過2200");
				}

				Integer postStatus = null;
				try {
					postStatus = new Integer(req.getParameter("postStatus").trim());
				} catch (NumberFormatException e) {
					postStatus = 0;
					errorMsgs.add("狀態請填整數");
				}
				Boolean postPror = new Boolean(req.getParameter("postPror"));

				byte[] postPic1 = null;
				try {
					Part part = req.getPart("upfile1");

					InputStream is = part.getInputStream();
					postPic1 = new byte[is.available()];
					is.read(postPic1);
					is.close();
				} catch (Exception e) {
					errorMsgs.add("postPic1有問題");
				}

				byte[] postPic2 = null;
				try {
					Part part = req.getPart("upfile2");

					InputStream is = part.getInputStream();
					postPic2 = new byte[is.available()];
					is.read(postPic2);
					is.close();
				} catch (Exception e) {
					errorMsgs.add("postPic2有問題");
				}

				byte[] postPic3 = null;
				try {
					Part part = req.getPart("upfile3");

					InputStream is = part.getInputStream();
					postPic3 = new byte[is.available()];
					is.read(postPic3);
					is.close();
				} catch (Exception e) {
					errorMsgs.add("postPic3有問題");
				}
				if (postPic1.length == 0 && postPic2.length == 0 && postPic3.length == 0) {
					errorMsgs.add("請至少上傳一張照片");
				}
				// ====================調整上傳檔案的順序,避免可能只使用上傳2或上傳3按鈕====================
				if (postPic1.length == 0 && postPic2.length != 0) {
					postPic1 = postPic2;
					postPic2 = new byte[0];
				}

				if (postPic1.length == 0 && postPic3.length != 0) {
					postPic1 = postPic3;
					postPic3 = new byte[0];
				}

				if (postPic3.length != 0 && postPic2.length == 0) {
					postPic2 = postPic3;
					postPic3 = new byte[0];
				}
				// ====================順序調整結束==============================
				// ====================以下依照上傳的圖片數量走不同路徑新增貼文=========
				int switchCode = 0;
				PostVO postVO = new PostVO();
				if (postPic2.length != 0 && postPic3.length == 0) {
					postVO.setDesNo(desNo);
					postVO.setPostCon(postCon);
					postVO.setPostStatus(postStatus);
					postVO.setPostPror(postPror);
					postVO.setPostPic1(postPic1);
					postVO.setPostPic2(postPic2);
					switchCode = 2;
				} else if (postPic2.length == 0 && postPic3.length == 0) {
					postVO.setDesNo(desNo);
					postVO.setPostCon(postCon);
					postVO.setPostStatus(postStatus);
					postVO.setPostPror(postPror);
					postVO.setPostPic1(postPic1);
					switchCode = 1;
				} else {
					postVO.setDesNo(desNo);
					postVO.setPostCon(postCon);
					postVO.setPostStatus(postStatus);
					postVO.setPostPror(postPror);
					postVO.setPostPic1(postPic1);
					postVO.setPostPic2(postPic2);
					postVO.setPostPic3(postPic3);
					switchCode = 3;
				}
				// ==================新增貼文路徑透過switccode賦值===============================
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					req.setAttribute("postVO", postVO); //

					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Post/insertPost_Page.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				PostService postSvc = new PostService();
				switch (switchCode) {
				case 3:
					postVO = postSvc.addPost(desNo, postCon, postPic1, postPic2, postPic3, postStatus);
					break;
				case 2:
					postVO = postSvc.addPost(desNo, postCon, postPic1, postPic2, postStatus);
					break;
				case 1:
					postVO = postSvc.addPost(desNo, postCon, postPic1, postStatus);

					break;
				default:
					errorMsgs.add("swithch goes wrong");

				}
				
//				==================新增Tag===============================
				
				TagService tagSvc = new TagService();
				TagdetService tagdetSvc = new TagdetService();
				String[] tagStr = (req.getParameter("tagName").split(","));
				Integer postNo = postVO.getPostNo();
				
				for(String str:tagStr) {
					String tagName = str.substring(str.indexOf(":")+2, str.lastIndexOf("\""));
					Integer tagNo = tagSvc.getTagNo(tagName);
					
//			標籤存在，直接新增標明細
					if(tagNo != null) {
						
						TagdetVO tagdetVo = new TagdetVO();
						tagdetVo.setTagNo(tagNo);
						tagdetVo.setPostNo(postNo);
						
						tagdetSvc.addTagdet(tagdetVo);
//			標籤不存在，新增標籤後再新增標籤明細			
					}else {
						TagVO tagVo = tagSvc.addTag(tagName);
						
						TagdetVO tagdetVo = new TagdetVO();
						tagdetVo.setTagNo(tagVo.getTagNo());
						tagdetVo.setPostNo(postNo);
						
						tagdetSvc.addTagdet(tagdetVo);
					}
				}
				List<PostVO> list = new ArrayList<PostVO>();
				list = postSvc.getAll(desNo);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("list", list); 
//設置轉傳設計師頁面的VO
				DesignerService desSvc = new DesignerService();
				DesignerVO desVo = desSvc.getOneDesByDesNo(desNo);
				req.setAttribute("designerVO", desVo);
				
				SalonService salSvc = new SalonService();
				SalonVO salVo = salSvc.getOneSalon(desVo.getSalNo());
				req.setAttribute("salVo", salVo);
//轉回設計師頁面
				String url = "/front-end/designer/designerPage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAll_lec.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());

				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Post/insertPost_Page.jsp");
				failureView.forward(req, res);

			}

		}

		if ("delete".equals(action) || "deleteBack".equals(action)||"changePostStatus".equals(action)) { // 來自listAll_lec.jsp
			try {
				/*************************** 1.接收請求參數 ***************************************/
				String URI = req.getParameter("URI");
				Integer postNo = new Integer(req.getParameter("postNo"));
				Integer postStatus = new Integer(req.getParameter("postStatus"));

				/*************************** 2.開始刪除資料 ***************************************/
				PostService postSvc = new PostService();
				postSvc.deletePost(postNo,postStatus);
				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
//設定重導頁面資料(設計師VO)
				DesignerService desSvc = new DesignerService();
				PostVO postVO = postSvc.getOnePost(postNo);
				DesignerVO designerVO = desSvc.getOneDesByDesNo(postVO.getDesNo());
				req.setAttribute("designerVO", designerVO);
				
				String url = URI;
				
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Post/listAll_postByDesNo.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("getWholePost".equals(action)) {
			/*************************** 1.接收請求參數 ***************************************/
			Integer postNo = new Integer(req.getParameter("postNo"));
			
			PostService postSvc = new PostService();
			TagdetService tagdetSvc = new TagdetService();
			TagService tagSvc = new TagService();
			CommentService comSvc = new CommentService();
			
//取得postVo
			PostVO postVo = postSvc.getOnePost(postNo);
//判斷幾張照片
			postVo.setPostPic1(new byte[0]);
			if(postVo.getPostPic2() != null) {
				postVo.setPostPic2(new byte[0]);
			}else if(postVo.getPostPic3() != null) {
				postVo.setPostPic3(new byte[0]);
			}
//用postNo取得tagDet的tagNo再取得所有tagName
			Set<Integer> tagNoSet = tagdetSvc.getTagNo(postNo);
			List<String> tagNameList = tagSvc.getTagName(tagNoSet);
			
//用postNo取得所有comment
			List<CommentVO> commentList = comSvc.getComsByPostNo(postNo);
			
			
			Map ajaxMap = new HashMap();
			ajaxMap.put("postVo", postVo);
			ajaxMap.put("tagNameList", tagNameList);
			ajaxMap.put("commentList", commentList);

			String jsonStr = gson.toJson(ajaxMap);
			res.setContentType("text/plain");
			res.setCharacterEncoding("UTF-8");
			PrintWriter out = res.getWriter();
			out.print(jsonStr);
			out.flush();
			out.close();
			return;
		}
		if("updatePostByAJAX".equals(action)) {
			String postCon = req.getParameter("postCon");
			
			Integer postNo = new Integer(req.getParameter("postNo"));
			
			PostVO postVo = new PostVO();
			postVo.setPostNo(postNo);
			postVo.setPostCon(postCon);
			
			PostService postSvc = new PostService();
			postVo = postSvc.updatePost(postNo, postCon);
			String rePostCon = postVo.getPostCon();
			
			String jsonStr = gson.toJson(rePostCon);
			res.setContentType("text/plain");
			res.setCharacterEncoding("UTF-8");
			PrintWriter out = res.getWriter();
			out.print(jsonStr);
			out.flush();
			out.close();
			return;
		}

	}

}
