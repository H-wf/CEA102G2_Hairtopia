<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.cospost.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  CospostVO cospostVO = (CospostVO) request.getAttribute("cospostVO"); //CosPostServlet.java(Concroller), 存入req的cospostVO物件
%>

<html>
<head>
<title>課程公告資料 - listOneCosPost.jsp</title>

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
		 <h3>員工資料 - listOneCosPost.jsp</h3>
		 <h4><a href="<%= request.getContextPath()%>/back-end/Cospost/select_cospost_page.jsp"><img src="<%= request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>公告編號</th>
		<th>課程編號</th>
		<th>公告內容</th>
		<th>公告時間</th>
	</tr>
	<tr>
		<td><%=cospostVO.getCosPubNo()%></td>
		<td><%=cospostVO.getCosNo()%></td>
		<td><%=cospostVO.getCosPubCon()%></td>
		<td><%=cospostVO.getCosPubTime()%></td>
	</tr>
</table>

</body>
</html>