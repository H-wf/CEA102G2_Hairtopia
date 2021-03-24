 <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.staff.model.*"%>

<%
	StaffVO staVO = (StaffVO) request.getAttribute("staVO");
%>
<html>
<head>
<meta charset="UTF-8">
<title>講師資料修改 - update_sta_input.jsp</title>



</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>員工資料修改 - update_sta_input.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/Staff/select_sta_page.jsp">
						<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁
					</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料修改:</h3>


	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<form METHOD="POST"
		ACTION="<%=request.getContextPath()%>/staff/staff.do" name="form1"
		enctype="application/x-www-form-urlencoded">
		<table>
			<tr>
				<td>員工編號:<font color=red><b>*</b></font></td>
				<td>${staVO.staNo}</td>
			</tr>
			<tr>
				<td>員工姓名:</td>
				<td>${staVO.staName}</td>
			</tr>
			<tr>
				<td>員工帳號:</td>
				<td>${staVO.staAcct}</td>
			</tr>
			<tr>
				<td>請輸入舊密碼</td>
				<td><input type="password" name="staPswd" required="true"
					size="45"   /></td>
			</tr>
			<tr>
				<td>請輸入新密碼</td>
				<td><input type="password" class="newPswd" name="staPswd2" required="true"
					size="45" value=""  /></td>
			</tr>
			
			<tr>
				<td>請再次輸入新密碼</td>
				<td><input type="password" class="newPswd" required="true"
					size="45" value=""  /></td>
			</tr>


		</table>


		<br> 
			<input type="hidden" name="action" value="update"> 
			<input type="hidden" name="staNo" value="${staVO.staNo}"> 
			<input type="hidden" name="staName" value="${staVO.staName}"> 
			<input type="hidden" name="staAcct" value="${staVO.staAcct}"> 
			<input	type="submit" id="submit" class="login_btn" value="送出修改">

	</form>

	<script>
		var form = document.forms[0], 
		    submit = document.querySelector(".login_btn"), 
		    newPswd = document.getElementsByClassName("newPswd");
		
		form.onsubmit = function() {
			if (newPswd[0].value != newPswd[1].value) {
				alert("兩次密碼輸入不匹配，請更正！");
				return false;
			}
		}
	</script>




</body>
</html>