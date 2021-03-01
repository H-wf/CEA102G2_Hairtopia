<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.cos.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  CosVO cosVO = (CosVO) request.getAttribute("cosVO");
%>

<html>
<head>
<title>課程資料 - listOneCos.jsp</title>

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
		 <h3>員工資料 - listOneCos.jsp</h3>
		 <h4><a href="<%= request.getContextPath()%>/back-end/Cos/select_cos_page.jsp"><img src="<%= request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>課程編號</th>
		<th>講師編號</th>
		<th>課程類別編號</th>
		<th>上課起</th>
		<th>上課迄</th>
		<th>課程介紹</th>
		<th>課程圖片</th>
		<th>課程地址</th>
		<th>報名總人數</th>
		<th>評價總分數</th>
		<th>課程狀態</th>
		<th>最低人數</th>
		<th>最高人數</th>
		<th>課程價格</th>
		<th>報名開始日</th>
		<th>報名截止日</th>
		<th>課程名稱</th>
	</tr>
	
	<tr>
		<td><%=cosVO.getCosNo()%></td>
		<td><%=cosVO.getLecNo()%></td>
		<td><%=cosVO.getCosTypeNo()%></td>
		<td><%=cosVO.getCosFrom()%></td>
		<td><%=cosVO.getCosTo()%></td>
		<td><%=cosVO.getCosIntro()%></td>
			<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=course&column=cosPic&idname=cosNo&id=${cosVO.cosNo}" alt='沒有圖片' /></td>
		<td><%=cosVO.getCosAdd()%></td>
		<td><%=cosVO.getCosCount()%></td>
		<td><%=cosVO.getCosRate()%></td>
		<td><%=cosVO.getCosStatus()%></td>
		<td><%=cosVO.getCosMinCount()%></td>
		<td><%=cosVO.getCosMaxCount()%></td>
		<td><%=cosVO.getCosPrice()%></td>
		<td><%=cosVO.getCosApplyFrom()%></td>
		<td><%=cosVO.getCosApplyTo()%></td>
		<td><%=cosVO.getCosName()%></td>
	</tr>
</table>

</body>
</html>