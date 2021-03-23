<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>

<!-- <script -->
<!-- 	src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.15.5/sweetalert2.min.js"></script> -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.15.5/sweetalert2.min.css"> -->
<title>Login</title>
<style type="text/css">
body, html {
	height: 100%;
	background-repeat: no-repeat;
	/*background-image: linear-gradient(rgb(255, 255, 255), rgb(12, 97, 33));*/
	/*透明圖層*/
	/*background-color: rgba(0, 0, 0, 0.5);*/
	/* 	background-color: #FFF; */
}

.card-container.card {
	max-width: 350px;
	padding: 30px 30px;
}

.btn {
	font-weight: 700;
	height: 36px;
	-moz-user-select: none;
	-webkit-user-select: none;
	user-select: none;
	cursor: default;
}

/*
 * Card component
 */
.card {
	/* 	background-color: #fff; */
	/*just in case there no content*/
	padding: 20px 25px 30px;
	margin: 0px auto 25px;
	margin-top: 30px;
	/* shadows and rounded borders */
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	border-radius: 5px;
	-moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
	-webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
	box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
}

.profile-img-card {
	width: 50%;
	height: 50%	;
	margin: 0 auto 30px;
	display: block;
	-moz-border-radius: 50%;
	-webkit-border-radius: 50%;
	border-radius: 50%;
}

/*
 * Form styles
 */
.profile-name-card {
	font-size: 16px;
	font-weight: bold;
	text-align: center;
	margin: 10px 0 0;
	min-height: 1em;
}

.reauth-email {
	display: block;
	color: #404040;
	line-height: 2;
	margin-bottom: 10px;
	font-size: 14px;
	text-align: center;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
}

.form-signin #inputEmail, .form-signin #inputPassword {
	direction: ltr;
	height: 44px;
	font-size: 16px;
}

.form-signin input[type=email], .form-signin input[type=password],
	.form-signin input[type=text], .form-signin button {
	width: 100%;
	display: block;
	margin-bottom: 10px;
	z-index: 1;
	position: relative;
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
}

.form-signin .form-control:focus {
	border-color: rgb(104, 145, 162);
	outline: 0;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px
		rgb(104, 145, 162);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px
		rgb(104, 145, 162);
}

.btn.btn-signin {
	/*background-color: #4d90fe; */
	background-color: rgb(104, 145, 162);
	/* background-color: linear-gradient(rgb(104, 145, 162), rgb(12, 97, 33));*/
	padding: 0px;
	font-weight: 700;
	font-size: 14px;
	height: 36px;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	border-radius: 3px;
	border: none;
	-o-transition: all 0.218s;
	-moz-transition: all 0.218s;
	-webkit-transition: all 0.218s;
	transition: all 0.218s;
}

.btn.btn-signin:hover, .btn.btn-signin:active, .btn.btn-signin:focus {
	background-color: rgb(12, 97, 33);
}

.forgot-password {
	color: rgb(104, 145, 162);
}

.forgot-password:hover, .forgot-password:active, .forgot-password:focus
	{
	color: rgb(12, 97, 33);
}

.login-or {
	position: relative;
	color: #aaa;
/* 	margin-top: 10px;   */
	margin-bottom: 10px;
	padding-top: 10px;
	padding-bottom: 10px;
}

.span-or {
	display: block;
	position: absolute;
	left: 50%;
	top: -2px;
	margin-left: -25px;
	background-color: #fff;
	width: 50px;
	text-align: center;
}

.hr-or {
	height: 1px;
	margin-top: 0px !important;
	margin-bottom: 0px !important;
}
</style>
</head>

<body>

<%-- 	<c:if test="${not empty errorMsgs}"> --%>
<!-- 		<script> -->
<!-- // 			alert("asd") -->
<!-- 		</script> -->
<%-- 	</c:if> --%>

	<!--
    you can substitue the span of reauth email for a input with the email and
    include the remember me checkbox
    -->
	<div class="container">
		<div class="card card-container">
		<a href='<%=request.getContextPath()%>/front-end/index.jsp'>
			<img id="profile-img" class="profile-img-card"
				src="<%=request.getContextPath()%>/resource/images/HairtopiaLogo/HairtopiaLogo1.png" />
			</a>
			<h2 align="center"	>登入</h2>
			<!--             <p id="profile-name" class="profile-name-card"></p> -->
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
				
				
				
				<input type="hidden" name="action" value="login">
				<!--                 <div id="remember" class="checkbox"> -->
				<!--                     <label> -->
				<!--                         <input type="checkbox" value="remember-me"> 記住我 -->
				<!--                     </label> -->
				<!--                 </div> -->
				<!-- for sign in -->
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
			<a
				href="<%=request.getContextPath()%>/front-end/member/forgetPassword.jsp"
				class="forgot-password"> 忘記密碼? </a>
		</div>
		<!-- /card-container -->
	</div>
	<!-- /container -->
</body>

</html>