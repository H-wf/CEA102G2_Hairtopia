<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.comrep.model.*"%>
<%
    ComrepService comrepSvc = new ComrepService();
    List<ComrepVO> list = comrepSvc.getAll();
    pageContext.setAttribute("list",list);
%>
<html>
<head>
<meta charset="UTF-8">
<title>所有被檢舉留言-List All ComRep</title>
</head>
<body>
	<table>
		<tr>
			<th>留言檢舉編號</th>
			<th>留言編號</th>
			<th>檢舉方會員編號</th>
			<th>檢舉事由</th>
			<th>檢舉成立時間</th>
			<th>檢舉處理狀態</th>
		</tr>
		<c:forEach var="comrepVo" items="${list}">
			
			<tr>
				<td>${comrepVo.crepNo}</td>
				<td>${comrepVo.comNo}</td>
				<td>${comrepVo.memNo}</td>
				<td>${comrepVo.crepCon}</td>
				<td><fmt:formatDate value="${comrepVo.crepTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>${comrepVo.crepStatus}</td> 
			</tr>
		</c:forEach>
	</table>
</body>
</html>