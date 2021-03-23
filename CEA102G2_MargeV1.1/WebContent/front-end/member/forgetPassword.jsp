<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>forgetPassword</title>
<%@include file="/front-end/tempFile/head" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/login.css">
</head>
<style>
</style>

<body>
<%@include file="/front-end/tempFile/navBar" %>
<div style="height:12vh;"></div>
	<div class="container">
		<div class="card card-container">
			<img id="profile-img" class="profile-img-card" src="<%=request.getContextPath()%>/resource/images/HairtopiaLogo/HairtopiaLogoLogin.png" />
			<h2 align="center">忘記密碼</h2>
			<br>
			<form method="post" class="form-signin" action="<%=request.getContextPath()%>/member/mem.do">
				<span id="reauth-email" class="reauth-email"></span> 
				<input type="email" id="inputEmail" class="form-control" placeholder="電子郵件地址" required autofocus autocomplete="off" name="account"> 
				<input type="hidden" name="action" value="forgetPassword"> 

				<c:if test="${not empty errorMsgs}">
						<c:forEach var="message" items="${errorMsgs}">
							<script>$(".form-control").css("border-color","red")</script>
							<span style="color:red">${message}</span>
						</c:forEach>
				</c:if>
				<br>
				<button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">送出</button>
			</form>

		</div>

	</div>
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
<script src="<%=request.getContextPath()%>/dist/js/jquery-3.5.1.min.js"></script>
<script src="<%=request.getContextPath()%>/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>