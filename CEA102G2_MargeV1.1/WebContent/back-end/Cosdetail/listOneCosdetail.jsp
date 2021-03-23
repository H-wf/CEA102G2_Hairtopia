<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coudet.model.*"%>

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

<table id="table-1">
	<tr><td>
		 <h3>課程明細資料 - listOneCosdetail.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/Cos/select_cos_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">回後台主頁</a></h4>
	</td></tr>
</table>

<table style="width: 100%">
	<tr>
		<th>課程編號</th>
		<th>課程評價</th>
		<th>報名課程價格</th>
	</tr>
	
	<tr>
		<td>${cosdetVO.cosNo}</td>
			<td>${cosdetVO.cosComment}</td>
			<td>${cosdetVO.cosDetailPrice}</td>
	</tr>
</table>

</body>
</html>