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
							<div class="col-md-6">
								<div class="card-body pl-3">
								
									<p class="card-text">髮廊:${salonSvc.getOneSalon(designerVO.salNo).salName}</p>
									<p class="card-text">設計師:${designerVO.desName}</p>
									<p class="card-text">簡介:${designerVO.desInfor}</p>
									<p class="card-text">平均分數:${designerVO.desTolScore /designerVO.desCount}</p>
								</div>
							</div>
								<div class="col-md-3 align-self-end text-right mb-3">
									<a href="<%=request.getContextPath()%>/designer/designer.do?action=getOne_For_Display&desNo=${designerVO.desNo}"
										class="btn btn-primary">查看更多</a>
								</div>
							

						</div>
					</div>

				</c:forEach>


				<%@include file="/front-end/tempFile/footer"%>
				<%@include file="/front-end/tempFile/tempJs"%>
</body>
</html>