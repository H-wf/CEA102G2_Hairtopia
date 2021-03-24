<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.designer.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	//     DesignerService designerSvc = new DesignerService();
	List<DesignerVO> desList = (ArrayList<DesignerVO>) request.getAttribute("desList");
	pageContext.setAttribute("desList", desList);
%>


<html>
<head>
<title>搜尋設計師 - SearchDes.jsp</title>
<%@include file="/front-end/tempFile/head"%>
<style type="text/css">
.ftco-navbar-light {
	position: static;
}


.salName{
		font-size:1.45rem;
/* 		text-align:center; */
	}
</style>

</head>
<body>
	<%@include file="/front-end/tempFile/navBar"%>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3">

				<%-- 錯誤表列 --%>
				<%-- <c:if test="${not empty errorMsgs}"> --%>
				<!-- 	<font style="color:red">請修正以下錯誤:</font> -->
				<!-- 	<ul> -->
				<%-- 		<c:forEach var="message" items="${errorMsgs}"> --%>
				<%-- 			<li style="color:red">${message}</li> --%>
				<%-- 		</c:forEach> --%>
				<!-- 	</ul> -->
				<%-- </c:if> --%>
			</div>

			<div class="col-md-6 ">
				<jsp:useBean id="salonSvc" scope="page"
					class="com.salon.model.SalonService" />
				<c:forEach var="designerVO" items="${desList}">
					<div class="card w-auto" style="width: 18rem;">
						<div class="row no-gutters">
							<div class="col-md-3 ">
								<img class="img-fluid"
									src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}"
									alt='沒有圖片' />
							</div>
							<div class="col-md-6 mr-5">
								<div class="card-body pl-3 pb-0">
									<h2 class="card-text salName">${designerVO.desName}</h2>
									<h2 class="card-text salName">${salonSvc.getOneSalon(designerVO.salNo).salName}</h2>
									<span class="icon icon-map-marker mr-3"><i
								class="bi bi-geo-alt-fill"></i></span><span class="card-text mb-0 salName">${salonSvc.getOneSalon(designerVO.salNo).salAdd}</span><br>
								<span class="icon icon-phone mr-3"><i
											class="bi bi-telephone-fill"></i></span> <span class="text">${salonSvc.getOneSalon(designerVO.salNo).salPhone}</span></a>
								
								
								
								</div>
							</div>
							<span class="col-md-2 align-self-end  mb-3 ml-1">
									<a
										href="<%=request.getContextPath()%>/designer/designer.do?action=getOne_For_Display&desNo=${designerVO.desNo}"
										class="btn btn-primary">查看更多</a>
							
							</span>


						</div>
					</div>

				</c:forEach>
			</div>

			<%@include file="/front-end/tempFile/footer"%>
			<%@include file="/front-end/tempFile/tempJs"%>
</body>
</html>