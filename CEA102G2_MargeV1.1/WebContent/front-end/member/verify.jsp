<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>驗證結果</title>
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
			<h2 align="center">帳號驗證</h2>
			<br>
			<c:if test="${not empty errorMsgs}">
				<c:forEach var="message" items="${errorMsgs}">
					<h4 align="center" style="color:red">${message}</h4>
				</c:forEach>
				<script>
					if(${not empty errorMsgs}){console.log(123);}
					$('#successVerify').hide();
// 					console.log($('#successVerify'));
// 					console.log($('#failureVerify'));
					$('#failureVerify').show();				
				</script>	
			</c:if>
			<c:if test="${empty errorMsgs}">
				<h4 align="center">成功</h4>		
			</c:if>
			
			<br>
				<button id="successVerify" class="btn btn-lg btn-primary btn-block btn-signin" 
					onclick="location='<%=request.getContextPath()%>/front-end/member/login.jsp'">返回登入頁
				</button>
				<button id="failureVerify" class="btn btn-lg btn-primary btn-block btn-signin" 
					onclick="location='<%=request.getContextPath()%>/front-end/member/unverified.jsp?memEmail=${param.memEmail}'">重寄驗證信
				</button>
				


		</div>

	</div>
	
			<script>
					if(${empty errorMsgs}){
						$('#failureVerify').hide();	
					}else{
						$('#successVerify').hide();
					}
			</script>	
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
<script src="<%=request.getContextPath()%>/dist/js/jquery.validate.min.js"></script>
<script src="<%=request.getContextPath()%>/dist/js/additional-methods.min.js"></script>
</body>

</html>