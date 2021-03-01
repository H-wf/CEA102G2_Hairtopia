<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>



<title>Authority :Home</title>
<style>
table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
	border: 3px ridge Gray;
	height: 80px;
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
</head>

<body bgcolor='white'>
	<table id="table-1">
		<tr><td><h3>Hairtopia Authority: Home</h3><h4>( MVC )</h4></td></tr>
	</table>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	
	<h3>權限管理</h3>

	<ul>
		<li><a href='addAuth.jsp'>Add</a> 新增單一權限</li>
		<li><a href='addAuthMuti.jsp'>Add</a>重新修改權限</li>
	</ul>
		<jsp:useBean id="authSvc" scope="page" class="com.authority.model.AuthorityService" />
		<jsp:useBean id="staSvc" scope="page" class="com.staff.model.StaffService" />
		<jsp:useBean id="funcSvc" scope="page" class="com.func.model.FuncService" />
		
<form METHOD="POST" ACTION="<%=request.getContextPath()%>/authority/authority.do" name="form1" enctype="application/x-www-form-urlencoded">
	<table>
	<tr>
		<td>查詢員工權限(修改):<font color=red><b>*</b></font></td>
		<td><select size="1" name="staNo">
			<c:forEach var="staVO" items="${staSvc.all}">
				<option value="${staVO.staNo}" ${(authVO.staNo==staVO.staNo)? 'selected':'' } >${staVO.staName}
			</c:forEach>
		</select></td>
	</tr>
	</table>
	
	<input type="hidden" name="action" value="queryByStaNo">
	<input type="submit" value="送出查詢">
</form>	

<form METHOD="POST" ACTION="<%=request.getContextPath()%>/authority/authority.do" name="form1" enctype="application/x-www-form-urlencoded">
	<table>
	<tr>
		<td>查詢功能列表:<font color=red><b>*</b></font></td>
		<td><select size="1" name="funcNo">
			<c:forEach var="funcVO" items="${funcSvc.all}">
				<option value="${funcVO.funcNo}" ${(authVO.funcNo==funcVO.funcNo)? 'selected':'' } >${funcVO.funcName}
			</c:forEach>
		</select></td>
	</tr>
	</table>
	
	<input type="hidden" name="action" value="queryByFuncNo">
	<input type="submit" value="送出查詢">
</form>	
	

</body>
</html>