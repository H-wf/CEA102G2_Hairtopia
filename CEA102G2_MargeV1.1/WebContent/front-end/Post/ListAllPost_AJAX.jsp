<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>
<%@ page import="com.member.model.*"%>

<jsp:useBean id="postSvc"  scope="page" class="com.post.model.PostService" />

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <title>Hairtopia</title>
 <meta charset="utf-8">
<%@include file="/front-end/tempFile/head" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/post.css">
 
</head>
<style>
 #headImg{ 
 height: 40vh;
    background-image: url(forHeadBG2.jpg);
    background-repeat: no-repeat;
    background-position: 50% 34%;
    background-size: 100%;
 } 
</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid px-0">
	<!-- carousel -->
	<div id="headImg">
	</div>
	<nav aria-label="breadcrumb">
	  <ol class="breadcrumb">
	    <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/front-end/index.jsp">首頁</a></li>
	    <li class="breadcrumb-item active" aria-current="page">風格貼文</li>
	  </ol>
	</nav>
    <h1></h1>
	<div class="container post my-5">
		<div class="card-columns ">
		<c:forEach  var="postVO" items="${postSvc.all}">
				<div class="card onePost" id="${postVO.postNo}">
					<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}"
					 class="card-img-top post-img" />
				</div>
		</c:forEach>
		</div>
	</div>
</div>
<!-- Page Content END -->

<%@include file="/front-end/Post/postModal" %>
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
<script src="<%=request.getContextPath()%>/resource/js/postModal.js"></script>
</body>
<c:if test="${not empty wholePostMap}">
	<script>
			var wholePostMap = '${wholePostMap}';
	</script>
</c:if>
</html>