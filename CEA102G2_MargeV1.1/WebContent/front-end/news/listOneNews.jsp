<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.news.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  NewsVO newsVO = (NewsVO) request.getAttribute("newsVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>員工資料 - listOneEmp.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>員工資料 - ListOneEmp.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/news/select_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>新聞編號</th>
		<th>新聞時間</th>
		<th>新聞標題</th>
		<th>新聞內容</th>
	</tr>
	<tr>
		<td><%=newsVO.getNewsNo()%></td>
		<td><%=newsVO.getNewsTime()%></td>
		<td><%=newsVO.getNewsTitle()%></td>
		<td><%=newsVO.getNewsCon()%></td>
<%-- 		<td><%=empVO.getSal()%></td> --%>
<%-- 		<td><%=empVO.getComm()%></td> --%>
<%-- 		<td><%=empVO.getDeptno()%></td> --%>
	</tr>
</table>

</body>
</html>