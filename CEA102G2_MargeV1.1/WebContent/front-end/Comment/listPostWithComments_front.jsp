<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.post.model.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="commentSvc" scope="page"
	class="com.comment.model.CommentService" />
<jsp:useBean id="tagdetSvc" scope="page"
	class="com.tagdet.model.TagdetService" />
<jsp:useBean id="tagSvc" scope="page" class="com.tag.model.TagService" />
<%
	PostVO postVO = (PostVO) request.getAttribute("postVO");
%>
<html>
<head>
<title>List Comment Of A Post Front</title>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
</head>
<style>
* {
	box-sizing: border-box;
}

img {
	max-width: 100%;
}

.card-body {
	padding: 0;
}

.comTime {
	margin-left: 80%;
}

.comCon {
	font-size: 14px;
	color: black;
}

.input-group {
	/* 	position:absolute; */
	top: 50%;
	z-index: 9999999;
	max-width: 100%;
}

.form-control {
	height: 45px !important;
	font-size: 15px;
}

@media screen and (max-width: 576px) {
	div.my_div1 {
		width: 100%;
	}
}

@media ( min-width :576px) and (max-width:768px) {
	div.my_div1 {
		width: 540px;
	}
}

@media ( min-width :768px) and (max-width:992px) {
	div.my_div1 {
		width: 720px;
	}
}

@media ( min-width :992px) and (max-width:1200px) {
	div.my_div1 {
		width: 960px;
	}
}

@media ( min-width :1200px) {
	div.my_div1 {
		width: 1140px;
	}
}
</style>
<div>
	<!-- 參考原版檔案在oldFile裡 -->
	<div class="row g-0">
		<div class="col-md-6">


			<div id="carouselExampleIndicators" class="carousel slide"
				data-ride="carousel">
				<c:if
					test='${(not empty postVO.postPic2) || (not empty postVO.postPic3)}'>
					<ol class="carousel-indicators">
						<li data-target="#carouselExampleIndicators" data-slide-to="0"
							class="active"></li>
						<c:if test='${not empty postVO.postPic2}'>
							<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
						</c:if>
						<c:if test='${not empty postVO.postPic3}'>
							<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
						</c:if>
					</ol>
				</c:if>
				<div class="carousel-inner">
					<div class="carousel-item active">
						<img
							src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}"
							class="card-img" />
					</div>
					<c:if test='${not empty postVO.postPic2}'>
						<div class="carousel-item">
							<img
								src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic2&idname=postNo&id=${postVO.postNo}"
								class="card-img" />
						</div>
					</c:if>

					<c:if test='${not empty postVO.postPic3}'>
						<div class="carousel-item">
							<img
								src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic3&idname=postNo&id=${postVO.postNo}"
								class="card-img" />
						</div>
					</c:if>
				</div>
				<c:if
					test='${(not empty postVO.postPic2) || (not empty postVO.postPic3)}'>
					<a class="carousel-control-prev" href="#carouselExampleIndicators"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a>
					<a class="carousel-control-next" href="#carouselExampleIndicators"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>
				</c:if>
			</div>
		</div>
		<div class="col-md-6 p-0">
			<div class="card-title">
				<h2>${postVO.desNo}</h2>
				<h5 class="m-0">${postVO.postCon}</h5>
				<c:forEach var="tagNo"
					items="${tagdetSvc.getTagNo(postVO.getPostNo())}">
					<div class="badge badge-secondary">${tagSvc.getTagName(tagNo)}</div>
				</c:forEach>
				<br> <small class="text-muted"> <fmt:formatDate
						value="${postVO.postTime}" pattern="yyyy-MM-dd HH:mm:ss" /></small>
			</div>
			<p class="card-text">
			<ul class="list-unstyled">
				<c:forEach var="commentVo"
					items="${commentSvc.getComsByPostNo(postVO.getPostNo())}">
					<c:if test='${commentVo.comStatus != false}'>
						<li class="media">
							<!--            會員頭貼                  <img src="..." class="mr-3" alt="..."> -->
							<div class="media-body">
								<h5 class="mt-0 mb-1">${commentVo.memNo}</h5>
								<p class="comCon">${commentVo.comCon}</p>
								<small class="text-muted comTime">${commentVo.comTime}</small>
							</div>
						</li>
					</c:if>
				</c:forEach>
			</ul>
			<!--  有會員之後要判斷出刪除、修改按鈕 -->
			<form method="post"
				action="<%=request.getContextPath()%>/comment/comment.do">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="輸入留言"
						name="comCon"> <input type="hidden" name="postNo"
						value="${postVO.postNo}"> <input type="hidden"
						name="memNo" value="1"> <input type="hidden" name="action"
						value="insert_Front">
					<button class="btn btn-outline-secondary" type="submit">留言</button>
				</div>
			</form>

		</div>
	</div>
</div>
</html>