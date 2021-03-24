<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Signup</title>
<%@include file="/front-end/tempFile/head" %>

<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/login.css">
</head>

<body>
<%@include file="/front-end/tempFile/navBar" %>
<div style="height:10vh;"></div>
	<div class="container">
		<div class="card card-container">
		<a href='<%=request.getContextPath()%>/front-end/index.jsp'>
			<img id="profile-img" class="profile-img-card" src="<%=request.getContextPath()%>/resource/images/HairtopiaLogo/HairtopiaLogoSignUp.png" />
			</a>
			<form id="myform" method="post" class="form-signin" action="<%=request.getContextPath()%>/member/mem.do">
				<span id="reauth-email" class="reauth-email"></span> 
				<input type="text" id="memName" class="form-control" placeholder="姓名" required autofocus autocomplete="off" name="memName" value="${param.memName}">
				<span id="memNameMessage" style="color:red">&nbsp;${errorMsgs.memName}</span> 
				
				<input type="email" id="memEmail" class="form-control" placeholder="電子郵件地址" required autocomplete="off" name="memEmail" value="${param.memEmail}"> 
				<span id="memEmailMessage" style="color:red">&nbsp;${errorMsgs.memEmail}${errorMsgs.emailExist}</span> 
				
				<input type="password" id="memPswd" class="form-control" placeholder="密碼" required autocomplete="off" name="memPswd"> 
				<span id="memPswdMessage" style="color:red"> &nbsp;${errorMsgs.memPswd}</span> 
				
				<input type="password" id="comfirmPswd" class="form-control" placeholder="確認密碼" required autocomplete="off" name="comfirmPswd">
				<span id="memPswdMessage" style="color:red"> &nbsp;${errorMsgs.Exception}</span> 
				
				<input type="hidden" name="action" value="signUp">
				<br>
				<button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">送出</button>

			</form>

		</div>

	</div>
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
<script src="<%=request.getContextPath()%>/dist/js/jquery-3.5.1.min.js"></script>
<script src="<%=request.getContextPath()%>/dist/js/jquery.validate.min.js"></script>
<script src="<%=request.getContextPath()%>/dist/js/additional-methods.min.js"></script>
</body>
	<script>
	jQuery.validator.setDefaults({
		  debug: false,
		  success: "valid"
		  
		});
	
	
	
	
	$( "#myform" ).validate({
		errorClass: "errorMessage",
		errorElement: "span",
		rules: {
			memPswd: "required",
			comfirmPswd: {
		    	equalTo: "#memPswd"
		    }
		  }
		
	});
	</script>
	
	<script>
	jQuery.extend(jQuery.validator.messages, {
		required: "必填欄位",
		remote: "請修正該欄位",
		email: "請輸入正確格式的電子郵件",
		url: "請輸入合法的網址",
		date: "請輸入合法的日期",
		dateISO: "請輸入合法的日期 (ISO).",
		number: "請輸入合法的數字",
		digits: "只能輸入整數",
		creditcard: "請輸入合法的信用卡號",
		equalTo: "請再次輸入相同的值",
		accept: "請輸入擁有合法字尾名的字串",
		maxlength: jQuery.validator.format("請輸入一個 長度最多是 {0} 的字串"),
		minlength: jQuery.validator.format("請輸入一個 長度最少是 {0} 的字串"),
		rangelength: jQuery.validator.format("請輸入 一個長度介於 {0} 和 {1} 之間的字串"),
		range: jQuery.validator.format("請輸入一個介於 {0} 和 {1} 之間的值"),
		max: jQuery.validator.format("請輸入一個最大為{0} 的值"),
		min: jQuery.validator.format("請輸入一個最小為{0} 的值")
		});
	
		
	</script>

</html>