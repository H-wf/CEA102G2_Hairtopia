<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>

<jsp:useBean id="postSvc"  scope="page" class="com.post.model.PostService" />
<html>

<head>
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
margin: 0 1rem 0 0;
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
	}
	
	.rounded-circle {
	    border-radius: 50%!important;
	}
	 .img-profile img {
	    vertical-align: middle;
	    border-style: none;
	}
	.dropdown-menu{
		margin:0;
	}
	.dropdown.no-arrow .dropdown-toggle::after {
	    display: none;
	}
	.dropdown-toggle::after{
		display:none;
	}
	.profileBtn{
		padding:0;
	}
	
/* 	navBarCSS */

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
                <li class="nav-item">
                	<div class="dropdown">
						  <button class="btn dropdown-toggle profileBtn" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						    <img class="img-profile rounded-circle" src="<%=request.getContextPath()%>/dist/images/offer-deal-2.jpg">
						  </button>
						  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						    <a class="dropdown-item" href="#">Action</a>
						    <a class="dropdown-item" href="#">Another action</a>
						    <a class="dropdown-item" href="#">Something else here</a>
						  </div>
						</div>
                
                
                    </div>
                </li>
                <a href="#" class="btn btn-outline-primary btn-login" data-toggle="modal" data-target="#loginModal">Login</a>
            </ul>
        </div>
    </nav>
    <!-- END nav -->
   
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
			<a href="<%=request.getContextPath()%>/front-end/post/post.do?postNo=${postVO.postNo}&action=Display_fromListAll" >
				<div class="card">
					<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}"
					 class="card-img-top post-img" data-toggle="modal" data-target="#postModal" />
				</div>
			</a>
		</c:forEach>
		</div>
	</div>

    <c:if test="${openModal != null}" >
    <!-- Post Modal -->
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
	<!-- Post END -->
	</c:if>
	
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
	
	
	<script src="<%=request.getContextPath()%>/dist/js/aos.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/owl.carousel.min.js"></script><!-- << -->
	<script src="<%=request.getContextPath()%>/dist/js/scrollax.min.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/main.js"></script>
	<script src="<%=request.getContextPath()%>/dist/tagify/jQuery.tagify.min.js"></script>
</body>
<script>
		$('#loginModal').on('shown.bs.modal', function() {
		    $('#myInput').trigger('focus')
		})
		$("#postModal").modal({show: true},'handleUpdate');
	</script>
</html>