<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cos.model.*, com.coudet.model.*, com.coudet.controller.*"%>

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <title>課程前台首頁</title>
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

.submitToWhite {
        color:gray;
   }

</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table id="table-1">
	<tr><td>
		 <h4>回課程前台</h4>
		 <li><a href="<%=request.getContextPath()%>/front-end/Cos/Course_Lec_1st.jsp">回課程前台</a></li>
	</td></tr>
</table>

<div class="container">
  <div class="row">
    <div class="col-6" style="background-image: url(https://tpc.googlesyndication.com/daca_images/simgad/9369106744739753097?w=400&h=209)">
        <input value="所有課程" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/listAllCosfront.jsp';" type="button">
        <input value="可報名課程" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/listAllCosApplyFromfront.jsp';" type="button">
        <input value="課程查詢" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/select_cos_pagefront.jsp';" type="button">
        </div>
        <div class="col-6" style="background-image: url(https://tpc.googlesyndication.com/daca_images/simgad/9369106744739753097?w=400&h=209)">	
    	<input value="課程公告" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/listAllCospostfront.jsp';" type="button">
    	<input value="修課紀錄及評分" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/LoginToRateCos.jsp';" type="button">
    </div>

  </div>
  <hr/>
  <div class="row">
      	<div class="col-4" align="center"> 
      	 <div class="card" style="width: 18rem;">
  <image style= "height:200px; background-image: url(https://tpc.googlesyndication.com/daca_images/simgad/9369106744739753097?w=400&h=209)">

  <div class="card-body">
    <h5 class="card-title">所有課程</h5>
    <p class="card-text">列出所有課程，包括開課中、報名中、歷史課程</p>
    <a onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/listAllCosfront.jsp';" class="btn btn-primary">點擊前往</a>
  </div>
</div>
  		</div>
  
  		<div class="col-4" align="center">  
<div class="card" style="width: 18rem;">
  <image style= "height:200px; background-image: url(https://tpc.googlesyndication.com/daca_images/simgad/9369106744739753097?w=400&h=209)">
  <div class="card-body">
    <h5 class="card-title">可報名課程</h5>
    <p class="card-text">列出報名中課程</p>
    <a onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/listAllCosApplyFromfront.jsp';" class="btn btn-primary">點擊前往</a>
  </div>
</div>
  		</div>
  		
  		<div class="col-4" align="center">  
<div class="card" style="width: 18rem;">
  <image style= "height:200px; background-image: url(https://tpc.googlesyndication.com/daca_images/simgad/9369106744739753097?w=400&h=209)">
  <div class="card-body">
    <h5 class="card-title">課程查詢</h5>
    <p class="card-text">複合查詢想要的課程</p>
    <a onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/select_cos_pagefront.jsp';" class="btn btn-primary">點擊前往</a>
  </div>
</div>
  		</div>
  		
  		<div class="col-4" align="center">  
<div class="card" style="width: 18rem;">
  <image style= "height:200px; background-image: url(https://tpc.googlesyndication.com/daca_images/simgad/9369106744739753097?w=400&h=209)">
  <div class="card-body">
    <h5 class="card-title">課程公告</h5>
    <p class="card-text">查詢課程公告</p>
    <a onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/listAllCospostfront.jsp';" class="btn btn-primary">點擊前往</a>
  </div>
</div>
  		</div>
  		
  		<div class="col-4" align="center">  
<div class="card" style="width: 18rem;">
  <image style= "height:200px; background-image: url(https://tpc.googlesyndication.com/daca_images/simgad/9369106744739753097?w=400&h=209)">
  <div class="card-body">
    <h5 class="card-title">修課紀錄及評分</h5>
    <p class="card-text">查詢歷史修課紀錄並評分</p>
    <a onclick="location.href='<%=request.getContextPath()%>/front-end/Cos/LoginToRateCos.jsp';" class="btn btn-primary">點擊前往</a>
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