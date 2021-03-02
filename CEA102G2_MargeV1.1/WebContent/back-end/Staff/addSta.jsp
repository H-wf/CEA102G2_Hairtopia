<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.staff.model.*"%>

<%
	StaffVO staVO = (StaffVO) request.getAttribute("staVO");
%>
<!DOCTYPE html>
<html>
<head>

<title>講師資料新增 - addSta.jsp</title>
</head>

<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>講師資料新增 - addLec.jsp</h3>
			</td>
			<td>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Staff/select_sta_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images//tomcat.png"
						width="100" height="100" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>
	<h3>資料新增:</h3>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	

	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/staff/staff.do" name="form1" enctype="application/x-www-form-urlencoded">
		<table>
			<tr>
				<td>員工姓名:</td>
				<td><input type="TEXT" name="staName" size="45"
					value="<%= (staVO == null) ? "" : staVO.getStaName()%>" /></td>
					
			</tr>
			<tr>
				<td>員工帳號:</td>
				<td><input type="TEXT" name="staAcct" size="45"
					value="<%= (staVO == null) ? "" : staVO.getStaAcct()%>" /></td>
					
			</tr>

			<tr>
				<td>員工密碼:</td>
				<td><input type="password" name="staPswd" size="45"
					value="<%= (staVO == null) ? "" : staVO.getStaPswd()%>" /></td>
			</tr>
			
			<tr>
				<td>再次輸入密碼:</td>
				<td><input type="password" name="staPswd1" size="45" required="true"
					value="<%= (staVO == null) ? "" : staVO.getStaPswd()%>" /></td>
			</tr>

	
	

		</table>
	
	
		<br> 
		<input name="action" value="insert" type="hidden" >
		<input type="submit" value="新增" class="login_btn">
		
	</form>
	
	<script>
		var form = document.forms[0], 
		    submit = document.querySelector(".login_btn"), 
		    inputBtn = document.getElementsByTagName("input");
		
		form.onsubmit = function() {
			if (inputBtn[2].value != inputBtn[3].value) {
				alert("兩次密碼輸入不匹配，請更正");
				return false;
			}
		}
	</script>
	


</body>
</html>