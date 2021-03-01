<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coudet.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  CosdetVO cosdetVO = (CosdetVO) request.getAttribute("cosdetVO");
%>

<html>
<head>
<title>課程明細資料 - listOneCosdetail.jsp</title>

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
		 <h3>課程明細資料 - listOneCosdetail.jsp</h3>
		 <h4><a href="<%= request.getContextPath()%>/back-end/Cosdetail/select_cosdetail_page.jsp"><img src="<%= request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>課程編號</th>
		<th>會員編號</th>
		<th>課程評價</th>
		<th>報名課程價格</th>
	</tr>
	
	<tr>
		<td>${cosdetVO.getCosNo()}</td>
			<td>${cosdetVO.getMemNo()}</td>
			<td>${cosdetVO.getCosComment()}</td>
			<td>${cosdetVO.getCosDetailPrice()}</td>
		
	</tr>
</table>

</body>
</html>