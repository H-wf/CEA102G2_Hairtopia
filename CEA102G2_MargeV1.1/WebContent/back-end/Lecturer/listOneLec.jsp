<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lecturer.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	LecturerVO lecVO = (LecturerVO) request.getAttribute("lecVO"); 
%>
<html>
<head>

<style>
.card{
	position:relative;
	width: 15rem;
	height: 22em;
}
.card-body{
	position:absolute;
	width:100%;
	height:60%;
}
#lecimg {
	position:absolute;
	top:0;
	left:0;
	width: 100%;
	height:100%;
	object-fit:cover;
}
.btn-primary{
	position:absolute;
	bottom:0;
	width:100%;
}
.text{
	position:absolute;
	top:65%;
}
</style>

<title>講師專區</title>
<meta charset="utf-8">
<%@include file="/back-end/tempFile/head"%>
</head>
<body id="page-top">
	<%@include file="/back-end/tempFile/navBar_sideBar"%>
	<div class="container-fluid">


		<h3>講師專區</h3>



	<div class="row">

		<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService" />
		<c:forEach var="cosVO" items="${cosSvc.all}">
			<c:if test="${cosVO.lecNo == lecVO.lecNo}">

				<div class="col-3 mb-1 ">
					<div class="card ">
					
											
						<div class="card-body">
							<img id="lecimg"
							src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Course&column=cosPic&idname=cosNo&id=${cosVO.cosNo}"
							class="card-img-top" alt="...">	
							
							
						</div>
						<div style="vertical-align:top;">
						<div class="text">
						<h5 class="card-title">${cosVO.cosName}</h5>
						<p class="card-text">${cosVO.cosIntro}</p>
						
						</div>
						</div>
						<a href="<%=request.getContextPath()%>/back-end/Lecturer/listAllCosDetail.jsp?cosNo=${cosVO.cosNo}
							" class="btn btn-primary">查詢報名名單</a>
					</div>
					
				</div>
			</c:if>




		</c:forEach>
		</div>
	</div>
	<%@include file="/back-end/tempFile/footer"%>
	<%@include file="/back-end/tempFile/srcJs"%>

</body>
</html>