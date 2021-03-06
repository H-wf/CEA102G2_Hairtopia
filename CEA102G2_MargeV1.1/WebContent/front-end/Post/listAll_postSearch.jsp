<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>
<%@ page import="com.member.model.*"%>

<%
	List<PostVO> postList = (ArrayList<PostVO>) request.getAttribute("postList");
	request.setAttribute("postList", postList);
%>


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
    background-image: url(<%=request.getContextPath()%>/front-end/Post/forHeadBG2.jpg);
    background-repeat: no-repeat;
    background-position: 50% 34%;
    background-size: 100%;
 } 
</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid px-0">
	
	<div id="headImg">
	</div>
	<nav aria-label="breadcrumb">
	  <ol class="breadcrumb">
	    <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/front-end/index.jsp">首頁</a></li>
	    <li class="breadcrumb-item active" aria-current="page">搜尋貼文　' ${keyword} '</li>
	  </ol>
	</nav>
	<div class="container post my-5">
		<div class="card-columns ">
		<c:forEach  var="postVO" items="${postList}">
			<c:if test="${postVO.postStatus eq 0}">
				<div class="card onePost" PostId="${postVO.postNo}">
					<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}"
					 class="card-img-top post-img" />
				</div>
			</c:if>
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