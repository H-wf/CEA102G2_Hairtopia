<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Login</title>
<%@include file="/front-end/tempFile/head" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/login.css">

<!-- <link -->
<!-- 	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" -->
<!-- 	rel="stylesheet" -->
<!-- 	integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" -->
<!-- 	crossorigin="anonymous"> -->
<!-- <script -->
<!-- 	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" -->
<!-- 	integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" -->
<!-- 	crossorigin="anonymous"></script> -->
<!-- <script src="https://code.jquery.com/jquery-3.5.1.min.js" -->
<!-- 	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" -->
<!-- 	crossorigin="anonymous"></script> -->
</head>
<style type="text/css">
/* body, html { */
/* 	height: 100%; */
/* 	background-repeat: no-repeat; */
/* 	/*background-image: linear-gradient(rgb(255, 255, 255), rgb(12, 97, 33));*/ */
/* 	/*透明圖層*/ */
/* 	/*background-color: rgba(0, 0, 0, 0.5);*/ */
/* 	background-color: #FFF; */
/* } */

/* .card-container.card { */
/* 	max-width: 350px; */
/* 	padding: 30px 30px; */
/* } */

/* .btn { */
/* 	font-weight: 700; */
/* 	height: 36px; */
/* 	-moz-user-select: none; */
/* 	-webkit-user-select: none; */
/* 	user-select: none; */
/* 	cursor: default; */
/* } */

/* /* */
/*  * Card component */
/*  */ */
/* .card { */
/* 	background-color: #fff; */
/* 	/*just in case there no content*/ */
/* 	padding: 20px 25px 30px; */
/* 	margin: 0px auto 25px; */
/* 	margin-top: 30px; */
/* 	/* shadows and rounded borders */ */
/* 	-moz-border-radius: 2px; */
/* 	-webkit-border-radius: 2px; */
/* 	border-radius: 5px; */
/* 	-moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3); */
/* 	-webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3); */
/* 	box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3); */
/* } */

/* .profile-img-card { */
/* 	width: 50%; */
/* 	height: 50% px; */
/* 	margin: 0 auto 30px; */
/* 	display: block; */
/* 	-moz-border-radius: 50%; */
/* 	-webkit-border-radius: 50%; */
/* 	border-radius: 50%; */
/* } */

/* /* */
/*  * Form styles */
/*  */ */
/* .profile-name-card { */
/* 	font-size: 16px; */
/* 	font-weight: bold; */
/* 	text-align: center; */
/* 	margin: 10px 0 0; */
/* 	min-height: 1em; */
/* } */

/* .reauth-email { */
/* 	display: block; */
/* 	color: #404040; */
/* 	line-height: 2; */
/* 	margin-bottom: 10px; */
/* 	font-size: 14px; */
/* 	text-align: center; */
/* 	overflow: hidden; */
/* 	text-overflow: ellipsis; */
/* 	white-space: nowrap; */
/* 	-moz-box-sizing: border-box; */
/* 	-webkit-box-sizing: border-box; */
/* 	box-sizing: border-box; */
/* } */

/* .form-signin #inputEmail, .form-signin #inputPassword { */
/* 	direction: ltr; */
/* 	height: 44px; */
/* 	font-size: 16px; */
/* } */

/* .form-signin input[type=email], .form-signin input[type=password], */
/* 	.form-signin input[type=text], .form-signin button { */
/* 	width: 100%; */
/* 	display: block; */
/* 	margin-bottom: 10px; */
/* 	z-index: 1; */
/* 	position: relative; */
/* 	-moz-box-sizing: border-box; */
/* 	-webkit-box-sizing: border-box; */
/* 	box-sizing: border-box; */
/* } */

/* .form-signin .form-control:focus { */
/* 	border-color: rgb(104, 145, 162); */
/* 	outline: 0; */
/* 	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px */
/* 		rgb(104, 145, 162); */
/* 	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px */
/* 		rgb(104, 145, 162); */
/* } */

/* .btn.btn-signin { */
/* 	/*background-color: #4d90fe; */ */
/* 	background-color: rgb(104, 145, 162); */
/* 	/* background-color: linear-gradient(rgb(104, 145, 162), rgb(12, 97, 33));*/ */
/* 	padding: 0px; */
/* 	font-weight: 700; */
/* 	font-size: 14px; */
/* 	height: 36px; */
/* 	-moz-border-radius: 3px; */
/* 	-webkit-border-radius: 3px; */
/* 	border-radius: 3px; */
/* 	border: none; */
/* 	-o-transition: all 0.218s; */
/* 	-moz-transition: all 0.218s; */
/* 	-webkit-transition: all 0.218s; */
/* 	transition: all 0.218s; */
/* } */

/* .btn.btn-signin:hover, .btn.btn-signin:active, .btn.btn-signin:focus { */
/* 	background-color: rgb(12, 97, 33); */
/* } */
</style>


<body>
<%@include file="/front-end/tempFile/navBar" %>
<div style="height:12vh;"></div>
	<div class="container">
		<div class="card card-container">
			<img id="profile-img" class="profile-img-card" src="<%=request.getContextPath()%>/resource/images/HairtopiaLogo/HairtopiaLogoLogin.png" />
			<h2 align="center">忘記密碼</h2>
			<br>
			<h4 align="center">請儘速到信箱取信</h4>
			<br>
			<form method="post" class="form-signin" action="<%=request.getContextPath()%>/frontEnd/member/login.jsp">
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