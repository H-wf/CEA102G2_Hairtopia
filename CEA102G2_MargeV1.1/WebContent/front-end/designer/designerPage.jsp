<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
	 .img-profile img {
	    vertical-align: middle;
	    border-style: none;
	}
	.dropdown.no-arrow .dropdown-toggle::after {
	    display: none;
	}
	
	.profile-head {
	    transform: translateY(5rem)
	}
	.profileCard{
	    top: 6.5vh;
	    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	
	}
	.profile{
	    /* background: #f7f6e7; */
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
                <a href="#" class="btn btn-outline-primary btn-login">Login</a>
            </ul>
        </div>
    </nav>
    <!-- END nav -->
    <div class="row py-5 px-4">
        <div class="col-md-9 mx-auto profileCard">
            <!-- Profile widget -->
            <div class="bg-white rounded overflow-hidden">
                <div class="px-4 pt-0 pb-4 cover">
                    <div class="media align-items-end profile-head">
                        <div class="profile mr-3"><img src="https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80" alt="..." width="130" class="rounded mb-2 img-thumbnail"><a href="#" class="btn btn-outline-dark btn-sm btn-block">Edit profile</a></div>
                        <div class="media-body mb-5 text-white">
                            <h4 class="mt-0 mb-0">Mark Williams</h4>
                            <p class="small mb-4"> <i class="fas fa-map-marker-alt mr-2"></i>New York</p>
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
                        <p class="font-italic mb-0">Web Developer</p>
                        <p class="font-italic mb-0">Lives in New York</p>
                        <p class="font-italic mb-0">Photographer</p>
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
                        <a class="nav-link" id="Follower-tab" data-toggle="tab" href="#Follower" role="tab" aria-controls="Follower" aria-selected="false">Follower</a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="Post" role="tabpanel" aria-labelledby="Post-tab">
                        <div class="container post">
                            <div class="card-columns ">
                                <!-- Post Card -->
                                <div class="card " data-toggle="modal" data-target="#cardModal">
                                    <img src="https://picsum.photos/300/400?random=1" class="card-img-top post-img">
                                </div>
                                <div class="card " data-toggle="modal" data-target="#cardModal">
                                    <img src="https://picsum.photos/300/400?random=1" class="card-img-top post-img">
                                </div>
                                <div class="card " data-toggle="modal" data-target="#cardModal">
                                    <img src="https://picsum.photos/300/400?random=1" class="card-img-top post-img">
                                </div>
                                <div class="card " data-toggle="modal" data-target="#cardModal">
                                    <img src="https://picsum.photos/300/400?random=1" class="card-img-top post-img">
                                </div>
                                <div class="card " data-toggle="modal" data-target="#cardModal">
                                    <img src="https://picsum.photos/300/400?random=1" class="card-img-top post-img">
                                </div>
                                <div class="card " data-toggle="modal" data-target="#cardModal">
                                    <img src="https://picsum.photos/300/400?random=1" class="card-img-top post-img">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="Service" role="tabpanel" aria-labelledby="Service-tab">
						<div class="ServiceCard">
						<br><br><br><br><br><br><br><br><br><br>
						Service
						<br><br><br><br><br><br><br><br><br><br></div>
					</div>
                    <div class="tab-pane fade" id="Follower" rrole="tabpanel" aria-labelledby="Follower-tab">
						<div class="FollowerCard"><br><br><br><br><br><br><br><br>Follower<br><br><br><br><br><br><br><br></div>
					</div>
                </div>
            </div>
        </div>
    </div>
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
// $('#Post-tab').click(function(){
// 	$('.tab-pane div.ServiceCard','.tab-pane div.FollowerCard').hide();
// });
// $('#Service-tab').click(function(){
// 	$('.tab-pane div.post','.tab-pane div.FollowerCard').hide();
// });
// $('#Follower-tab').click(function(){
// 	$('.tab-pane div.post','.tab-pane div.ServiceCard').hide();
// });
</script>

</html>