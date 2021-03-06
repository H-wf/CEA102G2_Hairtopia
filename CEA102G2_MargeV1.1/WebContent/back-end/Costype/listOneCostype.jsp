<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coutype.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  CostypeVO costypeVO = (CostypeVO) request.getAttribute("costypeVO");
%>

<html>
<head>
<title>課程類別資料 - listOneCostype.jsp</title>

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
		 <h3>課程類別資料 - listOneCostype.jsp</h3>
		 <h4><a href="<%= request.getContextPath()%>/back-end/Costype/select_costype_page.jsp"><img src="<%= request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>課程類別編號</th>
		<th>課程類別名稱</th>
		<th>課程類別介紹</th>
		
	</tr>
	
	<tr>
		<td><%=costypeVO.getCosTypeNo()%></td>
		<td><%=costypeVO.getCosTypeName()%></td>
		<td><%=costypeVO.getCosTypeIntro()%></td>
		
	</tr>
</table>

</body>
</html>