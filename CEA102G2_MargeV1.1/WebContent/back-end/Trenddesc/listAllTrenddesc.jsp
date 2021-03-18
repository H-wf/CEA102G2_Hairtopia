<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.trenddescription.model.*"%>

<%
TrenddescService trenddescSvc = new TrenddescService();
    List<TrenddescVO> list = trenddescSvc.getAll();
    pageContext.setAttribute("list",list);
%>
<html>
<head>
<meta charset="UTF-8">
<title>List All PostDet</title>
</head>
<body>
<table>
	<tr>
		<th>風格誌編號</th>
		<th>貼文編號</th>
	</tr>
	<c:forEach var="trenddescVo" items="${list}">
		
		<tr>
			<td>${trenddescVo.treNo}</td>
			<td>${trenddescVo.postNo}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>