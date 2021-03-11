<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Hairtopia</title>
    <meta charset="utf-8">
	<%@include file="/front-end/tempFile/head" %>
</head>
<style>
.slick-prev:before, .slick-next:before{
	color: #D8CF9E;
	font-size: 25px;
}
</style>

<body>
<%@include file="/front-end/tempFile/navBar" %>
<!-- Begin Page Content -->
<div class="container-fluid px-0">
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
    <div class="container px-5">
        <div class="row justify-content-between slidemove">
	        <button type="button" data-role="none" class="slick-prev slick-arrow" aria-label="Previous" role="button" style="display: block;">
<!-- 	        	<i class="bi bi-chevron-left"></i> -->
	        </button>
            <div class="col-2 ">
                <div class="card">
                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid ">
                </div>
            </div>
            <div class="col-2 ">
                <div class="card">
                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid ">
                </div>
            </div>
            <div class="col-2 ">
                <div class="card">
                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid ">
                </div>
            </div>
            <div class="col-2 ">
                <div class="card">
                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid ">
                </div>
            </div>
            <div class="col-2 ">
                <div class="card">
                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid ">
                </div>
            </div>
            <div class="col-2 ">
                <div class="card">
                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid ">
                </div>
            </div>
            <div class="col-2 ">
                <div class="card">
                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid ">
                </div>
            </div>
        </div>
    </div>
	    <button type="button" data-role="none" class="slick-next slick-arrow" aria-label="Next" role="button" style="display: block;">
<!-- 	    	<i class="bi bi-chevron-right "></i> -->
	    </button>
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
                    <a href="images/gallery-1.jpg" class="gallery image-popup img d-flex align-items-center" style="background-image: url(images/gallery-1.jpg);">
                        <div class="icon mb-4 d-flex align-items-center justify-content-center">
                            <span class="icon-instagram"></span>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 ftco-animate">
                    <a href="images/gallery-2.jpg" class="gallery image-popup img d-flex align-items-center" style="background-image: url(images/gallery-2.jpg);">
                        <div class="icon mb-4 d-flex align-items-center justify-content-center">
                            <span class="icon-instagram"></span>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 ftco-animate">
                    <a href="images/gallery-3.jpg" class="gallery image-popup img d-flex align-items-center" style="background-image: url(images/gallery-3.jpg);">
                        <div class="icon mb-4 d-flex align-items-center justify-content-center">
                            <span class="icon-instagram"></span>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 ftco-animate">
                    <a href="images/gallery-4.jpg" class="gallery image-popup img d-flex align-items-center" style="background-image: url(images/gallery-4.jpg);">
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
                                        <div class="user-img" style="background-image: url(images/person_1.jpg)">
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
                                        <div class="user-img" style="background-image: url(images/person_2.jpg)">
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
                                        <div class="user-img" style="background-image: url(images/person_3.jpg)">
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
                                        <div class="user-img" style="background-image: url(images/person_4.jpg)">
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
                                        <div class="user-img" style="background-image: url(images/person_2.jpg)">
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
                        <a href="blog-single.html" class="block-20" style="background-image: url('images/image_1.jpg');">
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
                        <a href="blog-single.html" class="block-20" style="background-image: url('images/image_2.jpg');">
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
                        <a href="blog-single.html" class="block-20" style="background-image: url('images/image_3.jpg');">
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
    </div>
<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>
<script>
$('.slidemove').slick({
	  slidesToShow: 5,
	  slidesToScroll: 1,
	  autoplay: true,
	  autoplaySpeed: 2000,
	});
</script>

</html>