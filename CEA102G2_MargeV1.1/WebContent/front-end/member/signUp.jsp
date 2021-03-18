<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Signup</title>
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
<script src="http://jqueryvalidation.org/files/dist/jquery.validate.min.js"></script>
<script src="http://jqueryvalidation.org/files/dist/additional-methods.min.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/member_signup.css">
</head>

<body>

<%-- <%-- 錯誤表列 --%>
<%-- <c:if test="${not empty errorMsgs}"> --%>
<!-- 	<font style="color:red">請修正以下錯誤:</font> -->
<!-- 	<ul> -->
<%-- 		<c:forEach var="message" items="${errorMsgs.entrySet()}"> --%>
<%-- 			<li style="color:red">${message.value}</li> --%>
<%-- 		</c:forEach> --%>
<!-- 	</ul> -->
<%-- </c:if> --%>

	<div class="container">
		<div class="card card-container">
			<img id="profile-img" class="profile-img-card"
				src="<%=request.getContextPath()%>/resource/images/HairtopiaLogo/HairtopiaLogo1.png" />
			<h2 align="center">加入會員</h2>
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
</body>

</html>