<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cos.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
CosVO cosVO = (CosVO) request.getAttribute("cosVO");
%>


<html>
<head>
<title>所有現存課程資料 - listAllCosStatus.jsp</title>

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
	width: 800px;
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

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有現存課程資料 - listAllCosStatus.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/Cos/select_cos_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

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
			<td>${cosVO.getCosNo()}</td>
			<td>${cosVO.getLecNo()}</td>
			<td>${cosVO.getCosTypeNo()}</td>
			<td><fmt:formatDate value="${cosVO.getCosFrom()}" pattern="yyyy-MM-dd HH:mm:ss.SSSZ"/></td>
			<td><fmt:formatDate value="${cosVO.getCosTo()}" pattern="yyyy-MM-dd HH:mm:ss.SSSZ"/></td>
			<td>${cosVO.getCosIntro()}</td>
			<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=course&column=cosPic&idname=cosNo&id=${cosVO.cosNo}" alt='沒有圖片' /></td>
			<td>${cosVO.getCosAdd()}</td>
			<td>${cosVO.getCosCount()}</td>
			<td>${cosVO.getCosRate()}</td>
			<td>${cosVO.cosStatus()}</td>
			<td>${cosVO.getCosMinCount()}</td>
			<td>${cosVO.getCosMaxCount()}</td>
			<td>${cosVO.getCosPrice()}</td>
			<td><fmt:formatDate value="${cosVO.getCosApplyFrom()}" pattern="yyyy-MM-dd HH:mm:ss.SSSZ"/></td>
			<td><fmt:formatDate value="${cosVO.getCosApplyTo()}" pattern="yyyy-MM-dd HH:mm:ss.SSSZ"/></td>
			<td>${cosVO.getCosName()}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" style="margin-bottom: 0px;" >
			     <input type="submit" value="報名">
			     <input type="hidden" name="cosNo"  value="${cosVO.getCosNo()}">
			     <input type="hidden" name="action"	value="update_cosStatus"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="cosNo"  value="${cosVO.getCosNo()}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
</table>

</body>
</html>