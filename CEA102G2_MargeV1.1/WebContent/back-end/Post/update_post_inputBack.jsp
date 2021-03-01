<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.post.model.*"%>

<%
	PostVO postVO = (PostVO) request.getAttribute("postVO");
%>
<html>
<head>


<meta charset="UTF-8">
<title>貼文資料修改 - update_post_inputBack.jsp</title>
</head>
<body bgcolor='#99FF99'>

	<table id="table-1">
		<tr>
			<td>
				<h3>貼文資料修改 - update_post_inputBack.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Post/select_post_pageBack.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料修改:</h3>


	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/post/post.do" name="form1" enctype="multipart/form-data">
		<table>
			<tr>
				<td>貼文編號:</td>
				<td>${postVO.postNo}</td>
			</tr>
			<tr><td>設計師編號:</td>
				<td>${postVO.desNo}</td>
			</tr>
			
			<tr>
				<td>是否隱藏</td>
				<td><input type="radio" name="postStatus" 
					value="2" /> 是
					<input type="radio" name="postStatus" 
					value="1"  checked/> 否
				</td>
			</tr>
				
			<tr>
				<td>貼文內容</td>
				<td>${postVO.postCon}</td>
			</tr>
	

		</table>
	
	
	<br> <input type="hidden" name="action" value="updateBack"> 
	     <input type="hidden" name="postNo" value="${postVO.postNo}"> 
		 <input type="hidden" name="desNo" value="${postVO.desNo}"> 
		 <input type="hidden" name="postCon" value="${postVO.postCon}"> 
		 <input type="hidden" name="postPror" value="${postVO.postPror}"> 
		 <input type="submit" value="送出修改" >
		
	</form>


</body>


</html>