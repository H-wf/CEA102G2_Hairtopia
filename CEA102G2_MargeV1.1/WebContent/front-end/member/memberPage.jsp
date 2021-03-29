<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.designer.model.*"%>
<%@ page import="com.post.model.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="com.salon.model.*"%>
<%@ page import="com.reservation.model.*"%>
<%@ page import="com.coudet.model.*"%>
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
<jsp:useBean id="resSvc" scope="page"
	class="com.reservation.model.ResService" />
<jsp:useBean id="cosSvc" scope="page"
	class="com.cos.model.CosService" />
<jsp:useBean id="cosdetSvc" scope="page"
	class="com.coudet.model.CosdetService" />
	

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
									src="<%=request.getContextPath()%>/showImges.do?tableName=member&picColumn=memPic&pkColumn=memNo&memNo=${userSession.memNo}"
									alt='沒有圖片' class="rounded mb-2 img-thumbnail" /> 
									<a href="<%=request.getContextPath()%>/front-end/member/memberSetting.jsp" class="btn btn-outline-dark btn-sm btn-block">Edit profile</a>
							</div>
							<div class="media-body mb-5 text-white myrow">
								<h4 class="mt-0 mb-0">${userSession.memName}</h4>
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
							
<c:if test="${empty resSvc.getAllResByMemNo(sessionScope.userSession.memNo)}">	
<div style="text-align:center;font-weight:400;">目前尚無預約</div>
</c:if>					 
<c:if test="${not empty resSvc.getAllResByMemNo(sessionScope.userSession.memNo)}">						 
	<table class="table table-striped">
	<tr>
		<th>編號</th>
		<th>服務項目</th>
		<th>設計師</th>
		<th>預約時間</th>
		<th>預約狀態</th>
		<th>金額</th>
		<th>預約明細</th>
		<th></th>
		
	</tr>
	
	<c:forEach var="resVO" items="${resSvc.getAllResByMemNo(sessionScope.userSession.memNo)}" >
		
		<tr>
			<td>${resVO.resNo}</td>
			<td>
				<c:forEach var="serviceVO" items="${serviceSvc.all}">
					<c:if test="${serviceVO.serNo==resVO.serNo}">
	            	${serviceVO.serName}
            		</c:if>
				</c:forEach>
			</td>
			<td>
				<c:forEach var="designerVO" items="${desSvc.all}">
					<c:if test="${designerVO.desNo==resVO.desNo}">
	            	${designerVO.desName}
            		</c:if>
				</c:forEach>
			</td>
			<td>
				<c:forEach var="serviceVO" items="${serviceSvc.all}">
					<c:if test="${serviceVO.serNo==resVO.serNo}">
	            	<c:set var="serPeriod" value="${serviceVO.serTime}"/>
            		</c:if>
				</c:forEach>
				<fmt:formatDate value="${resVO.resDate}" pattern="yyyy-MM-dd"/><br>
				<c:set var="startTime" value="${resVO.resTime}"/>
				<c:set var="endTime" value="${startTime+serPeriod}"/>
				<fmt:formatNumber type="number" value="${((startTime*30 -(startTime*30%60)))/60}"  var="shour"/>
				<fmt:formatNumber type="number" value="${((endTime*30 -(endTime*30%60)))/60}"  var="ehour"/>
				<c:if test="${shour<10}">0</c:if>${shour}:${(startTime*30 %60 == 0)? "00" :"30" }
				~<c:if test="${ehour<10}">0</c:if>${ehour}:${(endTime*30 %60 == 0)? "00" :"30" }
			</td>
			<td>
			<c:choose>
				<c:when test="${resVO.resStatus == 0}">
				預約待確認
				</c:when>
				<c:when test="${resVO.resStatus == 1}">
				確認待驗證
				</c:when>
				<c:when test="${resVO.resStatus == 2}">
				已到店認證
				</c:when>
				<c:when test="${resVO.resStatus == 3}">
				服務已完成
				</c:when>
				<c:when test="${resVO.resStatus == 4}">
				無法提供服務
				</c:when>
				<c:when test="${resVO.resStatus == 5}">
				您取消預約
				</c:when>
				<c:otherwise>
				會員未到
				</c:otherwise>
			</c:choose>
			</td>
			
			<td>${resVO.resPrice}</td>
			<td>
				<a href="<%=request.getContextPath()%>/reservation/res.do?resNo=${resVO.resNo}&action=getOne_For_Display_Of_Mem" class="checkDetail">查看明細</a>
				
			</td>
			<td style="padding:12px 3px">
				<c:if test="${resVO.resStatus == 0}">
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" style="margin-bottom: 0px;">
			     	<input type="submit" value="取消預約"  class="btn btn-primary" style="border:0px;padding:.3rem .75rem">
			    	<input type="hidden" name="resNo"  value="${resVO.resNo}">
			     	<input type="hidden" name="action"	value="cancelByMem"></FORM>
				</c:if>
			</td>
			
		</tr>
	</c:forEach>
</table>
</c:if>

							<div class="container post">
								<div class="card-columns ">

								</div>
							</div>
						</div>

						<div class="tab-pane fade" id="Order" role="tabpanel"
							aria-labelledby="Order-tab">
							<div class="ServiceCard">
<!-- 								<div class="callout callout-default"> -->
									<jsp:include page="../ordermaster/listAllOrderMaster.jsp"/>
<!-- 								</div> -->
							</div>
						</div>
						<div class="tab-pane fade" id="Course" role="tabpanel"
							aria-labelledby="Info-tab">
							<div class="InfoCard">
								<table class="table table-striped">
								<tr>
									<th>課程名稱</th>
									<th>課程評價</th>
									<th>報名課程價格</th>
									<th></th>
									<th></th>
									
								</tr>
								<c:forEach var="cosdetVO" items="${cosdetSvc.getAllCosByMemNo(userSession.memNo)}">
								<tr>
									<td><c:forEach var="cosVO" items="${cosSvc.all}">
									<c:if test="${cosdetVO.cosNo==cosVO.cosNo}">
	            					${cosVO.cosName}
            						</c:if>
									</c:forEach></td>
									<td>
									<c:if test="${cosdetVO.cosComment != 0}">
										<c:forEach var="star" begin="1" end="5">
										<c:choose>
										<c:when test="${cosdetVO.cosComment>=star}"	>
											&#x2605;
										</c:when>
										<c:otherwise>
											&#x2606;
										</c:otherwise>
										</c:choose>
										</c:forEach>
									</c:if></td>
									<td>${cosdetVO.cosDetailPrice}</td>
									<td>
			  							<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" style="margin-bottom: 0px;" >
			     						<input type="submit" value="評分" class="btn btn-primary">
			     						<input type="hidden" name="cosNo"  value="${cosdetVO.getCosNo()}">
			    						<input type="hidden" name="memNo"  value="${userSession.memNo}">
			     						<input type="hidden" name="cosComment"  value="${cosdetVO.getCosComment()}">
			     						<input type="hidden" name="action"	value="getOneCos_For_UpdateRate"></FORM>
									</td>
									<td>
			  							<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" style="margin-bottom: 0px;" >
			     						<input type="submit" value="查詢QRCode" class="btn btn-primary">
			     						<input type="hidden" name="cosNo"  value="${cosdetVO.getCosNo()}">
			     						<input type="hidden" name="memNo"  value="${userSession.memNo}">
			     						<input type="hidden" name="action"	value="ShowQRCodeByCosNoAndMemNo"></FORM>
									</td>
								</tr>
								</c:forEach>
							</table>
							</div>
						</div>
						<% %>
						
						<div class="tab-pane fade" id="TransRecord" role="tabpanel"
							aria-labelledby="TransRecord-tab">
							<div class="ServiceCard">
								<div class="shadow mb-4" width="80%">
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
	<!-- Res Modal -->
		<c:if test="${openResModal!=null}">
<div class="modal fade" id="resModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Reservation Detail</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
			
			<div class="modal-body">
<!-- =========================================以下為原listOneEmp.jsp的內容========================================== -->
               <jsp:include page="/front-end/reservation/listOneResOfMem.jsp" />
<!-- =========================================以上為原listOneEmp.jsp的內容========================================== -->
			</div>
			
			<div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
		
		</div>
	</div>
</div>
</c:if>
    <!-- Res Modal END -->
	<!-- Cos Modal -->
		<c:if test="${openCosModal!=null}">
<div class="modal fade" id="cosModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Course Detail</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
			
			<div class="modal-body">
<!-- =========================================以下為原listOneEmp.jsp的內容========================================== -->
               <jsp:include page="/front-end/Cos/update_cosdetail_input_front.jsp" />
<!-- =========================================以上為原listOneEmp.jsp的內容========================================== -->
			</div>
		</div>
	</div>
</div>
</c:if>
    <!-- Res Modal END -->
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
$("#resModal").modal({show: true});
$("#cosModal").modal({show: true});

</script>

</html>