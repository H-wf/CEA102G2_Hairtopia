<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.schedule.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%-- 此頁練習採用 EL 的寫法取值 --%>




<!DOCTYPE html>
<html>
<head>
<style type="text/css">
img {
	width: 150px;
}
</style>
<meta charset="UTF-8">
<title>設計師班表資料 - listAll_schedule.jsp</title>
</head>
<body>
	
	<table id="table-1">
		<tr>
			<td>
				<h3>設計師班表資料 - listAll_schedule.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/front-end/Schedule/select_schedule_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>


	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>


	<table>
		<tr><th >設計師編號</th><td>${param.desNo}</td></tr>
		<tr><th >設計師班表</th></tr>
	</table>
	<table border="1" cellpadding="5" style="border:2px #666 solid;text-align:center;">
		<tr><th >Date</th>
		<c:forEach var="myData" begin="0" end="47">
		<th><fmt:formatNumber type="number" value="${((myData*30 -(myData*30%60)))/60}"  var="num"/>
				${num}:${(myData*30 %60 == 0)? "00" :"30" }</th>
		</c:forEach><td>功能</td>
		</tr>
		<c:forEach var="schVO" items="${list}">
		<tr>
			<th>${schVO.schDate}</th>
		
		<c:set var="status" value="${schVO.schStatus}"/>
		<c:forEach var="myData" begin="0" end="47">
			<c:choose>
			<c:when test= '${status.charAt(myData).toString().equals("1")}'>
					<td>free</td>
			 </c:when>
			 <c:when test= '${status.charAt(myData).toString().equals("2")}'>
			 		<td>busy</td>
			 </c:when>
			 <c:otherwise>
			 		<td>未上班</td>
			 </c:otherwise>
			 	
			</c:choose>
					
			</c:forEach>
			<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/schedule/schedule.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> 
						<input type="hidden" name="schNo" value="${schVO.schNo}"> 
						<input type="hidden" name="desNo" value="${schVO.desNo}"> 
						<input type="hidden" name="action" value="delete">
					</FORM>
				</td>
		</tr>
		</c:forEach>


	</table>


</body>
</html>