<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.designer.model.*"%>
<%@ page import="com.post.model.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="com.salon.model.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="desSvc" scope="page"
	class="com.designer.model.DesignerService" />
<jsp:useBean id="memSvc" scope="page"
	class="com.member.model.MemService" />
<jsp:useBean id="postSvc" scope="page"
	class="com.post.model.PostService" />
<jsp:useBean id="followSvc" scope="page"
	class="com.followlist.model.FollowListService" />
<jsp:useBean id="salonSvc" scope="page"
	class="com.salon.model.SalonService" />
<jsp:useBean id="serviceSvc" scope="page"
	class="com.service.model.ServiceService" />

<%
	MemVO memVO = memSvc.getOneMem(2);
	request.setAttribute("memVO", memVO);
	DesignerVO designerVO = (DesignerVO) request.getAttribute("designerVO");
// 		SalonVO salVo = (SalonVO) request.getAttribute("salVo");
	SalonVO salVo = salonSvc.getOneSalon(1);
	request.setAttribute("salVo", salVo);
%>
<html lang="en">

<head>
<%@include file="/front-end/tempFile/head"%>
</head>
<style>

/* navBarCSS */
.navbar-brand img {
	width: 250px;
	margin: 0;
	background-color: transparent
}

.navbar-nav {
	margin-right: 1em;
}

.btn-login {
	height: 4em;
	display: flex;
	justify-content: center;
	align-items: center;
}

.ftco-navbar-light .navbar-nav>.nav-item>.nav-link {
	font-size: 0.86em;
	padding-top: 1rem;
	padding-bottom: 1rem;
}

.carousel-caption {
	top: 55%;
}

.offer-deal i::before {
	vertical-align: baseline;
	line-height: 0;
	padding-top: 0;
	padding-bottom: 0;
}

.offer-deal i {
	font-size: 7em;
	color: #d9bf77;
}

.img-profile {
	height: 3.5rem;
	width: 3.5rem;
	margin: 0 1rem;
}

.rounded-circle {
	border-radius: 50% !important;
}
/* 	 .img-profile  */
img {
	vertical-align: middle;
	border-style: none;
}

.dropdown.no-arrow .dropdown-toggle::after {
	display: none;
}

/* 	navBarCSS END */
.profile-head {
	transform: translateY(5rem)
}

.profileCard {
	top: 6.5vh;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
}

.profile img {
	width: 130px;
}

@media ( max-width : 991.98px) {
	.profile {
		top: 0;
		padding-top: 0;
	}
}

.post {
	padding-left: 8em;
	padding-right: 7em;
	margin-top: 2em;
}

.card:hover {
	transform: scale(1.05);
	box-shadow: 0 10px 20px rgba(0, 0, 0, .12), 0 4px 8px rgba(0, 0, 0, .06);
}

.myrow {
	padding-left: 15px;
	padding-right: 15px;
}

/* IncludeModalCSS */
@media ( min-width : 576px) {
	.card-columns {
		column-count: 2;
	}
}

@media ( min-width : 768px) {
	.card-columns {
		column-count: 4;
	}
}

@media ( min-width : 992px) {
	.card-columns {
		column-count: 4;
	}
}

@media ( min-width : 1200px) {
	.card-columns {
		column-count: 4;
	}
}

.post {
	padding-left: 8em;
	padding-right: 7em;
}

.card:hover {
	transform: scale(1.05);
	box-shadow: 0 10px 20px rgba(0, 0, 0, .12), 0 4px 8px rgba(0, 0, 0, .06);
}

.listOne {
	max-width: 70%;
	overflow: hidden;
}

.includePage {
	max-width: 90%;
}

.modal-content .postClose {
	padding: 0.3rem 1.6rem;
	border: none;
	background-color: transparent;
}
/* 	MapCSS */
#map {
	height: 100%;
	width: 100%;
}

.ftco-section {
	margin: 6vh auto;
	padding: 0;
}

.solInfo {
	font-size: 14px;
	list-style: none;
}

.following {
	border: 1px solid transparent;
	background: #d9bf77;
	color: #fff;
}

.salCon {
	display: block;
	color: #bfbfbf;
	text-align: center;
}

.salTitle {
	display: block;
	text-align: center;
	color: #000;
}

.salName {
	font-size: 1.45rem;
	text-align: center;
}

/* callOutCSS */
.callout {
	background-color: #fff;
	border: 1px solid #e4e7ea;
	border-left: 4px solid #c8ced3;
	border-radius: .25rem;
	margin: 1rem;
	padding: .75rem 1.25rem;
	position: relative;
}

.callout h4 {
	font-size: 1.3125rem;
	margin-top: 0;
	margin-bottom: .8rem
}

.callout p:last-child {
	margin-bottom: 0;
}

.callout-default {
	border-left-color: #D8CF9E;
}

.callout-default h4 {
	color: #777;
}

.callout-dismissible .close {
	position: absolute;
	top: 0;
	right: 0;
	padding: .75rem 1.25rem;
	color: inherit;
}

.reservation {
	float: right;
}

.bi-arrow-right {
	margin-left: .3rem;
}

.bi-arrow-right::before {
	vertical-align: middle;
}

.bookingBtn {
	color: #d9bf77 !important;
	float: right;
}

.bookingBtn:hover {
	color: #fff !important;
}

.price {
	overflow: auto;
}

.TransRecord-table{
	border:1px solid ;
	margin:0px auto;
	
}
.ServiceCard{
	width:90%;
	margin:20px auto  0;
}
</style>

<style>
.nav {
	justify-content: center;
}

.head-center {
	display: flex;
	justify-content: center;
}

.profile-head {
	transform: translateY(3rem);
}
</style>

<body>
	<%@include file="/front-end/tempFile/navBar"%>


	<div class="container-fluid">
		<div class="row py-5 px-4 justify-content-center">
			<div class="col-md-9 col-sm-9 mx-auto profileCard">
				<!-- Profile widget -->
				<div class="bg-white rounded overflow-hidden">
					<div class="px-4 pt-0 pb-4 cover head-center">
						<div class="media align-items-end profile-head">
							<div class="profile mr-3">
								<img
									src="<%=request.getContextPath()%>/showImges.do?tableName=member&picColumn=memPic&pkColumn=memNo&memNo=${memVO.memNo}"
									alt='沒有圖片' class="rounded mb-2 img-thumbnail" /> <a href="#"
									class="btn btn-outline-dark btn-sm btn-block">Edit profile</a>
							</div>
							<div class="media-body mb-5 text-white myrow">
								<h4 class="mt-0 mb-0">${memVO.memName}</h4>
								<div class="row  justify-content-end">
									<%-- 	                            <div class="btn btn-outline-primary profileBtn" id="followBtn">${followSvc.isfollowing(memVO.memNo,designerVO.desNo) ==true?"Unfollow":"Follow"}</div> --%>
								</div>
							</div>
						</div>
					</div>
					<div class="px-4 py-3">
						<!-- 	                    <h5 class="mb-0">About</h5> -->
						<div class="p-4 rounded shadow-sm bg-light">
							<p class="font-italic mb-0"></p>
						</div>
					</div>
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item">
							<a class="nav-link active" id="Reservation-tab" data-toggle="tab" 
								href="#Reservation" role="tab" aria-controls="Reservation" aria-selected="true">預約
							</a>
						</li>
						
						<li class="nav-item">
							<a class="nav-link" id="Order-tab" data-toggle="tab" 
								href="#Order" role="tab" aria-controls="Order" aria-selected="false">訂單
							</a>
						</li>
						
						<li class="nav-item">
							<a class="nav-link" id="Course-tab" data-toggle="tab" 
								href="#Course" role="tab" aria-controls="Course" aria-selected="false">課程
							</a>
						</li>
						
						<li class="nav-item">
							<a class="nav-link" id="TransRecord-tab" data-toggle="tab" 
								href="#TransRecord" role="tab" aria-controls="TransRecord" aria-selected="false">交易明細
							</a>
						</li>
					</ul>
					<div class="tab-content" id="myTabContent">

						<div class="tab-pane fade show active" id="Reservation" role="tabpanel"
							aria-labelledby="Reservation-tab">
						
							<div class="callout callout-default">
									<h4>Default Callout</h4>
									This is a default callout11111111. <a
										class="btn btn-outline-primary bookingBtn">查看明細<i
										class="bi bi-arrow-right"></i></a>
								</div>

							<div class="container post">
								<div class="card-columns ">

								</div>
							</div>
						</div>

						<div class="tab-pane fade" id="Order" role="tabpanel"
							aria-labelledby="Order-tab">
							<div class="ServiceCard">
								<div class="callout callout-default">
									<h4>Default Callout</h4>
									This is a default callout. <a
										class="btn btn-outline-primary bookingBtn">查看明細<i
										class="bi bi-arrow-right"></i></a>
								</div>
								<!-- 							Service -->
								<!-- 							<br><br><br><br><br><br><br><br><br><br> -->
							</div>
						</div>
						
						//
						<div class="tab-pane fade" id="Course" role="tabpanel"
							aria-labelledby="Info-tab">
							<div class="InfoCard">
								<section class="ftco-section contact-section">
									<div class="container">
									
									<div class="callout callout-default">
									<h4>Default Callout</h4>
									This is a default callout. <a
										class="btn btn-outline-primary bookingBtn">查看明細<i
										class="bi bi-arrow-right"></i></a>
								</div>

									</div>
								</section>
							</div>
						</div>
						<% %>
						
						<div class="tab-pane fade" id="TransRecord" role="tabpanel"
							aria-labelledby="TransRecord-tab">
							<div class="ServiceCard">
								<div class="card shadow mb-4" width="80%">
<!--                         			<div class="card-header py-3"> -->
<!--                             			<h6 class="m-0 font-weight-bold text-primary">會員管理</h6> -->
<!--                         			</div> -->
                        			<div class="card-body">
                            			<div class="table-responsive">
                                			<table class="table" id="dataTable">
                                    			<thead>
                                        			<tr>
			                                            <th>交易時間</th>
			                                            <th>項目</th>
			                                            <th>金額</th>
			                                            <th>餘額</th>
                                        			</tr>
                                    			</thead>
			                                    <tfoot>
												<!--foreach取資料-->
			                                        <tr>
			                                            <th>交易時間</th>
			                                            <th>項目</th>
			                                            <th>金額</th>
			                                            <th>餘額</th>
			                                        </tr>
			                                    </tfoot>
                                   		 		<tbody>
			                                        <tr>
			                                            <td>Edinburgh</td>
			                                            <td>61</td>
			                                            <td>2011/04/25</td>
			                                            <td>$320,800</td>
			                                        </tr>
			                                        <tr>
			                                            <td>Edinburgh</td>
			                                            <td>61</td>
			                                            <td>2011/04/25</td>
			                                            <td>$320,800</td>
			
			                                        </tr>
			                                        <tr>
			                                            <td>Edinburgh</td>
			                                            <td>61</td>
			                                            <td>2011/04/25</td>
			                                            <td>$320,800</td>
			
			                                        </tr>
			                                        <tr>
			                                            <td>Edinburgh</td>
			                                            <td>61</td>
			                                            <td>2011/04/25</td>
			                                            <td>$320,800</td>
			
			                                        </tr>
			                                        <tr>
			                                            <td>Edinburgh</td>
			                                            <td>61</td>
			                                            <td>2011/04/25</td>
			                                            <td>$320,800</td>
			
			                                        </tr>

                                   				 </tbody>
                                			</table>
			                            </div>
			                        </div>
			                    </div>						
							</div>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Post Modal -->
	<c:if test="${openModal != null}">
		<div class="modal fade" id="postModal" tabindex="-1"
			aria-hidden="false">
			<div
				class="modal-dialog modal-dialog-centered modal-dialog-scrollable listOne">
				<div class="modal-content">
					<button type="button" class="postClose text-right"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<div class="modal-body p-0 m-0">
						<div class="includePage">
							<jsp:include
								page="/front-end/Comment/listPostWithComments_front.jsp" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:if>
	<!-- Post END -->
	<!-- Login Modal -->
	<div class="modal fade" id="loginModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">登入</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">...</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Login Modal END -->
	<script src="<%=request.getContextPath()%>/dist/js/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/dist/js/jquery-migrate-3.0.1.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/dist/js/jquery.easing.1.3.js"></script>
	<script
		src="<%=request.getContextPath()%>/dist/js/jquery.waypoints.min.js"></script>
	<!-- << -->
	<script
		src="<%=request.getContextPath()%>/dist/js/jquery.stellar.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/dist/js/jquery.magnific-popup.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/dist/js/jquery.animateNumber.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/dist/js/jquery.timepicker.min.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/bootstrap.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/dist/js/bootstrap-datepicker.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/popper.min.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/aos.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/owl.carousel.min.js"></script>
	<!-- << -->
	<script src="<%=request.getContextPath()%>/dist/js/scrollax.min.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/main.js"></script>
	<script src="<%=request.getContextPath()%>/dist/slick/slick.min.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAgth_SXMI_V6SbxEmCxOFwzUwCXAizZhY&callback=initMap&libraries=&v=weekly"
		async></script>
	<!-- Page Content END -->
	<%@include file="/front-end/tempFile/footer"%>
	<%@include file="/front-end/tempFile/tempJs"%>
</body>
<script>
// 	$('#loginModal').on('shown.bs.modal', function() {
// 	    $('#myInput').trigger('focus')
// 	})
// 	$("#postModal").modal({show: true});
	
// 	$(document).ready(function(){
// 		$('#followBtn').on('click',function(){
// 			var obj = {
// 					memNo:${not empty memVO.memNo?memVO.memNo:"null"},
// 					desNo:${designerVO.desNo},
// 			}
			
// 			if(obj.memNo === null){
// 				window.alert("請先登入");
// 				return false;
// 			}else if(obj.memNo === ${designerVO.memNo}){
// 				window.alert("自己不能追蹤自己");
// 				return false;
// 			}else if($('#followBtn').text() ==="Unfollow"){
// 				obj.action = "deleteByAJAX";
// 					$.ajax({
// 						type:"POST",
<%-- 						url:"<%=request.getContextPath()%>/followlist/followlist.do", --%>
// 						data:obj,
// 						success:function(data){
// 							window.alert("已解除追蹤")
// 							$('#followBtn').text("Follow");
// 						},
// 						error:function(){
// 							window.alert("ajax ERROR!")
// 						}
// 					});
				
// 			}else if($('#followBtn').text() ==="Follow"){
// 				obj.action = "insertByAJAX";
// 					$.ajax({
// 							type:"POST",
<%-- 							url:"<%=request.getContextPath()%>/followlist/followlist.do", --%>
// 							data:obj,
// 							success:function(data){
// 								window.alert("追蹤成功");
// 								$('#followBtn').text("Unfollow");
// 							},
// 							error:function(){
// 								window.alert("ajax ERROR!")
// 							}
// 					});
// 				}
// 		});
		
// 	});
	
// // MAP
// 	function initMap() {
//         	//準備好要顯示的緯經度
//             const myLatLng = { lat: 24.957503, lng: 121.225111 };
//             //抓取div id生成Map類別
//             const map = new google.maps.Map(document.getElementById("map"), {
//                 zoom: 18,
//                 center: myLatLng,
//             });
//             var marker = new google.maps.Marker({
//                 position: myLatLng,
//                 map,
//                 title: "Hello World!",

//             });
//             //將地點資訊放入小卡片
//             var infoWindow = new google.maps.InfoWindow({
//                 content: '<h1>salon</h1>'
//             })
//             //加入聆聽器 點擊彈出小卡片
//             marker.addListener('click', function() {
//                 infoWindow.open(map, marker);
//             });
//         }
</script>

</html>