<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.authority.model.*"%>


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
<title>所有功能資料 - listAll_authByFunc.jsp</title>
</head>
<body>
	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有功能資料 - listAll_authByFunc.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Authority/select_auth_page.jsp">
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
	<h2>功能名稱</h2>
	<jsp:useBean id="funcSvc" scope="page" class="com.func.model.FuncService" />
	<p> ${funcSvc.getOneFunc(param.funcNo).funcName}
	<table>
		<tr>
			<th>員工編號</th>
			<th>員工名稱</th>
		</tr>
	
		
	<jsp:useBean id="staSvc" scope="page" class="com.staff.model.StaffService" />
		<c:forEach var="authVO" items="${list}">
			<tr>
				<td>${authVO.staNo}</td>
				<td>${staSvc.getOneStaff(authVO.staNo).staName}</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/authority/authority.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> 
						<input type="hidden" name="funcNo" value="${authVO.funcNo}"> 
						<input type="hidden" name="staNo" value="${authVO.staNo}">
						<input type="hidden" name="action" value="listAll_authByFunc">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>