<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.reservation.model.*"%>
<%@ page import="com.designer.model.*"%>

	<jsp:useBean id="serviceSvc" scope="page" class="com.service.model.ServiceService" />
	<jsp:useBean id="postSvc" scope="page" 	class="com.post.model.PostService" />
	<jsp:useBean id="designerSvc" scope="page" class="com.designer.model.DesignerService" />
	<jsp:useBean id="resSvc" scope="page" class="com.reservation.model.ResService" />
	<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService" />
<%
	DesignerService desSvc = new DesignerService();
	DesignerVO desSession = desSvc.getOneDesByDesNo(1);
	DesignerVO designerVO = desSvc.getOneDesByDesNo(1);
	pageContext.setAttribute("desSession", desSession);
	pageContext.setAttribute("designerVO", designerVO);
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
	.ftco-navbar-light{
		position:static;
	}
	a{
		text-decoration:none;
		text-align:center
	}
	.checkDetail{
		font-size:.8rem;
	}
	.btn-primary{
		border:0px;
		padding:.3rem .5rem;
	}
	.list-group-item{
		font-weight:400;
	}
	.list-group-item.active{
		background-color:#D8CF9E;
		border:0px;
	}
	.mainArea{ 
 		margin:5rem 0; 
 	} 
 	.postStaBtn{
 	position: absolute;
    top: 6px;
    right: 6px;
 	}
 	.card:hover{
    transform: none;
    box-shadow: none;}
</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>
<!-- Begin Page Content -->

<div class="container-fluid mainArea">
<div class="row">
	<div class="col-2"></div>
	<div class="col-2">
		<div class="list-group">
  			<a href="<%=request.getContextPath()%>/service/service.do?action=queryByDesNo&desNo=${desSession.desNo}" class="list-group-item list-group-item-action">
    			服務項目管理
  			</a>
  			<a href="<%=request.getContextPath()%>/reservation/res.do?action=queryByDesNo&desNo=${desSession.desNo}" class="list-group-item list-group-item-action">
  				預約狀態管理
  			</a>
  			<a href="<%=request.getContextPath()%>/front-end/reservation/listScheduleOfDes.jsp" class="list-group-item list-group-item-action">
  				查看預約行程
  			</a>
  			<a href="<%=request.getContextPath()%>/designer/designer.do?action=getOne_For_Update&desNo=${desSession.desNo}" class="list-group-item list-group-item-action">
				個人資訊修改
			</a>
			<a href="#" class="list-group-item list-group-item-action  active">
				貼文狀態管理
			</a>
		</div>
	</div>
	<div class="col-7">
	<h4>All Post</h4>
	<div class="container-fluid">
		<!-- Post Card -->
			<c:forEach var="postVO"	items="${postSvc.getAll(designerVO.desNo)}">
				<c:if test="${postVO.postStatus != 2}">
					<div class="card w-auto  my-3"  >
							<div class="row no-gutters">
								<div class="col-md-3">
									<img  class="img-fluid" src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}" />
								</div>
								<div class="postStaBtn">
									<button class="btn btn-outline-primary onePost" id="${postVO.postNo}">顯示貼文</button>
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post/post.do">
										<input type="submit" value="修改狀態" class="btn btn-outline-primary">
										<input type="hidden" name="postNo"  value="${postVO.postNo}">
										<input type="hidden" name="postStatus"  value="${postVO.postStatus}">
										<input type="hidden" name="URI"  value="<%=request.getServletPath()%>">
										<input type="hidden" name="action"	value="changePostStatus">
									</FORM>
								</div>
								<div class="col-md-5">
									<div class="card-body pl-3">
										<p class="card-text">${postVO.postCon}</p>
										<p class="card-text">顯示狀態:${postVO.postStatus == 0?"顯示中":"隱藏中"}</p>
										<p class="card-text">
											<small class="text-muted"><fmt:formatDate value="${postVO.postTime}" pattern="yyyy-MM-dd HH:mm:ss" /></small>
										</p>
									</div>
								</div>
							</div>
						</div>
				</c:if>
			</c:forEach>
	</div>
</div>
<div class="col-1"></div>
</div>
</div>
<!-- Page Content END -->
	<!-- addPostModal -->
	<div class="modal fade" id="updatePostModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<form METHOD="POST"	ACTION="<%=request.getContextPath()%>/post/post.do" id="updatePostForm" name="form" enctype="multipart/form-data">
						<div class="row justify-content-center">
							<div class="col-md-12" id="addPostTitle"><h4>修改貼文</h4></div>
							<div class="col-md-12 ftco-animate">
									<div class="form-group">
										<label for="postCon">貼文內容</label>
										<textarea name="postCon" id="postCon" cols="30" rows="3" class="form-control"></textarea>
									</div>
									<label for="">貼文狀態</label>
									<div class="form-group">
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio" name="postStatus" id="inlineRadio1" value="0"> 
											<label class="form-check-label" for="inlineRadio1">顯示</label>
										</div>
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio" name="postStatus" id="inlineRadio2" value="1"> 
											<label class="form-check-label" for="inlineRadio2">隱藏</label>
										</div>
									</div>
									<input name="action" value="update" type="hidden">
									<input name="postNo" value="update" type="hidden">
									<input name="desNo" value="${desSession.desNo}" type="hidden">
									<div class="form-group" style="text-align: center;">
										<input type="button" value="上傳貼文" class="btn btn-primary py-3 px-5" id="addPostSmtBtn">
									</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- addPostModal END -->
<%@include file="/front-end/Post/postModal"%>
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
<script src="<%=request.getContextPath()%>/resource/js/postModal.js"></script>
</body>
<script>
$(document).ready(function(){
	$('#updatePostModal').on('click',function(){
		//判斷欄位空值
		if( $('#postCon').val().trim().length === 0 || $('input[name=postStatus]:checked').val()==null){
			var errorText=[];
			var AllError='';
			
			if($('#postCon').val().trim().length === 0){
				var postConError = "請輸入貼文內容。";
				errorText.push(postConError);
			}
			
			if($('input[name=postStatus]:checked').val()==null){
				var postStatusError = "請選擇貼文狀態。";
				errorText.push(postStatusError);
			}
			
		for(let i=0;i<errorText.length;i++){
			let oneError = '<li>'+errorText[i]+'</li>';
			AllError=AllError+oneError;
		}
			swal.fire({
				title:'請修正以下錯誤',
				html:`<ul>`+AllError+`</ul>`,
				icon:'warning',
				showCloseButton: true,
			});
		}else{
				swal.fire({
				title:'已送出修改',
				icon:'success',
				showCloseButton: true,
			}).then(function(){
				$('#addPostForm').submit();
				
			});
		}
	});
});
</script>
</html>