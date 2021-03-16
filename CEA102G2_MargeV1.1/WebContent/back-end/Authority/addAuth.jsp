<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.authority.model.*"%>

<%
	AuthorityVO authVO = (AuthorityVO) request.getAttribute("authVO");
%>
<!DOCTYPE html>
<html>
<head>

<title>add Authority </title>
</head>
<body>
<%-- 	        ${authSvc.getFuncNo(staVO.staNo)}  = list --%>
<!-- 			funcSvc.getOneFunc(authVO.funcNo).funcName -->
<table id="table-1">
		<tr>
			<td>
				<h3>新增單筆權限 - addAuthority.jsp</h3>
			</td>
			<td>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Authority/select_auth_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/tomcat.png"
						width="100" height="100" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>		
			<h3>新增單筆權限:</h3>
			
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/authority/authority.do" name="form1" enctype="application/x-www-form-urlencoded">
		<table>	
			<jsp:useBean id="staSvc" scope="page" class="com.staff.model.StaffService" />
			<tr>
				<td>員工名稱:<font color=red><b>*</b></font></td>
				<td><select size="1" name="staNo">
			<c:forEach var="staVO" items="${staSvc.all}">
				<option value="${staVO.staNo}">${staVO.staName}
			</c:forEach>
		</select></td>
	</tr>
			
			<jsp:useBean id="funcSvc" scope="page" class="com.func.model.FuncService" />
			<tr>
				<td>功能名稱:<font color=red><b>*</b></font></td>
				<td><select size="1" name="funcNo">
			<c:forEach var="funcVO" items="${funcSvc.all}">
				<option value="${funcVO.funcNo}" >${funcVO.funcName}
			</c:forEach>
		</select></td>
	</tr>
		</table>
		<br> 
		<input name="action" value="insert" type="hidden" >
		<input type="submit" value="新增" >
		
	</form>
			

			
			
</body>
</html>