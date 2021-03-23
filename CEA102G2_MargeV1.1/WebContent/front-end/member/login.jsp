<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
 <title>Login</title>
 <meta charset="utf-8">
 <%@include file="/front-end/tempFile/head" %>
 <link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/login.css">
</head>
<style>

</style>


<body>
<%@include file="/front-end/tempFile/navBar" %>
<div style="height:12vh;"></div>
	<div class="container-fluid px-0">
		<div class="card card-container">
		<a href='<%=request.getContextPath()%>/front-end/index.jsp'>
			<img id="profile-img" class="profile-img-card" src="<%=request.getContextPath()%>/resource/images/HairtopiaLogo/HairtopiaLogoLogin.png" />
			</a>
			<form method="post" class="form-signin"
				action="<%=request.getContextPath()%>/member/mem.do">
				<span id="reauth-email" class="reauth-email"></span> 
				<input type="email" id="inputEmail" class="form-control" placeholder="電子郵件地址" required autofocus autocomplete="off"
					name="memEmail">
				<input type="password" id="inputPassword" class="form-control" placeholder="密碼" required autocomplete="off"
					name="password"> 
				<span id="memPswdMessage" style="color:red"> &nbsp;${errorMsgs}</span> 	
					
<%-- 				<c:if test="${not empty errorMsgs}"> --%>
<%-- 						<c:forEach var="message" items="${errorMsgs}"> --%>
<!-- 							<script>$(".form-control").css("border-color","red")</script> -->
<%-- 							<span style="color:red">${message}</span> --%>
<%-- 						</c:forEach> --%>
<%-- 				</c:if> --%>
				
				
				
				<a href="<%=request.getContextPath()%>/front-end/member/forgetPassword.jsp" class="forgot-password"> 忘記密碼? </a>
				<input type="hidden" name="action" value="login">
				<button class="btn btn-lg btn-primary btn-block btn-signin"
					type="submit">登入</button>
				<!-- for sign up -->
			</form>
			<!-- /form -->

			<div class="col-md-12 ">
				<div class="login-or">
					<hr class="hr-or">
					<span class="span-or">or</span>
				</div>
			</div>

			<button onclick="location.href='<%=request.getContextPath()%>/front-end/member/signUp.jsp'"
				class="btn btn-lg btn-primary btn-block btn-signin">註冊</button>
			
		</div>
		<!-- /card-container -->
	</div>
	<!-- /container -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>

</html>