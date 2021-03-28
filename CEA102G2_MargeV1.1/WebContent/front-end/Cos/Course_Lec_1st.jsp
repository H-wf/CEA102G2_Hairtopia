<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cos.model.*, com.coudet.model.*, com.coudet.controller.*"%>

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <title>課程首頁</title>
 <meta charset="utf-8">
<%@include file="/front-end/tempFile/head" %>
 
</head>
<style>
.ftco-navbar-light{
	position:static;
}
#mytb{
	font-size:0.8rem;
}
#mytb td{
	height:30%;
}
#table-1 h4{
	color:black; font-family: "Open Sans", Arial, sans-serif;
}

/* .submitToWhite { */
/*         color:gray; */
/* } */
.btn-primary{
	color:white !important;
}
.btn-primary:hover{
	color:#d9bf77 !important;
}

</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">
</div>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<div class="container">
  <div class="row">
    <div class="col-6" style="background-image: url()">
        <input value="公告課程" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/listAllCospostfront.jsp';" type="button">
        <input value="所有課程" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/listAllCosfront.jsp';" type="button">
        <input value="查詢課程" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/select_cos_pagefront.jsp';" type="button">
        <input value="報名中課程" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/listAllCosApplyFromfront.jsp';" type="button">
        <c:if test="${not empty userSession}">
	    	<input value="查詢修課紀錄及評分" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/LoginToRateCos.jsp';" type="button">
        </c:if>
        </div>
        <div class="col-6" style="background-image: url()">	
    	
    </div>

  </div>
</div>
<hr/>
<div class="row">
      	<div class="col-4" align="center"> 
      	<div class="card" style="width: 18rem;">
			<img style="height: 250px;width: auto;object-fit:cover;background-position: 45% 15%;background-image: url(/CEA102G2_Merge/resource/images/hotGirl.jpg);">
  		<div class="card-body">
  		<div class="card-body">
    		<h5 class="card-title">所有課程</h5>
   			<p class="card-text">報名、開課及歷史課程</p>
    		<a onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/listAllCosfront.jsp';" class="btn btn-primary">點擊前往</a>
  		</div>
		</div>
		</div>
		</div>
  
  		<div class="col-4" align="center">  
		<div class="card" style="width: 18rem;">
			<img style="height: 250px;width: auto;object-fit:cover;background-position: 55% 30%;background-image: url(/CEA102G2_Merge/resource/images/hotGuy3.jpg);">
		<div class="card-body">
		<div class="card-body">
   			<h5 class="card-title">報名中課程</h5>
    		<p class="card-text">列出報名中課程</p>
    		<a onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/listAllCosApplyFromfront.jsp';" class="btn btn-primary">點擊前往</a>
  		</div>
		</div>
		</div>
		</div>
  		
  		<div class="col-4" align="center">  
		<div class="card" style="width: 18rem;">
			<img style="height: 250px;width: auto;object-fit:cover;background-position: 55% 55%;background-image: url(/CEA102G2_Merge/resource/images/hotGirl2.jpg);">
		<div class="card-body">
      	<div class="card-body">
    		<h5 class="card-title">查詢課程</h5>
    		<p class="card-text">查詢課程關鍵字</p>
    		<a onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/select_cos_pagefront.jsp';" class="btn btn-primary">點擊前往</a>
  		</div>
		</div>
		</div>
		</div>
  		
  		<div class="col-4" align="center">  
		<div class="card" style="width: 18rem;">
			<img style="height: 250px;width: auto;object-fit:cover;background-position: 55% 55%;background-image: url(/CEA102G2_Merge/resource/images/hotGuy4.jpg);">
		<div class="card-body">
  		<div class="card-body">
    		<h5 class="card-title">公告課程</h5>
    		<p class="card-text">查詢課程公告</p>
    		<a onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/listAllCospostfront.jsp';" class="btn btn-primary">點擊前往</a>
  		</div>
		</div>
		</div>
		</div>
  		
  		<div class="col-4" align="center">  
		<div class="card" style="width: 18rem;">
			<img style="height: 250px;width: auto;object-fit:cover;background-position: 90% 45%;background-image: url(/CEA102G2_Merge/resource/images/hotGirl4.jpg);">
		<div class="card-body">
      	<div class="card-body">
    		<h5 class="card-title">查詢修課紀錄及評分</h5>
    		<p class="card-text">查詢歷史修課及課後評分</p>
    		<a onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/LoginToRateCos.jsp';" class="btn btn-primary">點擊前往</a>
  		</div>
		</div>
		</div>
		</div>
		
		<div class="col-4" align="center">  
		<div class="card" style="width: 18rem;">
			<img style="height: 250px;width: auto;object-fit:cover;background-position: 90% 45%;background-image: url(/CEA102G2_Merge/resource/images/hotGirl5.jpg);">
		<div class="card-body">
      	<div class="card-body">
    		<h5 class="card-title">講師名單</h5>
    		<p class="card-text">查詢講師的個人資訊</p>
    		<a onclick="location.href='<%=request.getContextPath()%>/front-end/Lecturer/listAllLecturer.jsp';" class="btn btn-primary">點擊前往</a>
  		</div>
		</div>
		</div>
		</div>
</div>

<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>
</html>