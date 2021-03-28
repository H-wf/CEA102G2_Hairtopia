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

.salName{
		font-size:1.45rem;
/* 		text-align:center; */
	}
.imgcontainer{
	position:relative;
}
.img-fluid{
	position:absolute;
	height:100%;
	object-fit:cover;
}
.salAdd{
	font-size:1.2rem;
}
#headImg{ 
 height: 40vh;
    background-image: url(<%=request.getContextPath()%>/front-end/Post/forHeadBG2.jpg);
    background-repeat: no-repeat;
    background-position: 50% 34%;
    background-size: 100%;
 } 
</style>

</head>
<body>
	<%@include file="/front-end/tempFile/navBar"%>

	<div class="container-fluid px-0">
	<div id="headImg">
	</div>
		<div class="row justify-content-center">

			<div class="col-md-7 ">
				<jsp:useBean id="salonSvc" scope="page"
					class="com.salon.model.SalonService" />
				<jsp:useBean id="desSvc" scope="page"
					class="com.designer.model.DesignerService" />
				<c:forEach var="designerVO" items="${desSvc.all}">
					<div class="card w-auto my-3" style="width: 18rem;">
					
						<div class="row no-gutters">
							<div class="col-md-3 imgcontainer">
								<img class="img-fluid"
									src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}"
									alt='沒有圖片'/>
							</div>
							<div class="col-md-9">
								<div class="card-body pl-3 ">
								
									<h2 class="card-text salName">${designerVO.desName}</h2>
									<hr>
									<h2 class="card-text salName"><span class="mr-3"><i class="bi bi-shop"></i></span><span style="font-size:1.2rem;">${salonSvc.getOneSalon(designerVO.salNo).salName}</span></h2>
									<span class="icon icon-map-marker mr-3">
										<i class="bi bi-geo-alt-fill"></i>
									</span>
									<span class="card-text mb-0 salName salAdd">${salonSvc.getOneSalon(designerVO.salNo).salAdd}</span><br>
									<span class="icon icon-phone mr-3">
										<i class="bi bi-telephone-fill"></i>
									</span> 
									<span class="text">${salonSvc.getOneSalon(designerVO.salNo).salPhone}</span>
									<a
										href="<%=request.getContextPath()%>/designer/designer.do?action=getOne_For_Display&desNo=${designerVO.desNo}"
										class="btn btn-primary float-right" >查看更多</a>
								
								
								</div>
								
							</div>
							<span style="bottom:0;">
							
							</span>


						</div>
<!-- 						<span class="m-1"> -->
									
							
<!-- 						</span> -->
					</div>

				</c:forEach>
			</div>

			<%@include file="/front-end/tempFile/footer"%>
			<%@include file="/front-end/tempFile/tempJs"%>
</body>
</html>