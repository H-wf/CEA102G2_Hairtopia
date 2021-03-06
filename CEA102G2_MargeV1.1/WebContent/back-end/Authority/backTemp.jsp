<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.authority.model.*"%>
<%@ page import="com.staff.model.*"%>

<%
	StaffVO staVO = (StaffVO) request.getAttribute("staVO");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>SB Admin 2 - Blank</title>
    <meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>

<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">
	<div class="row">
			
					<h3>新增多筆權限:</h3>
					<%-- 錯誤表列 --%>
					<c:if test="${not empty errorMsgs}">
						<font style="color: red">請修正以下錯誤:</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color: red">${message}</li>
							</c:forEach>
						</ul>
					</c:if>
	
			<form METHOD="POST" ACTION="<%=request.getContextPath()%>/authority/authority.do" id="form1" 
			name="form1" enctype="application/x-www-form-urlencoded">
			<table class=".border-left-warning">
				<tr>
				<td>員工姓名:</td>
				<td><input type="TEXT" name="staName" size="45" required
					value="<%= (staVO == null) ? "" : staVO.getStaName()%>" /></td>
					
			</tr>
			<tr>
				<td>員工帳號:</td>
				<td><input type="email" name="staAcct" size="45" required
					value="<%= (staVO == null) ? "" : staVO.getStaAcct()%>" /></td>
					
			</tr>
			
			<jsp:useBean id="funcSvc" scope="page" class="com.func.model.FuncService" />
			<tr>
			
				<td>功能名稱:<font color=red><b>*</b></font></td>
			<td>	
			<c:forEach var="funcVO" items="${funcSvc.all}" >
				 <input type="checkbox"  id="ckBox" name="funcNo" value="${funcVO.funcNo}">
  					${funcVO.funcName}<br>

			</c:forEach>
			</td>
		</tr>
		</table>
		<br> 
		<input name="action" value="insertMuti" type="hidden" >
		<input  class="btn btn-primary" type="submit" value="新增"  >
		 
	</form>
	</div>
</div>
<!-- Page Content END -->
                
<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>
</body>

</html>