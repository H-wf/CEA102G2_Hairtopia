<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>重發驗證</title>
<meta charset="utf-8">
 <%@include file="/front-end/tempFile/head" %>
 <link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/login.css">
 <script src="<%=request.getContextPath()%>/dist/js/jquery-3.5.1.min.js"></script>
</head>

<body>
	<%@include file="/front-end/tempFile/navBar" %>
	<div style="height:12vh;"></div>
	<div class="container-fluid px-0">
		<div class="card card-container">
		<a href='<%=request.getContextPath()%>/front-end/index.jsp'>
			<img id="profile-img" class="profile-img-card" src="<%=request.getContextPath()%>/resource/images/HairtopiaLogo/HairtopiaLogoSignUp.png" />
		</a>
			<h2 align="center">驗證信送出</h2>
			<br>
			<h4 align="center">請至電子信箱(${param.memEmail})點選驗證信</h4>
			<br>
			<form method="post" class="form-signin" action="<%=request.getContextPath()%>/member/mem.do">
<!-- 				<span id="reauth-email" class="reauth-email"></span>  -->
				<input type="hidden" name="memEmail" value="${param.memEmail}"> 
				<input type="hidden" name="action" value="SendAuthCode"> 

<%-- 				<c:if test="${not empty errorMsgs}"> --%>
<%-- 						<c:forEach var="message" items="${errorMsgs}"> --%>
<!-- 							<script>$(".form-control").css("border-color","red")</script> -->
<%-- 							<span style="color:red">${message}</span> --%>
<%-- 						</c:forEach> --%>
<%-- 				</c:if> --%>
<!-- 				<br> -->
				<button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">重發驗證碼</button>
			</form>

		</div>

	</div>
	<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
<script src="<%=request.getContextPath()%>/dist/js/jquery.validate.min.js"></script>
<script src="<%=request.getContextPath()%>/dist/js/additional-methods.min.js"></script>
</body>


</html>