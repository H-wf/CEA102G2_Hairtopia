<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ordermaster.model.*"%>
<%@ page import="java.util.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>
<%
	OrderMasterVO ordermasterVO = (OrderMasterVO) request.getAttribute("ordermasterVO"); //OrderMasterServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>訂單資料 - listOneOrderMaster.jsp</title>
<%@include file="/front-end/tempFile/head" %>
</head>
<body bgcolor='white'>
<%@include file="/front-end/tempFile/navBar" %>
<!-- Begin Page Content -->
<div class="container-fluid px-0">
<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>訂單資料 - ListOneOrderMaster.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/product/EShop2.jsp">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>訂單編號</th>
		<th>會員編號</th>
		<th>訂購日期</th>
		<th>訂單狀態</th>
		<th>總金額</th>
	</tr>
	<tr>
		<td>${ordermasterVO.ordNo}</td>
		<td>${ordermasterVO.memNo}</td>
		<td>${ordermasterVO.ordDate}</td>
		<td>${ordermasterVO.ordStatus}</td>
		<td>${ordermasterVO.ordAmt}</td>
	</tr>

</table>
</div>
<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>
</html>