<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.followlist.model.*"%>

<%
    FollowListService followListSvc = new FollowListService();
    List<FollowListVO> list = followListSvc.getAll();
    pageContext.setAttribute("list",list);
%>
<html>
<head>
<meta charset="UTF-8">
<title>List All FollowList</title>
</head>
<body>
<table>
	<tr>
		<th>會員編號</th>
		<th>設計師編號</th>
	</tr>
	<c:forEach var="followListVo" items="${list}">
		
		<tr>
			<td>${followListVo.memNo}</td>
			<td>${followListVo.desNo}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>