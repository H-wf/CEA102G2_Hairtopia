<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Login</title>
<%@include file="/front-end/tempFile/head" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/login.css">

</head>
<style type="text/css">
</style>


<body>
<%@include file="/front-end/tempFile/navBar" %>
<div style="height:12vh;"></div>
	<div class="container">
		<div class="card card-container">
		<a href='<%=request.getContextPath()%>/front-end/index.jsp'>
			<img id="profile-img" class="profile-img-card" src="<%=request.getContextPath()%>/resource/images/HairtopiaLogo/HairtopiaLogoLogin.png" />
		</a>	
			<h2 align="center">忘記密碼</h2>
			<br>
			<h4 align="center">請儘速到信箱取信</h4>
			<br>
			<form method="post" class="form-signin" action="<%=request.getContextPath()%>/front-end/member/login.jsp">
				<button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">回登入畫面</button>
			</form>
		</div>
	</div>
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
<script src="<%=request.getContextPath()%>/dist/js/jquery-3.5.1.min.js"></script>
<script src="<%=request.getContextPath()%>/dist/js/bootstrap.bundle.min.js"></script>
	
</body>

</html>