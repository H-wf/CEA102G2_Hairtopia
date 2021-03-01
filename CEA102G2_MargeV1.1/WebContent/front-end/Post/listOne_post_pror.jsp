<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.post.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	PostVO postVO = (PostVO) request.getAttribute("postVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>
<html>
<head>
<style>
img {
	width: 150px;
}
</style>

<title>修改置頂- listOne_post_pror.jsp</title>
</head>
<body bgcolor='white'>

	
	<table id="table-1">
		<tr>
			<td>
				<h3>修改置頂- listOne_post_pror.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/front-end/Post/select_post_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>
	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/post/post.do"
		name="form" enctype="multipart/form-data">
	<table>
	<c:choose>
		<c:when test='${postVO.postStatus != 2 }'>
		<tr>
			<th>設計師編號</th>
			<th>貼文內容</th>
			<th>上傳時間</th>
			<th>貼文狀態</th>
			<th>置頂</th>
			<th>照片1</th>
			<c:if test='${not empty postVO.postPic2}'>
			<th>照片2</th>
			</c:if>
			<c:if test='${not empty postVO.postPic3}'>
			<th>照片3</th>
			</c:if>	
		</tr>
		<tr> 
			<td>${postVO.desNo}</td>
			<td>${postVO.postCon}</td>
			<td><fmt:formatDate value="${postVO.postTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td>${postVO.postStatus}</td>
				<td><input type="radio" name="postPror" 
					value="true" /> 是
					<input type="radio" name="postPror" 
					value="false"  checked/> 否
				</td>
			
			
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
						
		</tr>
		</c:when>
		
	</c:choose>
	</table>
	 <input name="postNo"  type="hidden" value="${postVO.postNo}"> 
	 <input name="postCon"  type="hidden" value="${postVO.postCon}"> 
	 <input name="desNo"  type="hidden" value="${postVO.desNo}"> 
	 <input name="postStatus" type="hidden" value="${postVO.postStatus}"> 
	 <input name="action" value="updateProrCheck" type="hidden"> 
	 <input type="submit" value="確認修改置頂" >

	</form>

</body>
</html>