<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ptype.model.*"%>
<%@ page import="java.util.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>
<%
	PtypeVO ptypeVO = (PtypeVO) request.getAttribute("ptypeVO"); //PtypeServlet.java(Concroller), 存入req的ptypeVO物件
%>

<html>
<head>
<title>商品類別資料 - listOnePtype.jsp</title>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>商品類別資料 - ListOnePtype.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/ptype/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>商品類別編號</th>
		<th>商品類別名稱</th>
	</tr>
	<tr>

		<td>${ptypeVO.ptypeNo}</td>
		<td>${ptypeVO.ptypeName}</td>

	</tr>

</table>

</body>
</html>