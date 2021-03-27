<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>
<%@ page import="com.designer.model.*"%>

<jsp:useBean id="postSvc"  scope="page" class="com.post.model.PostService" />
<jsp:useBean id="desSvc"  scope="page" class="com.designer.model.DesignerService" />
<jsp:useBean id="salSvc"  scope="page" class="com.salon.model.SalonService" />
<jsp:useBean id="trendSvc"  scope="page" class="com.trend.model.TrendService" />
<jsp:useBean id="proSvc"  scope="page" class="com.product.model.ProductService" />

<!DOCTYPE html>
<html lang="en">

<head>
<title>Hairtopia</title>
<meta charset="utf-8">
<%@include file="/front-end/tempFile/head"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/post.css">
</head>
<style>
.slick-prev:before, .slick-next:before {
	color: #D8CF9E;
	font-size: 25px;
}
.carousel-caption{
	top:40%;
	font-family: 'Playball', cursive;
	color:#F8F7F1;
}
.carouselFont{
	font-size:5rem;
}
.myVideo {
	width: 100%;
}
</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid px-0">
    <!--Carousel Wrapper-->
    <div id="video-carousel-example2" class="carousel slide carousel-fade js-fullheight " data-ride="carousel" >
        <ol class="carousel-indicators">
            <li data-target="#video-carousel-example2" data-slide-to="0" class="active"></li>
            <li data-target="#video-carousel-example2" data-slide-to="1"></li>
            <li data-target="#video-carousel-example2" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner js-fullheight" role="listbox">
            <div class="carousel-item active ">
                <div class="view">
                    <video class="myVideo" autoplay loop muted>
                        <source src="<%=request.getContextPath()%>/dist/vedio/V1.mp4" type="video/mp4" />
                    </video>
                </div>
                <div class="carousel-caption">
                    <div class="animated fadeInDown">
                        <div class="carouselFont">ApplePen</div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="view">
                    <video class="myVideo" autoplay loop muted>
                        <source src="<%=request.getContextPath()%>/dist/vedio/V2.mp4" type="video/mp4" />
                    </video>
                    <div class="mask rgba-indigo-light"></div>
                </div>
                <div class="carousel-caption">
                    <div class="animated fadeInDown">
                        <div class="carouselFont">PineapplePen</div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="view">
                    <video class="myVideo" autoplay loop muted>
                        <source src="<%=request.getContextPath()%>/dist/vedio/V3.mp4" type="video/mp4" />
                    </video>
                </div>
                <div class="carousel-caption">
                    <div class="animated fadeInDown">
                        <div class="carouselFont">PenPineappleApplePen</div>
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
                                <h3 class="mb-4">尋找設計師</h3>
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
                                <a href="<%=request.getContextPath()%>/front-end/Post/ListAllPost_AJAX.jsp" class="btn btn-primary d-block px-2 py-4"> 立即前往 </a>
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
                                <a href="<%=request.getContextPath()%>/front-end/product/EShop2.jsp" class="btn btn-primary d-block px-2 py-4"> 前往商城 </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- end choose 3 -->
    <!-- Hot post -->
    <section class="ftco-gallery ftco-section">
        <div class="container px-5">
            <div class="row justify-content-center mb-5 pb-3">
                <div class="col-md-7 heading-section ftco-animate text-center">
                    <h3 class="subheading">Post</h3>
                    <h2 class="mb-1">熱門貼文</h2>
                </div>
            </div>
	            <div class="row justify-content-between slidemove">
	            <c:forEach var="postVO" items="${postSvc.pickup5Post()}">
					<div class="col-2 ">
						<div class="card onePost" id="${postVO.postNo}">
							<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}"
							 class="card-img-top post-img img-fluid" />
						</div>
					</div>
				</c:forEach>
	        </div>
        </div>
    </section>
    <!-- end Hot post -->
    
<!-- Hot Designer -->
	<section class="ftco-gallery ftco-section">
        <div class="container px-5">
            <div class="row justify-content-center mb-5 pb-3">
                <div class="col-md-7 heading-section ftco-animate text-center">
                    <h3 class="subheading">Designer</h3>
                    <h2 class="mb-1">熱門設計師</h2>
                </div>
            </div>
	            <div class="row justify-content-between slidemove">
	            	<c:forEach var="designerVO" items="${desSvc.pickup5Des()}">
						<div class="col-2 ">
							<div class="card">
								<a href="<%=request.getContextPath()%>/designer/designer.do?action=getOne_For_Display&desNo=${designerVO.desNo}" >
								<img class="img-fluid" src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}" class="card-img-top" alt="...">
									<h5 class="card-title">${designerVO.desName}</h5>	
								</a>
							</div>
						</div>
					</c:forEach>
	        </div>
        </div>
    </section>
<!-- end Hot Designer -->

<!-- Hot Salon -->
	<section class="ftco-gallery ftco-section">
        <div class="container px-5">
            <div class="row justify-content-center mb-5 pb-3">
                <div class="col-md-7 heading-section ftco-animate text-center">
                    <h3 class="subheading">Salon</h3>
                    <h2 class="mb-1">熱門髮廊</h2>
                </div>
            </div>
	            <div class="row justify-content-between slidemove2">
	           		 <c:forEach  var="salonVO" items="${salSvc.pickup5Sal()}">
	           		 	    <div class="card mb-3" style="max-width: 505px;">
	           		 	    	<a href="<%=request.getContextPath()%>/salon/salon.do?action=getOne_For_Display&salNo=${salonVO.salNo}" >
						        <div class="row no-gutters">
						            <div class="col-md-4">
						                <img class="img-fluid" src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}" class="card-img-top" alt="...">
						            </div>
						            <div class="col-md-8">
						                <div class="card-body">
						                    <h5 class="card-title">${salonVO.salName }</h5>
						                   <span class="icon icon-map-marker mr-3"><i
											class="bi bi-geo-alt-fill"></i></span><span class="card-text mb-0">${salonVO.salAdd}</span> 
						                    <span class="icon icon-phone mr-3"><i
											class="bi bi-telephone-fill"></i></span> <span class="text">${salonVO.salPhone}</span>
						                </div>
						            </div>
						        </div>
						        </a>
						    </div>
	           		 
	           		  
<!-- 					 	<div class="col-2 "> -->
<!-- 							 <div class="card"> -->
<%-- 								<a href="<%=request.getContextPath()%>/salon/salon.do?action=getOne_For_Display&salNo=${salonVO.salNo}" > --%>
<!-- 	<!-- 							這邊有問題 salon沒有照片 如果此欄位需要，是否要找一些圖片隨機放上去? --> 
<%-- 								<img class="img-fluid" src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}" class="card-img-top" alt="..."> --%>
<%-- 									<h5 class="card-title">${salonVO.salName }</h5>	 --%>
<!-- 								</a> -->
<!-- 							</div>	             -->
<!-- 						</div>          -->
					  </c:forEach> 
	        </div>
        </div>
    </section>
<!-- end Hot Salon -->

<!-- Hot Product -->
	<section class="ftco-gallery ftco-section">
        <div class="container px-5">
            <div class="row justify-content-center mb-5 pb-3">
                <div class="col-md-7 heading-section ftco-animate text-center">
                    <h3 class="subheading">Styling</h3>
                    <h2 class="mb-1">推薦商品</h2>
                </div>
            </div>
	            <div class="row justify-content-between slidemove">
	            
	            	<c:forEach var="productVO" items="${proSvc.pickup5Product()}">
					<div class="col-12">
					<a href="<%=request.getContextPath()%>/product/product.do?action=getOne_For_Display&from=front-end&proNo=${productVO.proNo}">
						<div class="card">
							<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${productVO.proNo}"
							 class="card-img-top post-img img-fluid" />
						</div>
					</a>
					</div>
				</c:forEach>
				
<%-- 	            	<c:forEach  var="trendVO" items="${trendSvc.pickup5Trend()}">   --%>
<%--  		            </c:forEach> --%>
<!-- 	            <div class="col-2 "> -->
<!-- 	                <div class="card"> -->
<!-- 	                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid "> -->
<!-- 	                </div> -->
<!-- 	            </div> -->
<!-- 	            <div class="col-2 "> -->
<!-- 	                <div class="card"> -->
<!-- 	                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid "> -->
<!-- 	                </div> -->
<!-- 	            </div> -->
<!-- 	            <div class="col-2 "> -->
<!-- 	                <div class="card"> -->
<!-- 	                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid "> -->
<!-- 	                </div> -->
<!-- 	            </div> -->
<!-- 	            <div class="col-2 "> -->
<!-- 	                <div class="card"> -->
<!-- 	                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid "> -->
<!-- 	                </div> -->
<!-- 	            </div> -->
<!-- 	            <div class="col-2 "> -->
<!-- 	                <div class="card"> -->
<!-- 	                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid "> -->
<!-- 	                </div> -->
<!-- 	            </div> -->
<!-- 	            <div class="col-2 "> -->
<!-- 	                <div class="card"> -->
<!-- 	                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid "> -->
<!-- 	                </div> -->
<!-- 	            </div> -->
<!-- 	            <div class="col-2 "> -->
<!-- 	                <div class="card"> -->
<!-- 	                    <img src=" https://picsum.photos/400/500?random=1" class="card-img-top img-fluid "> -->
<!-- 	                </div> -->
<!-- 	            </div> -->
	        </div>
        </div>
    </section>
<!-- end Hot Product -->
</div>
<!-- Page Content END -->
<%@include file="/front-end/Post/postModal" %>
<%@include file="/front-end/tempFile/footer"%>
<%@include file="/front-end/tempFile/tempJs"%>
<script src="<%=request.getContextPath()%>/resource/js/postModal.js"></script>

</body>
	<c:if test="${!empty newDesReq}">
			<script type="text/javascript">
					function alertTest() {
					 Swal.fire(
							 "${newDesReq}"
				            );
					}
					
					alertTest();
					
						
			</script>
		</c:if>
<c:if test="${not empty wholePostMap}">
	<script>
			var wholePostMap = '${wholePostMap}';
	</script>
</c:if>
<script>
var contextPath = "<%=request.getContextPath()%>";
$('.slidemove').slick({
	  slidesToShow: 4,
	  slidesToScroll: 1,
	  autoplay: true,
	  autoplaySpeed: 2000,
	});
	
$('.slidemove2').slick({
	  slidesToShow: 2,
	  slidesToScroll: 1,
	  autoplay: true,
	  autoplaySpeed: 2000,
	});	
	

</script>
</html>