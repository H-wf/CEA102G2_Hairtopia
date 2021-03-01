<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>
<%
	PostService postSvc = new PostService();
	List<PostVO> list = postSvc.getAll();
	pageContext.setAttribute("list", list);
%>



<html>
<head>
<style>
img {
	width: 150px;
}
</style>

<title>貼文資料 - listAll_post_back.jsp</title>
</head>
<body bgcolor='#99FF99'>

	
	<table id="table-1">
		<tr>
			<td>
				<h3>貼文資料 - listAll_post_back.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Post/select_post_pageBack.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<table border="1" cellpadding="5" style="border:2px #666 solid;text-align:center;">
		<tr>
		 
			<th>貼文編號</th>
			<th>設計師編號</th>
			<th>貼文內容</th>
			<th>上傳時間</th>
			<th>貼文狀態</th>
			<th>優先度</th>
			<th>照片1</th>
			<c:if test='${not empty postVO.postPic2}'>
			<th>照片2</th>
			</c:if>
			<c:if test='${not empty postVO.postPic3}'>
			<th>照片3</th>
			</c:if>	
			
		</tr>
		<c:forEach  var="postVO" items="${list}">
		<tr> 
			<td>${postVO.postNo}</td>
			<td>${postVO.desNo}</td>
			<td>${postVO.postCon}</td>
			<td><fmt:formatDate value="${postVO.postTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td>${postVO.postStatus}</td>
			<td>${postVO.postPror}</td>
			
		<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}" alt='沒有圖片' /></td>
		<td>
		 	<c:if test='${not empty postVO.postPic2}'>
		  		<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic2&idname=postNo&id=${postVO.postNo}" alt='沒有圖片' />
			</c:if>
		</td>
		
		<td>
			<c:if test='${not empty postVO.postPic3}'>
		   		<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic3&idname=postNo&id=${postVO.postNo}" alt='沒有圖片' />
			</c:if>
		</td>
		<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/post/post.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改"> 
						<input type="hidden" name="postNo" value="${postVO.postNo}"> 
<%-- 						<input type="hidden" name="desNo" value="${postVO.desNo}">  --%>
<%-- 						<input type="hidden" name="postPror" value="${postVO.postPror}">  --%>
<!-- 						<input type="hidden" name="action" value="getOne_For_UpdateBack"> -->
						<input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/post/post.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> 
						<input type="hidden" name="postNo" value="${postVO.postNo}"> 
						<input type="hidden" name="desNo" value="${postVO.desNo}"> 
						<input type="hidden" name="action" value="deleteBack">
					</FORM>
				</td>
					
				<td>
					<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/post/post.do"
							style="margin-bottom: 0px;">
							<input type="submit" value="查看"> 
							<input type="hidden" name="postNo" value="${postVO.postNo}"> 
							<input type="hidden" name="action" value="getOne_For_Display_back">
					</FORM>
				</td>
		</tr>
		</c:forEach>
		
	</table>

</body>
</html>