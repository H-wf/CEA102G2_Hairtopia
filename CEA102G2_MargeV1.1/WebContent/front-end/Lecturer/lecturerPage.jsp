<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page import="com.lecturer.model.*"%>
<%@ page import="java.util.*"%>


<%
	LecturerVO lecVO = (LecturerVO) request.getAttribute("lecVO");
%>
<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService" />
<html lang="en">

<head>
<title>Hairtopia</title>
<meta charset="utf-8">
<%@include file="/front-end/tempFile/head"%>
</head>
<style>

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
	transform: none !important;;
	box-shadow: none !important;;
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
									src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Lecturer&column=lecPic&idname=lecNo&id=${lecVO.lecNo}"
									alt='沒有圖片' class="rounded mb-2 img-thumbnail" />
							</div>

						</div>
					</div>

					<div class="px-4 py-3 mt-5">
						<h5 class="mb-0">About ${lecVO.lecName}</h5>
						<div class="p-4 rounded shadow-sm bg-light">
							<p class="font-italic mb-0">${lecVO.lecIntro}</p>
						</div>
					</div>
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item"><a class="nav-link active" id="Post-tab"
							data-toggle="tab" href="#Post" role="tab" aria-controls="Post"
							aria-selected="true">Course</a></li>

					</ul>
					<div class="tab-content" id="myTabContent">

						<div class="tab-pane fade show active" id="Post" role="tabpanel"
							aria-labelledby="Post-tab">
							<div class="container">
								<div class="row justify-content-around my-5 ">
									<!-- cos Card -->

									<c:forEach var="cosVO" items="${cosSvc.all}">
										<c:if test="${cosVO.lecNo == lecVO.lecNo}">

											<div class="col-3 mb-1">
												<div class="card " style="width: 13rem; height: 25rem;">
													<img
														src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Course&column=cosPic&idname=cosNo&id=${cosVO.cosNo}"
														class="card-img-top" alt="...">
													<div class="card-body">
														<h5 class="card-title">${cosVO.cosName}</h5>
														<p class="card-text">${cosVO.cosIntro}</p>
														<a href="#" class="btn btn-primary">Go somewhere</a>
													</div>

												</div>
											</div>
										</c:if>
									</c:forEach>

								</div>
							</div>
						</div>


					</div>

				</div>
			</div>
		</div>
	</div>


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
	<%@include file="/front-end/tempFile/footer"%>
	<%@include file="/front-end/tempFile/tempJs"%>
</body>

</html>