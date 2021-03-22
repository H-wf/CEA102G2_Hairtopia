<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.designer.model.*"%>
<%@ page import="com.post.model.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="com.salon.model.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="desSvc" scope="page" class="com.designer.model.DesignerService" />
<jsp:useBean id="postSvc" scope="page" 	class="com.post.model.PostService" />
<jsp:useBean id="followSvc" scope="page" class="com.followlist.model.FollowListService" />
<jsp:useBean id="salonSvc" scope="page"	class="com.salon.model.SalonService" />
<jsp:useBean id="serviceSvc" scope="page" class="com.service.model.ServiceService" />

<%
	DesignerVO designerVO = (DesignerVO) request.getAttribute("designerVO");
	SalonVO salVo = (SalonVO) request.getAttribute("salVo");
	DesignerService desSvcs = new DesignerService();
	DesignerVO desSession = desSvcs.getOneDesByDesNo(1);
	pageContext.setAttribute("desSession", desSession);
%>
<html lang="en">

<head>
<title>Hairtopia</title>
<meta charset="utf-8">
<%@include file="/front-end/tempFile/head"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/desPage.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/post.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/tagify/dist/tagify.css">
</head>
<style>
#addPostModal label {
	color: #333333;
}

#addPostModal .contact-form .form-control {
	height: 2rem !important;
}

input[type=file],.tagify.form-control {
	font-size: .9rem;
	height: 2.5rem !important;
}
.tagify__tag-text{
    color: #000;
}
#addPostModal .form-check-label{
font-size: .9rem;
}
</style>

<body>
	<%@include file="/front-end/tempFile/navBar"%>

	<div class="container-fluid">
		<div class="row py-5 px-4 justify-content-center">
			<div class="col-md-9 col-sm-9 mx-auto profileCard">
				<!-- Profile widget -->
				<div class="bg-white rounded overflow-hidden">
					<div class="px-4 pt-0 pb-4 cover">
						<div class="media align-items-end profile-head">
							<div class="profile mr-3">
								<img
									src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}"
									alt='沒有圖片' class="rounded mb-2 img-thumbnail" /> <a href="#"
									class="btn btn-outline-dark btn-sm btn-block">Edit profile</a>
								<a href="#" class="btn btn-outline-dark btn-sm btn-block"
									id="addPostBtn" data-toggle="modal" data-target="#addPostModal">Add
									Post</a>
							</div>
							<div class="media-body mb-5 text-white myrow">
								<h4 class="mt-0 mb-0">${designerVO.desName}</h4>
								<div class="row  justify-content-end">
									<div class="btn btn-outline-primary profileBtn" id="followBtn"
										style="margin: 0 2%;">${followSvc.isfollowing(memVO.memNo,designerVO.desNo) ==true?"Unfollow":"Follow"}</div>
									<div class="btn btn-outline-primary" id="msgBtn">傳送訊息</div>
								</div>
							</div>
						</div>
					</div>
					<div class="bg-light p-4 d-flex justify-content-end text-center">
						<ul class="list-inline mb-0">
							<li class="list-inline-item">
								<h5 class="font-weight-bold mb-0 d-block">215</h5>
								<small class="text-muted"></i>Post</small>
							</li>
							<li class="list-inline-item">
								<h5 class="font-weight-bold mb-0 d-block">745</h5>
								<small class="text-muted">Followers</small>
							</li>
							<li class="list-inline-item">
								<h5 class="font-weight-bold mb-0 d-block">340</h5>
								<small class="text-muted">Following</small>
							</li>
						</ul>
					</div>
					<div class="px-4 py-3">
						<h5 class="mb-0">About</h5>
						<div class="p-4 rounded shadow-sm bg-light">
							<p class="font-italic mb-0">${designerVO.desInfor}</p>
						</div>
					</div>
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item"><a class="nav-link active" id="Post-tab"
							data-toggle="tab" href="#Post" role="tab" aria-controls="Post"
							aria-selected="true">Post</a></li>
						<li class="nav-item"><a class="nav-link" id="Service-tab"
							data-toggle="tab" href="#Service" role="tab"
							aria-controls="Service" aria-selected="false">Service</a></li>
						<li class="nav-item"><a class="nav-link" id="Info-tab"
							data-toggle="tab" href="#Info" role="tab" aria-controls="Info"
							aria-selected="false">Info</a></li>
					</ul>
					<div class="tab-content" id="myTabContent">

						<div class="tab-pane fade show active" id="Post" role="tabpanel"
							aria-labelledby="Post-tab">

							<div class="container post">
								<div class="card-columns ">
									<!-- Post Card -->
									<c:forEach var="postVO"
										items="${postSvc.getAll(designerVO.desNo)}">
										<c:if test="${postVO.postStatus eq 0}">
											<div class="card onePost" id="${postVO.postNo}">
												<img
													src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}"
													class="card-img-top post-img" />
											</div>
											</a>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</div>

						<div class="tab-pane fade" id="Service" role="tabpanel"
							aria-labelledby="Service-tab">
							<div class="ServiceCard">
								<c:forEach var="serviceVo"
									items="${serviceSvc.getAllServiceByDesNo(designerVO.desNo)}">
									<c:if test="${serviceVo.serStatus eq 1}">
										<div class="callout callout-default">
											<h4>${serviceVo.serName}<br>
												<h4 style="font-size: 1rem;">
													服務時間:
													<c:set var="serTime" value="${serviceVo.serTime}" />
													<fmt:formatNumber type="number"
														value="${((serTime*30 -(serTime*30%60)))/60}" var="hour" />
													<c:if test="${hour>0}">${hour}小時</c:if>${(serTime*30 %60 == 0)? "" :"30分" }</h4>
											</h4>

											<span style="font-size: 1rem;">${serviceVo.serDesc}</span>
											<hr>
											<div class="price">
												<h4 style="display: inline; font-size: unset;">優惠價:
													${serviceVo.serPrice}元</h4>
												<a class="btn btn-outline-primary bookingBtn"
													href="<%=request.getContextPath()%>/service/service.do?serNo=${serviceVo.serNo}&action=getOne_For_AddRes">立即預約<i
													class="bi bi-arrow-right"></i></a>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
						<div class="tab-pane fade" id="Info" role="tabpanel"
							aria-labelledby="Info-tab">
							<div class="InfoCard">
								<section class="ftco-section contact-section">
									<div class="container">
										<div class="row block-9">
											<div
												class="col-md-6 contact-info ftco-animate bg-light mt-3 shadow">
												<div class="row">
													<div class="col-md-12">
														<h2 class="h4 salName">${salVo.salName}</h2>
														<hr>
													</div>
													<div class="col-md-12 mb-3">
														<span class="salTitle">Address</span><span class="salCon">${salVo.salAdd}</span>
													</div>
													<div class="col-md-12 mb-3">
														<span class="salTitle">Phone</span> <a
															href="tel://1234567920"><span class="salCon">${salVo.salPhone}</span></a>
													</div>
													<div class="col-md-12 mb-3">
														<span class="salTitle">Time</span> <a
															href="mailto:info@yoursite.com"><span class="salCon">${salVo.salTime}</span></a>
													</div>
												</div>
											</div>
											<div class="col-md-6 ftco-animate">
												<div id="map"></div>
											</div>
										</div>
									</div>
								</section>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- addPostModal -->
	<div class="modal fade" id="addPostModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<form METHOD="POST"
						ACTION="<%=request.getContextPath()%>/post/post.do" name="form"
						enctype="multipart/form-data">
						<div class="row justify-content-center">
							<div class="col-md-12 ftco-animate">
								<form action="#" class="contact-form">
									<div class="form-group">
										<label for="tagName">貼文標籤</label> 
										<input class="form-control"	id="tagName" name="tagName" placeholder="write some tags" value="predefined,tags,here" size="50">
									</div>
									<div class="form-group">
										<label for="postCon">貼文內容</label>
										<textarea name="postCon" id="postCon" cols="30" rows="3" class="form-control"></textarea>
									</div>
									<div class="form-group">
										<label for="Picture 1">Picture 1</label> 
										<input type="file"	name="upfile1" id="myFile1" class="form-control"	placeholder="Picture 1">
									</div>
									<div class="form-group">
										<label for="Picture 2">Picture 2</label>
										<input type="file" name="upfile2" id="myFile2" class="form-control" placeholder="Picture 2">
									</div>
									<div class="form-group">
										<label for="Picture 3">Picture 3</label> 
										<input type="file" name="upfile3" id="myFile3" class="form-control" placeholder="Picture 3">
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
									<input name="action" value="insert" type="hidden">
									<input name="desNo" value="${desSession.desNo}" type="hidden">
									<div class="form-group" style="text-align: center;">
										<input type="submit" value="上傳貼文" class="btn btn-primary py-3 px-5" id="addPostBtn">
									</div>
								</form>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- addPostModal END -->

	<%@include file="/front-end/Post/postModal"%>
	<%@include file="/front-end/tempFile/footer"%>
	<%@include file="/front-end/tempFile/tempJs"%>
	<script src="<%=request.getContextPath()%>/resource/js/postModal.js"></script>
	<script src="<%=request.getContextPath()%>/resource/tagify/dist/jQuery.tagify.min.js"></script>
	<script	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAgth_SXMI_V6SbxEmCxOFwzUwCXAizZhY&callback=initMap&libraries=&v=weekly" async></script>
</body>
<script>

//FOLLOW
	$(document).ready(function(){
		$('#tagName').tagify();
		$('#followBtn').on('click',function(){
			var obj = {
					memNo:${not empty memVO.memNo?memVO.memNo:"null"},	//userSession
					desNo:${designerVO.desNo},
			}
			
			if(obj.memNo === null){
				window.alert("請先登入");
				return false;
			}else if(obj.memNo === ${designerVO.memNo}){
				window.alert("自己不能追蹤自己");
				return false;
			}else if($('#followBtn').text() ==="Unfollow"){
				obj.action = "deleteByAJAX";
					$.ajax({
						type:"POST",
						url:"<%=request.getContextPath()%>/followlist/followlist.do",
						data:obj,
						success:function(data){
							window.alert("已解除追蹤")
							$('#followBtn').text("Follow");
						},
						error:function(){
							window.alert("ajax ERROR!")
						}
					});
				
			}else if($('#followBtn').text() ==="Follow"){
				obj.action = "insertByAJAX";
					$.ajax({
							type:"POST",
							url:"<%=request.getContextPath()%>/followlist/followlist.do",
							data:obj,
							success:function(data){
								window.alert("追蹤成功");
								$('#followBtn').text("Unfollow");
							},
							error:function(){
								window.alert("ajax ERROR!")
							}
					});
				}
		});
// 		$('#addPostBtn').on('click',function(){
// 			var errorText;
// 			if($('tags').val().trim().length === 0){
// 				var tagError ="・請至少輸入一個標籤。";
// 				errorText.concat(tagError);
// 			}
// 			if($('#postCon').val().trim().length === 0){
// 				var postConError = "請輸入貼文內容。";
// 				errorText.concat(postConError);
// 			}
// 			if($('#myFile1').val().trim().length === 0){
// 				var fileError = "請至少上傳一張照片。";
// 				errorText.concat(fileError);
// 			}
// 			if($('input[name=postStatus]:checked').val()==null){
// 				var postStatusError = "請選擇貼文狀態。";
// 				errorText.concat(postStatusError);
// 			}
// 			swal.fire({
// 				title:'請修正以下錯誤',
// 				text:,
// 				type:'warning',
// 				showCloseButton: true,
// 			});
// 		});
	});
	
// MAP
	function initMap() {
        	//準備好要顯示的緯經度
            const myLatLng = { lat: ${salVo.salLat}, lng: ${salVo.salLng} };
            //抓取div id生成Map類別
            const map = new google.maps.Map(document.getElementById("map"), {
                zoom: 18,
                center: myLatLng,
            });
            var marker = new google.maps.Marker({
                position: myLatLng,
                map,
                title: "Hello World!",
            });
            //將地點資訊放入小卡片
            var infoWindow = new google.maps.InfoWindow({
                content: '<h1>salon</h1>'
            })
            //加入聆聽器 點擊彈出小卡片
            marker.addListener('click', function() {
                infoWindow.open(map, marker);
            });
        }
</script>

</html>