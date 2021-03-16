<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>

<jsp:useBean id="postSvc"  scope="page" class="com.post.model.PostService" />
<html>
<head>
<title>Hairtopia</title>
<meta charset="utf-8">
<%@include file="/front-end/tempFile/head" %>        
</head>
<style>
/* postCSS */
	@media (min-width: 576px) {
  .card-columns {
	    column-count: 2;
	  	}
	}
	@media (min-width: 768px) {
	  .card-columns {
	    column-count: 4;
	  }
	}
	@media (min-width: 992px) {
	  .card-columns {
	    column-count: 4;
	  }
	}
	@media (min-width: 1200px) {
		.card-columns {
	    column-count: 4;
	  }
	}
	.post{
		padding-left: 8em;
		padding-right: 7em;
	}
 	.card:hover{ 
      transform: scale(1.05); 
 	  box-shadow: 0 10px 20px rgba(0,0,0,.12), 0 4px 8px rgba(0,0,0,.06); 
 	}

/* 	.listOne { */
/*  	  max-width: 70%; */
/*  	  overflow: hidden; */
/* 	} */
/* 	.includePage{ */
/* 		max-width:90%; */
/* 	} */
/* 	.modal-content .postClose{ */
/* 		position:absolute; */
/* 		top:3%; */
/* 		left:93%; */
/* 		z-index: 999; */
/* 		border:none; */
/* 		background-color: transparent; */
/* 		font-size:16px; */
/* 	} */
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
<%-- 			<a href="<%=request.getContextPath()%>/front-end/post/post.do?postNo=${postVO.postNo}&action=Display_fromListAll" > --%>
				<div class="card onePost" id="${postVO.postNo}">
					<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}"
					 class="card-img-top post-img" data-toggle="modal" data-target="#postModal" />
				</div>
<!-- 			</a> -->
		</c:forEach>
		</div>
	</div>
</div>
<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>	
	
</body>
<script>
var contextPath = "<%=request.getContextPath()%>";
		
// 		$(document).ready(function(){
// 			$('.onePost').on('click',function(){
// 				$.ajax({
// 					type:"GET",
// 					url:contextPath+"/post/post.do",
// 					data:{
// 							action:"getWholePost",							
// 							postNo:$(this).attr('id'),
// 						},
// 					success:function(data){
// 						//console.log(data);
// 						var jData = JSON.parse(data);
// 						var commentList = jData.commentList;
// 						var postVo = jData.postVo;
// 						var tagNameList = jData.tagNameList;
						
// 						console.log(commentList);
// 						console.log(postVo);
// 						console.log(tagNameList);
// 					},
// 					error:function(){
// 						console.log("AJAX ERROR!");
// 					}
// 				});
// 			});
// 		});
	</script>
</html>