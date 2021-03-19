<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>
<%@ page import="com.designer.model.*"%>

<jsp:useBean id="postSvc" scope="page"
	class="com.post.model.PostService" />
<jsp:useBean id="desSvc" scope="page"
	class="com.designer.model.DesignerService" />
<jsp:useBean id="salSvc" scope="page"
	class="com.salon.model.SalonService" />
<jsp:useBean id="trendSvc" scope="page"
	class="com.trend.model.TrendService" />

<!DOCTYPE html>
<html lang="en">

<head>
<title>Hairtopia</title>
<meta charset="utf-8">
<%@include file="/front-end/tempFile/head"%>
</head>
<style>
.slick-prev:before, .slick-next:before {
	color: #D8CF9E;
	font-size: 25px;
}

.carousel-caption {
	top: 40%;
	font-family: 'Playball', cursive;
	color: #F8F7F1;
}

.carouselFont {
	font-size: 5rem;
}

.myVideo {
	width: 100%;
}
</style>
<style>
.ftco-navbar-light {
	position: static;
}

/* postCSS */
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
/* postCSS END */

/* Whole post Css */
#postModal .modal-dialog {
	max-width: 70%;
}

#postModal .close {
	margin-top: -15px;
	margin-right: -10px;
}

div.comDisplay {
	overflow-y: auto;
	height: 300px;
}

img {
	max-width: 100%;
}

#tags div {
	text-transform: uppercase;
	display: inline-block;
	padding: 4px 10px;
	margin-bottom: 7px;
	margin-right: 4px;
	border-radius: 4px;
	color: #000;
	border: 1px solid #e6e6e6;
	font-size: 11px;
}
/* Whole post Css END */
</style>
<body>
	<%@include file="/front-end/tempFile/navBar"%>

	<!-- Begin Page Content -->
	<div class="container-fluid px-0">
		<!--Carousel Wrapper-->
		<div id="video-carousel-example2"
			class="carousel slide carousel-fade js-fullheight "
			data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#video-carousel-example2" data-slide-to="0"
					class="active"></li>
				<li data-target="#video-carousel-example2" data-slide-to="1"></li>
				<li data-target="#video-carousel-example2" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner js-fullheight" role="listbox">
				<div class="carousel-item active ">
					<div class="view">
						<video class="myVideo" autoplay loop muted>
							<source src="<%=request.getContextPath()%>/dist/vedio/V1.mp4"
								type="video/mp4" />
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
							<source src="<%=request.getContextPath()%>/dist/vedio/V2.mp4"
								type="video/mp4" />
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
							<source src="<%=request.getContextPath()%>/dist/vedio/V3.mp4"
								type="video/mp4" />
						</video>
					</div>
					<div class="carousel-caption">
						<div class="animated fadeInDown">
							<div class="carouselFont">PenPineappleApplePen</div>
						</div>
					</div>
				</div>
			</div>
			<a class="carousel-control-prev" href="#video-carousel-example2"
				role="button" data-slide="prev"> <span
				class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="sr-only">Previous</span>
			</a> <a class="carousel-control-next" href="#video-carousel-example2"
				role="button" data-slide="next"> <span
				class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="sr-only">Next</span>
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
									<p class="mb-4">
										心動不如馬上行動!<br>立即用Hairtopia預約屬於你的髮廊和設計師!
									</p>
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
									<p class="mb-4">
										在茫茫設計師海中迷路了嗎?<br>Hairtopia設計師風格貼文，帶您找到喜歡的設計Style!
									</p>
								</div>
								<div id="infoBtn">
									<a href="#" class="btn btn-primary d-block px-2 py-4"> 立即前往
									</a>
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
									<p class="mb-4">
										潮・無需等待。<br>Hairtopia髮品商城，下訂前到貨，<br>均一價8888。
									</p>
								</div>
								<div id="infoBtn">
									<a href="#" class="btn btn-primary d-block px-2 py-4"> 前往商城
									</a>
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
								<img
									src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}"
									class="card-img-top post-img img-fluid" />
							</div>
							</a>
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
					
						<div class="card" style="width: 18rem;">
							<a href="<%=request.getContextPath()%>/designer/designer.do?action=getOne_For_Display&desNo=${designerVO.desNo}" >
							<img class="img-fluid" src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}" class="card-img-top" alt="...">
								<h5 class="card-title">${designerVO.desName }</h5>	
							</a>
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
				<div class="row justify-content-between slidemove">
					 <c:forEach  var="salonVO" items="${salSvc.pickup5Sal()}"> 
					 
						 <div class="card" style="width: 20rem;">
							<a href="<%=request.getContextPath()%>/salon/salon.do?action=getOne_For_Display&salNo=${salonVO.salNo}" >
<!-- 							這邊有問題 salon沒有照片 如果此欄位需要，是否要找一些圖片隨機放上去? -->
							<img class="img-fluid" src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}" class="card-img-top" alt="...">
								<h5 class="card-title">${salonVO.salName }</h5>	
							</a>
						</div>	            
						 	            
					  </c:forEach> 
					
				</div>
			</div>
		</section>
		<!-- end Hot Salon -->

		<!-- Hot Trand -->
		<section class="ftco-gallery ftco-section">
			<div class="container px-5">
				<div class="row justify-content-center mb-5 pb-3">
					<div class="col-md-7 heading-section ftco-animate text-center">
						<h3 class="subheading">Styling</h3>
						<h2 class="mb-1">最新潮流</h2>
					</div>
				</div>
				<div class="row justify-content-between slidemove">
					<%-- 	            	<c:forEach  var="trendVO" items="${trendSvc.pickup5Trend()}">   --%>
					<%--  		            </c:forEach> --%>
					<div class="col-2 ">
						<div class="card">
							<img src=" https://picsum.photos/400/500?random=1"
								class="card-img-top img-fluid ">
						</div>
					</div>
					<div class="col-2 ">
						<div class="card">
							<img src=" https://picsum.photos/400/500?random=1"
								class="card-img-top img-fluid ">
						</div>
					</div>
					<div class="col-2 ">
						<div class="card">
							<img src=" https://picsum.photos/400/500?random=1"
								class="card-img-top img-fluid ">
						</div>
					</div>
					<div class="col-2 ">
						<div class="card">
							<img src=" https://picsum.photos/400/500?random=1"
								class="card-img-top img-fluid ">
						</div>
					</div>
					<div class="col-2 ">
						<div class="card">
							<img src=" https://picsum.photos/400/500?random=1"
								class="card-img-top img-fluid ">
						</div>
					</div>
					<div class="col-2 ">
						<div class="card">
							<img src=" https://picsum.photos/400/500?random=1"
								class="card-img-top img-fluid ">
						</div>
					</div>
					<div class="col-2 ">
						<div class="card">
							<img src=" https://picsum.photos/400/500?random=1"
								class="card-img-top img-fluid ">
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- end Hot Trand -->
	</div>

	<!-- POST MODAL -->

	<div class="modal fade" id="postModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-6 pl-0">
								<div id="carouselPostIndicators" class="carousel slide"
									data-ride="carousel">
									<div class="carousel-inner"></div>
								</div>
							</div>
							<div class="col-md-6 p-0">
								<div class="card-title" id="postTitle">
									<h2></h2>
									<h5 class="m-0"></h5>
									<div id="tags"></div>
									<small class="text-muted" id="postTime"></small>
								</div>
								<p class="card-text">
									<div class="comDisplay">
                                        <ul class="list-unstyled"
										id="comList">
                                        </ul>
                                    </div>
                                    <!--  有會員之後要判斷出刪除、修改按鈕 -->
                                    <form method="post"
									action="<%=request.getContextPath()%>/comment/comment.do">
                                        <div class="input-group">
                                            <input type="text"
											class="form-control" placeholder="輸入留言" name="comCon">
                                            <input type="hidden"
											name="postNo" value="${postVO.postNo}">
                                            <input type="hidden"
											name="memNo" value="1"> <input type="hidden"
											name="action" value="insert_Front">
                                            <button
											class="btn btn-outline-secondary" type="submit">留言</button>
                                        </div>
                                    </form>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<!-- POST MODAL END -->
<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer"%>
<%@include file="/front-end/tempFile/tempJs"%>

</body>
<script>
var contextPath = "<%=request.getContextPath()%>";
$('.slidemove').slick({
	  slidesToShow: 4,
	  slidesToScroll: 1,
	  autoplay: true,
	  autoplaySpeed: 2000,
	});
	
	
	

</script>
									<script>
// post modal js start

$(document).ready(function(){
		$('.onePost').on('click',function(){
			$.ajax({
				type:"GET",
				url:contextPath+"/post/post.do",
				data:{
						action:"getWholePost",							
						postNo:$(this).attr('id'),
					},
				success:function(data){
					//console.log(data);
					emptyModal();
					var jData = JSON.parse(data);
					
					var commentList = jData.commentList;
					var postVo = jData.postVo;
					var tagNameList = jData.tagNameList;
					
					showWholePost(commentList, postVo, tagNameList);
// 					console.log(commentList.);
// 					console.log(postVo);
// 					console.log(tagNameList);
					$('#postModal').modal('show');
				},
				error:function(){
					console.log("AJAX ERROR!");
				},
			});
		});
	});
	
function showWholePost(commentList, postVo, tagNameList) {
    $('#carouselPostIndicators .carousel-inner').append(`<div class="carousel-item active">
                                							<img src="` + contextPath + `/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=` + postVo.postNo + `" class="card-img-top" /></div>`);
    if (postVo.postPic2 != null || postVo.postPic3 != null) {
        $('#carouselPostIndicators').prepend(`<ol class="carousel-indicators">
												<li data-target="#carouselPostIndicators" data-slide-to="0"
													class="active"></li></ol>`);
        if (postVo.postPic2 != null) {
            $('#carouselPostIndicators .carousel-indicators').append(`<li data-target="#carouselPostIndicators" data-slide-to="1"></li>`);
            $('#carouselPostIndicators .carousel-inner').append(`<div class="carousel-item">
                                							<img src="` + contextPath + `/PicFinder?pic=1&table=post&column=postPic2&idname=postNo&id=` + postVo.postNo + `" class="card-img-top" /></div>`);
        }
        if (postVo.postPic3 != null) {
            $('#carouselPostIndicators .carousel-indicators').append(`<li data-target="#carouselPostIndicators" data-slide-to="2"></li>`);
            $('#carouselPostIndicators .carousel-inner').append(`<div class="carousel-item">
                                							<img src="` + contextPath + `/PicFinder?pic=1&table=post&column=postPic3&idname=postNo&id=` + postVo.postNo + `" class="card-img-top" /></div>`);
        }
        $('#carouselPostIndicators').prepend(`<a class="carousel-control-prev" href="#carouselPostIndicators" role="button" data-slide="prev"> <span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="sr-only">Previous</span>
                                </a>
                                <a class="carousel-control-next" href="#carouselPostIndicators" role="button" data-slide="next"> <span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="sr-only">Next</span>
                                </a>`);

    }
        // post pic 設置完成

        $('#postTitle h2').append(postVo.desNo);
        $('#postTitle h5').append(postVo.postCon);
        $.each(tagNameList, function(index,value) {
            $('#tags').append(`<div>` + value + `</div>`);
        })
        $('#postTime').append( postVo.postTime);

        //post title 設置完成

        $.each(commentList, function(index,item) {
            if (item.comStatus != false) {
                $('#comList').append(`<li class="media">` + `
                                                <!--            會員頭貼                  <img src="..." class="mr-3" alt="..."> -->` +
                    `<div class="media-body">
                                                    <h5 class="mt-0 mb-1">` + item.memNo + `</h5>
                                                    <p class="comCon">` + item.comCon + `</p>
                                                    <small class="text-muted comTime">` + item.comTime + `</small>
                                                </div>
                                            </li>`);
            }
        });
}

function emptyModal(){
	$('#carouselPostIndicators .carousel-inner').empty();
	$('#carouselPostIndicators .carousel-indicators').remove();
	$('#carouselPostIndicators a').remove();
	$('#postTitle h2').empty();
	$('#postTitle h5').empty();
	$('#tags').empty();
	$('#postTime').empty();
	$('#comList').empty();
	
	
}
//post modal end
</script>


								</html>