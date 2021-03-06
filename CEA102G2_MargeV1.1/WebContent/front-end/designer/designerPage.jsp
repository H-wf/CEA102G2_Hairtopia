<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.designer.model.*"%>
<%@ page import="com.post.model.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="desSvc"  scope="page" class="com.designer.model.DesignerService" />
<jsp:useBean id="postSvc"  scope="page" class="com.post.model.PostService" />
<jsp:useBean id="followSvc"  scope="page" class="com.followlist.model.FollowListService" />

<%	DesignerVO designerVO = (DesignerVO) request.getAttribute("designerVO"); 
%>
<html lang="en">

<head>
    <title>Hairtopia</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/animate.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/owl.carousel.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/magnific-popup.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/aos.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/jquery.timepicker.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/slick/slick.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/slick/slick-theme.css">
</head>
<style>

/* navBarCSS */
    .navbar-brand img{
		width: 250px;
		margin: 0;
		background-color: transparent
	}
	.navbar-nav{
		margin-right: 1em;
	}
	.btn-login{
		height: 4em;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.ftco-navbar-light .navbar-nav > .nav-item > .nav-link {
		font-size: 0.86em;
		padding-top: 1rem;
		padding-bottom: 1rem;
	}
    .carousel-caption {
                top: 55%;
            }
    .offer-deal i::before{

        vertical-align: baseline;
        line-height: 0;
        padding-top: 0;
        padding-bottom: 0;
    }
    .offer-deal i{
        font-size: 7em;
        color: #d9bf77;
    }


	.img-profile {
	    height: 3.5rem;
	    width: 3.5rem;
	    margin: 0 1rem;
	}
	
	.rounded-circle {
	    border-radius: 50%!important;
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
	.profileCard{
	    top: 6.5vh;
	    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	
	}
	.profile img{
	    width:130px;
	}
	@media (max-width: 991.98px){
	    .profile{
	        top:0;
	        padding-top: 0;
	    }
	}
	.post{
		padding-left: 8em;
		padding-right: 7em;
		margin-top:2em;
	}
	.card:hover{
     transform: scale(1.05);
	  box-shadow: 0 10px 20px rgba(0,0,0,.12), 0 4px 8px rgba(0,0,0,.06);
	}
	.myrow{
		padding-left: 15px; 
		padding-right:15px;
	}

/* IncludeModalCSS */
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

	.listOne {
 	  max-width: 70%;
 	  overflow: hidden;
	}
	.includePage{
		max-width:90%;
	}
	.modal-content .postClose{
		position:absolute;
		top:3%;
		left:93%;
		z-index: 9999999;
		border:none;
		background-color: transparent;
		font-size:16px;
	}
/* 	MapCSS */
#map {
        height: 300px;
        width: 100%;
        }
.mapRow{
	margin:6vh auto;
}
.solInfo{
	font-size: 14px;
    list-style: none;
}
.following{
	border: 1px solid transparent;
    background: #d9bf77;
    color: #fff;
}
</style>

<body>
    <!-- navBar -->
    <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
        <a class="navbar-brand justify-content-center" href="#">
            <img src="<%=request.getContextPath()%>/dist/images/logo/HairtopiaLogo3.png" class="ml-4">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="oi oi-menu"></span> Menu
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="ftco-nav">
            <ul class="navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link" aria-current="page" href="#">首頁</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">搜尋</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">髮品商城</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">風格誌</a>
                </li>
                <!--  <div class="navbar-icon">
                    <i class="bi bi-search"></i>
                </div> -->
                <li class="nav-item dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img class="img-profile rounded-circle" src="<%=request.getContextPath()%>/dist/images/offer-deal-2.jpg">
                    </a>
                    <!-- Dropdown - User Information -->
                    <div class="dropdown-menu" aria-labelledby="userDropdown">
                        <a class="dropdown-item" href="#">
                            <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                            Profile
                        </a>
                        <a class="dropdown-item" href="#">
                            <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                            Settings
                        </a>
                        <a class="dropdown-item" href="#">
                            <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                            Activity Log
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                            <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                            Logout
                        </a>
                    </div>
                </li>
                <li>
	                <button type="button" class="btn btn-outline-primary btn-login" data-toggle="modal" data-target="#loginModal">
						 Login
					</button>
<!--                 	<a href="#" class="btn btn-outline-primary btn-login" data-toggle="modal" data-target="#loginModal">Login</a> -->
                </li>
            </ul>
        </div>
    </nav>
    <!-- END nav -->
    <div class="row py-5 px-4">
        <div class="col-md-9 col-sm-9 mx-auto profileCard">
            <!-- Profile widget -->
            <div class="bg-white rounded overflow-hidden">
                <div class="px-4 pt-0 pb-4 cover">
                    <div class="media align-items-end profile-head">
                        <div class="profile mr-3">
                        	<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}" alt='沒有圖片' 
                        	class="rounded mb-2 img-thumbnail" />
	                        <a href="#" class="btn btn-outline-dark btn-sm btn-block">Edit profile</a>
                        </div>
                        <div class="media-body mb-5 text-white myrow">
                            <h4 class="mt-0 mb-0" >${designerVO.desName}</h4>
                            <div class="row  justify-content-end"">
                            <div class="btn btn-outline-primary profileBtn" id="followBtn">${followSvc.isfollowing(memVO.memNo,designerVO.desNo) ==true?"Unfollow":"Follow"}</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bg-light p-4 d-flex justify-content-end text-center">
                    <ul class="list-inline mb-0">
                        <li class="list-inline-item">
                            <h5 class="font-weight-bold mb-0 d-block">215</h5><small class="text-muted"> <i class="fas fa-image mr-1"></i>Post</small>
                        </li>
                        <li class="list-inline-item">
                            <h5 class="font-weight-bold mb-0 d-block">745</h5><small class="text-muted"> <i class="fas fa-user mr-1"></i>Followers</small>
                        </li>
                        <li class="list-inline-item">
                            <h5 class="font-weight-bold mb-0 d-block">340</h5><small class="text-muted"> <i class="fas fa-user mr-1"></i>Following</small>
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
                    <li class="nav-item">
                        <a class="nav-link active" id="Post-tab" data-toggle="tab" href="#Post" role="tab" aria-controls="Post" aria-selected="true">Post</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="Service-tab" data-toggle="tab" href="#Service" role="tab" aria-controls="Service" aria-selected="false">Service</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="Info-tab" data-toggle="tab" href="#Info" role="tab" aria-controls="Info" aria-selected="false">Info</a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                
                    <div class="tab-pane fade show active" id="Post" role="tabpanel" aria-labelledby="Post-tab">
                    
                        <div class="container post">
                            <div class="card-columns ">
                                <!-- Post Card -->
                                <c:forEach  var="postVO" items="${postSvc.getAll(designerVO.desNo)}">
									<a href="<%=request.getContextPath()%>/front-end/post/post.do?postNo=${postVO.postNo}&action=Display_fromDesPage" >
										<div class="card">
											<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}"
											 class="card-img-top post-img" data-toggle="modal" data-target="#postModal" />
										</div>
									</a>
								</c:forEach>
                            </div>
                        </div>
                    </div>
                    
                    <div class="tab-pane fade" id="Service" role="tabpanel" aria-labelledby="Service-tab">
						<div class="ServiceCard">
						<br><br><br><br><br><br><br><br><br><br>
						Service
						<br><br><br><br><br><br><br><br><br><br></div>
					</div>
                    <div class="tab-pane fade" id="Info" role="tabpanel" aria-labelledby="Info-tab">
						<div class="InfoCard">
							<div class="container">
								<div class="row mapRow">
									<div class="col-6" style="border:1px black solid;">
										<h4>myMap</h4>
										<hr>
										<ui class="solInfo">
											<li>地址:</li>
											<li>營業時間:</li>
											<li>電話:</li>
										</ui>
									</div>
									<div class="col-6">
							    		<div id="map" style="border:1px red solid;"></div>
									</div>
								</div>
							</div>
							<br><br><br><br><br><br><br><br>
						</div>
					</div>
                </div>
            </div>
        </div>
    </div>
    
							    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAgth_SXMI_V6SbxEmCxOFwzUwCXAizZhY&callback=initMap&libraries=&v=weekly" async></script>
<!-- Post Modal -->
    <c:if test="${openModal != null}" >
            <div class="modal fade" id="postModal" tabindex="-1"  aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable listOne">
                    <div class="modal-content">
                            <button type="button" class="postClose text-right" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        <div class="modal-body p-0 m-0">
                        	<div class="includePage">
                            	<jsp:include page="/front-end/Comment/listPostWithComments_front.jsp" />
                        	</div>
                        </div>
                    </div>
                </div>
            </div>
	</c:if>
<!-- Post END -->
<!-- Login Modal -->
		    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		        <div class="modal-dialog modal-dialog-centered">
		            <div class="modal-content">
		                <div class="modal-header">
		                    <h5 class="modal-title" id="exampleModalLabel">登入</h5>
		                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                        <span aria-hidden="true">&times;</span>
		                    </button>
		                </div>
		                <div class="modal-body">
		                    ...
		                </div>
		                <div class="modal-footer">
		                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		                    <button type="button" class="btn btn-primary">Save changes</button>
		                </div>
		            </div>
		        </div>
		    </div>
<!-- Login Modal END -->
        <script src="<%=request.getContextPath()%>/dist/js/jquery.min.js"></script>
        <script src="<%=request.getContextPath()%>/dist/js/jquery-migrate-3.0.1.min.js"></script>
        <script src="<%=request.getContextPath()%>/dist/js/jquery.easing.1.3.js"></script>
        <script src="<%=request.getContextPath()%>/dist/js/jquery.waypoints.min.js"></script><!-- << -->
        <script src="<%=request.getContextPath()%>/dist/js/jquery.stellar.min.js"></script>
        <script src="<%=request.getContextPath()%>/dist/js/jquery.magnific-popup.min.js"></script>
        <script src="<%=request.getContextPath()%>/dist/js/jquery.animateNumber.min.js"></script>
        <script src="<%=request.getContextPath()%>/dist/js/jquery.timepicker.min.js"></script>
        <script src="<%=request.getContextPath()%>/dist/js/bootstrap.min.js"></script>
        <script src="<%=request.getContextPath()%>/dist/js/bootstrap-datepicker.js"></script>
        <script src="<%=request.getContextPath()%>/dist/js/popper.min.js"></script>
        <script src="<%=request.getContextPath()%>/dist/js/aos.js"></script>
        <script src="<%=request.getContextPath()%>/dist/js/owl.carousel.min.js"></script><!-- << -->
        <script src="<%=request.getContextPath()%>/dist/js/scrollax.min.js"></script>
        <script src="<%=request.getContextPath()%>/dist/js/main.js"></script>
        <script src="<%=request.getContextPath()%>/dist/slick/slick.min.js"></script>
</body>
<script>
	$('#loginModal').on('shown.bs.modal', function() {
	    $('#myInput').trigger('focus')
	})
	$("#postModal").modal({show: true});
	
	$(document).ready(function(){
		$('#followBtn').on('click',function(){
			var obj = {
					memNo:${not empty memVO.memNo?memVO.memNo:"null"},
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
// 				$('#followBtn').css("background-color", "yellow");
// 				$('#followBtn').text("Unfollow");
// 				$('#followBtn:contains("Follow")').css("background-color", "yellow");
				}
		});
		
	});
	
// MAP
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