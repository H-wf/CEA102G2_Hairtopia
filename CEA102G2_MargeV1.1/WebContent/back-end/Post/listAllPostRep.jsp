<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.postrep.model.*"%>
<%
    PostrepService postrepSvc = new PostrepService();
    List<PostrepVO> list = postrepSvc.getAll();
    pageContext.setAttribute("list",list);
%>
<html>
<head>
<meta charset="UTF-8">
<title>所有被檢舉貼文-List All PostRep</title>
</head>
<body>
	<table>
		<tr>
			<th>貼文檢舉編號</th>
			<th>貼文編號</th>
			<th>檢舉方會員編號</th>
			<th>檢舉事由</th>
			<th>檢舉成立時間</th>
			<th>檢舉處理狀態</th>
		</tr>
		<c:forEach var="postrepVo" items="${list}">
			
			<tr>
				<td>${postrepVo.prepNo}</td>
				<td>${postrepVo.postNo}</td>
				<td>${postrepVo.memNo}</td>
				<td>${postrepVo.postRepCon}</td>
				<td><fmt:formatDate value="${postrepVo.postRepTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>${postrepVo.postRepStatus}</td> 
			</tr>
		</c:forEach>
	</table>
</body>
</html>