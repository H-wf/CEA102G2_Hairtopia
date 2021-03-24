<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>
<%@ page import="com.member.model.*"%>

<jsp:useBean id="postSvc"  scope="page" class="com.post.model.PostService" />
<%
	MemService memSvc = new MemService();
	MemVO userSession = memSvc.getOneMem(2);
	pageContext.setAttribute("userSession", userSession);
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

</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid px-0">
	<!-- carousel -->
    <div id="carouselExampleSlidesOnly" class="carousel slide mb-5" data-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://picsum.photos/1300/300?random=2" class="d-block w-100">
            </div>
            <div class="carousel-item">
                <img src="https://picsum.photos/1300/300?random=3" class="d-block w-100">
            </div>
            <div class="carousel-item">
                <img src="https://picsum.photos/1300/300?random=4" class="d-block w-100">
            </div>
        </div>
    </div>
    <!-- csrousel end -->
    <h1></h1>
	<div class="container post">
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
	$(document).ready(function(){
		
		var wholePostMap = "${wholePostMap}";
		if(typeof wholePostMap != 'undefined'){
			if(wholePostMap !=null){
				function reopenPostModal(wholePostMap){
					emptyModal();
					var jData = JSON.parse(wholePostMap);
					
					var commentList = jData.commentList;
					var postVo = jData.postVo;
					var tagNameList = jData.tagNameList;
					
					showWholePost(commentList, postVo, tagNameList);
					$('#postModal').modal('show');
				}
			}
		}
	});
	</script>
</c:if>
</html>