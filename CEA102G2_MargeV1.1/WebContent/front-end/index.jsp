<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
    <title>Hairtopia Post</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Prata&display=swap">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/animate.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/owl.carousel.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/magnific-popup.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/aos.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/jquery.timepicker.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/tagify/tagify.css">
    <script src="<%=request.getContextPath()%>/dist/js/jquery-3.2.1.min.js"></script>
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
	
</head>
<style>
	   .navbar-brand img{
		width: 250px;
		margin: 0;
	}
	.navbar-nav{
		margin-right: 1em;
	}
	/* .navbar-icon i{font-size: 2em;
	display: flex;
	margin-right: 0.25em;
	justify-content: center;
	align-items: center;
	padding-left: 10px;
	padding-right: 10px;
	padding-top: 10px;
	} */
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
    <!--Carousel Wrapper-->
    <div id="video-carousel-example2" class="carousel slide carousel-fade js-fullheight " data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#video-carousel-example2" data-slide-to="0" class="active"></li>
            <li data-target="#video-carousel-example2" data-slide-to="1"></li>
            <li data-target="#video-carousel-example2" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner js-fullheight" role="listbox">
            <div class="carousel-item active ">
                <div class="view">
                    <video autoplay loop muted>
                        <source src="<%=request.getContextPath()%>/dist/vedio/V1.mp4" type="video/mp4" />
                    </video>
                </div>
                <div class="carousel-caption">
                    <div class="animated fadeInDown">
                        <h3 class="h3-responsive">Light mask</h3>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="view">
                    <video autoplay loop muted>
                        <source src="<%=request.getContextPath()%>/dist/vedio/V2.mp4" type="video/mp4" />
                    </video>
                    <div class="mask rgba-indigo-light"></div>
                </div>
                <div class="carousel-caption">
                    <div class="animated fadeInDown">
                        <h3 class="h3-responsive">Super light mask</h3>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="view">
                    <video autoplay loop muted>
                        <source src="<%=request.getContextPath()%>/dist/vedio/V3.mp4" type="video/mp4" />
                    </video>
                </div>
                <div class="carousel-caption">
                    <div class="animated fadeInDown">
                        <h3 class="h3-responsive">Strong mask</h3>
                    </div>
                </div>
            </div>
        </div>
        <a class="carousel-control-prev" href="#video-carousel-example2" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#video-carousel-example2" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <!-- end Carousel -->
    <!-- choose 3 -->
    <section class="ftco-section bg-light">
        <div class="container">
            <div class="row justify-content-center mb-2 pb-3">
                <div class="col-md-7 heading-section ftco-animate text-center">
                    <h3 class="subheading">Hairtopia</h3>
                    <h2 class="mb-1">探索</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 ftco-animate">
                    <div class="block-7">
                        <div class="offer-deal text-center px-2 px-lg-5">
                            <i class="bi bi-search"></i>
                            <div class="text">
                                <h3 class="mb-4">即刻預約</h3>
                                <p class="mb-4">心動不如馬上行動!<br>立即用Hairtopia預約屬於你的髮廊和設計師!</p>
                            </div>
                            <div id="infoBtn">
                                <a href="#" class="btn btn-primary d-block px-2 py-4"> 預約 </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 ftco-animate">
                    <div class="block-7">
                        <div class="offer-deal text-center px-2 px-lg-5">
                            <i class="bi bi-newspaper"></i>
                            <div class="text">
                                <h3 class="mb-4">風格貼文</h3>
                                <p class="mb-4">在茫茫設計師海中迷路了嗎?<br>Hairtopia設計師風格貼文，帶您找到喜歡的設計Style!</p>
                            </div>
                            <div id="infoBtn">
                                <a href="#" class="btn btn-primary d-block px-2 py-4"> 立即前往 </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 ftco-animate">
                    <div class="block-7">
                        <div class="offer-deal text-center px-2 px-lg-5">
                            <i class="bi bi-cart4"></i>
                            <div class="text">
                                <h3 class="mb-4">髮品商城</h3>
                                <p class="mb-4">潮・無需等待。<br>Hairtopia髮品商城，下訂前到貨，<br>均一價8888。</p>
                            </div>
                            <div id="infoBtn">
                                <a href="#" class="btn btn-primary d-block px-2 py-4"> 前往商城 </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- end choose 3 -->
    <div class="container">
        <div class="row justify-content-around">
            <div class="col-4 " style="width:18rem;">
                <div class="card">
                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid ">
                    <div class="item card-body">
                        <h5 class="card-title">Card title</h5>
                        <p class="card-text">Lorem ipsum dolor sit amet consectetur adipisicing elit. Eos, iusto.</p>
                        <a href="#" class="btn btn-outline-secondary">Go somewhere</a>
                    </div>
                </div>
            </div>
            <div class="col-4 " style="width:18rem;">
                <div class="card">
                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid ">
                    <div class="item card-body">
                        <h5 class="card-title">Card title</h5>
                        <p class="card-text">Lorem ipsum dolor sit amet consectetur adipisicing elit. Eos, iusto.</p>
                        <a href="#" class="btn btn-outline-secondary">Go somewhere</a>
                    </div>
                </div>
            </div>
            <div class="col-4 " style="width:18rem;">
                <div class="card">
                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid ">
                    <div class="item card-body">
                        <h5 class="card-title">Card title</h5>
                        <p class="card-text">Lorem ipsum dolor sit amet consectetur adipisicing elit. Eos, iusto.</p>
                        <a href="#" class="btn btn-outline-secondary">Go somewhere</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--  -->
    <!-- Hot post -->
    <section class="ftco-gallery ftco-section">
        <div class="container">
            <div class="row justify-content-center mb-5 pb-3">
                <div class="col-md-7 heading-section ftco-animate text-center">
                    <h3 class="subheading">Hot</h3>
                    <h2 class="mb-1">熱門貼文</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3 ftco-animate">
                    <a href="<%=request.getContextPath()%>/dist/images/gallery-1.jpg" class="gallery image-popup img d-flex align-items-center" style="background-image: url(<%=request.getContextPath()%>/dist/images/gallery-1.jpg);">
                        <div class="icon mb-4 d-flex align-items-center justify-content-center">
                            <span class="icon-instagram"></span>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 ftco-animate">
                    <a href="<%=request.getContextPath()%>/dist/images/gallery-2.jpg" class="gallery image-popup img d-flex align-items-center" style="background-image: url(<%=request.getContextPath()%>/dist/images/gallery-2.jpg);">
                        <div class="icon mb-4 d-flex align-items-center justify-content-center">
                            <span class="icon-instagram"></span>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 ftco-animate">
                    <a href="<%=request.getContextPath()%>/dist/images/gallery-3.jpg" class="gallery image-popup img d-flex align-items-center" style="background-image: url(<%=request.getContextPath()%>/dist/images/gallery-3.jpg);">
                        <div class="icon mb-4 d-flex align-items-center justify-content-center">
                            <span class="icon-instagram"></span>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 ftco-animate">
                    <a href="<%=request.getContextPath()%>/dist/images/gallery-4.jpg" class="gallery image-popup img d-flex align-items-center" style="background-image: url(<%=request.getContextPath()%>/dist/images/gallery-4.jpg);">
                        <div class="icon mb-4 d-flex align-items-center justify-content-center">
                            <span class="icon-instagram"></span>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </section>
    <!-- end Hot post -->
    <section class="ftco-section testimony-section">
        <div class="container">
            <div class="row justify-content-center mb-5 pb-3">
                <div class="col-md-10 heading-section ftco-animate text-center">
                    <h3 class="subheading">Testimony</h3>
                    <h2 class="mb-1">Successful Stories</h2>
                </div>
            </div>
            <div class="row ftco-animate">
                <div class="col-md-12">
                    <div class="carousel-testimony owl-carousel">
                        <div class="item">
                            <div class="testimony-wrap p-4 pb-5">
                                <div class="text">
                                    <div class="line pl-5">
                                        <p class="mb-4 pb-1">Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
                                        <span class="quote d-flex align-items-center justify-content-center">
                                            <i class="icon-quote-left"></i>
                                        </span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <div class="user-img" style="background-image: url(<%=request.getContextPath()%>/dist/images/person_1.jpg)">
                                        </div>
                                        <div class="ml-4">
                                            <p class="name">Gabby Smith</p>
                                            <span class="position">Customer</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimony-wrap p-4 pb-5">
                                <div class="text">
                                    <div class="line pl-5">
                                        <p class="mb-4 pb-1">Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
                                        <span class="quote d-flex align-items-center justify-content-center">
                                            <i class="icon-quote-left"></i>
                                        </span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <div class="user-img" style="background-image: url(<%=request.getContextPath()%>/dist/images/person_2.jpg)">
                                        </div>
                                        <div class="ml-4">
                                            <p class="name">Floyd Weather</p>
                                            <span class="position">Customer</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimony-wrap p-4 pb-5">
                                <div class="text">
                                    <div class="line pl-5">
                                        <p class="mb-4 pb-1">Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
                                        <span class="quote d-flex align-items-center justify-content-center">
                                            <i class="icon-quote-left"></i>
                                        </span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <div class="user-img" style="background-image: url(<%=request.getContextPath()%>/dist/images/person_3.jpg)">
                                        </div>
                                        <div class="ml-4">
                                            <p class="name">James Dee</p>
                                            <span class="position">Customer</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimony-wrap p-4 pb-5">
                                <div class="text">
                                    <div class="line pl-5">
                                        <p class="mb-4 pb-1">Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
                                        <span class="quote d-flex align-items-center justify-content-center">
                                            <i class="icon-quote-left"></i>
                                        </span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <div class="user-img" style="background-image: url(<%=request.getContextPath()%>/dist/images/person_4.jpg)">
                                        </div>
                                        <div class="ml-4">
                                            <p class="name">Lance Roger</p>
                                            <span class="position">Customer</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimony-wrap p-4 pb-5">
                                <div class="text">
                                    <div class="line pl-5">
                                        <p class="mb-4 pb-1">Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
                                        <span class="quote d-flex align-items-center justify-content-center">
                                            <i class="icon-quote-left"></i>
                                        </span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <div class="user-img" style="background-image: url(<%=request.getContextPath()%>/dist/images/person_2.jpg)">
                                        </div>
                                        <div class="ml-4">
                                            <p class="name">Kenny Bufer</p>
                                            <span class="position">Customer</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="ftco-section bg-light">
        <div class="container">
            <div class="row justify-content-center mb-5 pb-3">
                <div class="col-md-7 heading-section ftco-animate text-center">
                    <h3 class="subheading">Blog</h3>
                    <h2 class="mb-1">Recent Posts</h2>
                </div>
            </div>
            <div class="row d-flex">
                <div class="col-md-4 d-flex ftco-animate">
                    <div class="blog-entry justify-content-end">
                        <a href="blog-single.html" class="block-20" style="background-image: url('<%=request.getContextPath()%>/dist/images/image_1.jpg');">
                        </a>
                        <div class="text p-4 float-right d-block">
                            <div class="d-flex align-items-center pt-2 mb-4">
                                <div class="one">
                                    <span class="day">25</span>
                                </div>
                                <div class="two">
                                    <span class="yr">2019</span>
                                    <span class="mos">September</span>
                                </div>
                            </div>
                            <h3 class="heading mt-2"><a href="#">Is wellness the new luxury</a></h3>
                            <p>A small river named Duden flows by their place and supplies it with the necessary regelialia.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 d-flex ftco-animate">
                    <div class="blog-entry justify-content-end">
                        <a href="blog-single.html" class="block-20" style="background-image: url('<%=request.getContextPath()%>/dist/images/image_2.jpg');">
                        </a>
                        <div class="text p-4 float-right d-block">
                            <div class="d-flex align-items-center pt-2 mb-4">
                                <div class="one">
                                    <span class="day">25</span>
                                </div>
                                <div class="two">
                                    <span class="yr">2019</span>
                                    <span class="mos">September</span>
                                </div>
                            </div>
                            <h3 class="heading mt-2"><a href="#">Is wellness the new luxury</a></h3>
                            <p>A small river named Duden flows by their place and supplies it with the necessary regelialia.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 d-flex ftco-animate">
                    <div class="blog-entry">
                        <a href="blog-single.html" class="block-20" style="background-image: url('<%=request.getContextPath()%>/dist/images/image_3.jpg');">
                        </a>
                        <div class="text p-4 float-right d-block">
                            <div class="d-flex align-items-center pt-2 mb-4">
                                <div class="one">
                                    <span class="day">25</span>
                                </div>
                                <div class="two">
                                    <span class="yr">2019</span>
                                    <span class="mos">September</span>
                                </div>
                            </div>
                            <h3 class="heading mt-2"><a href="#">Is wellness the new luxury</a></h3>
                            <p>A small river named Duden flows by their place and supplies it with the necessary regelialia.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <footer class="ftco-footer ftco-section">
        <div class="container">
            <div class="row d-flex">
                <div class="col-md">
                    <div class="ftco-footer-widget mb-4">
                        <h2 class="ftco-heading-2">Energen</h2>
                        <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
                        <ul class="ftco-footer-social list-unstyled float-lft mt-3">
                            <li class="ftco-animate"><a href="#"><span class="icon-twitter"></span></a></li>
                            <li class="ftco-animate"><a href="#"><span class="icon-facebook"></span></a></li>
                            <li class="ftco-animate"><a href="#"><span class="icon-instagram"></span></a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md">
                    <div class="ftco-footer-widget mb-4 ml-md-4">
                        <h2 class="ftco-heading-2">Popular Links</h2>
                        <ul class="list-unstyled">
                            <li><a href="#">Aromatheraphy</a></li>
                            <li><a href="#">Skin Care</a></li>
                            <li><a href="#">Herbal Spa</a></li>
                            <li><a href="#">Body Massage</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md">
                    <div class="ftco-footer-widget mb-4">
                        <h2 class="ftco-heading-2">Quick Links</h2>
                        <ul class="list-unstyled">
                            <li><a href="#">About</a></li>
                            <li><a href="#">Our Spa</a></li>
                            <li><a href="#">Treatments</a></li>
                            <li><a href="#">Specialists</a></li>
                            <li><a href="#">Contact</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md">
                    <div class="ftco-footer-widget mb-4">
                        <h2 class="ftco-heading-2">Have a Questions?</h2>
                        <div class="block-23 mb-3">
                            <ul>
                                <li><span class="icon icon-map-marker"></span><span class="text">203 Fake St. Mountain View, San Francisco, California, USA</span></li>
                                <li><a href="#"><span class="icon icon-phone"></span><span class="text">+2 392 3929 210</span></a></li>
                                <li><a href="#"><span class="icon icon-envelope"></span><span class="text">info@yourdomain.com</span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 text-center">
                    <p class="mb-0">
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        Copyright &copy;<script>
        document.write(new Date().getFullYear());
                        </script> All rights reserved | This template is made with <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    </p>
                </div>
            </div>
        </div>
    </footer>
</body>
	<script src="<%=request.getContextPath()%>/dist/js/aos.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/owl.carousel.min.js"></script><!-- << -->
	<script src="<%=request.getContextPath()%>/dist/js/scrollax.min.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/main.js"></script>
	<script src="<%=request.getContextPath()%>/dist/tagify/jQuery.tagify.min.js"></script>
</html>