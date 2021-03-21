<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lecturer.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	LecturerVO lecVO = (LecturerVO) request.getAttribute("lecVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>
<html>
<head>

<style>
img {
	width: 150px;
}
</style>

<title>所有開課-講師專區</title>
<meta charset="utf-8">
<%@include file="/back-end/tempFile/head"%>
</head>
<body id="page-top">
	<%@include file="/back-end/tempFile/navBar_sideBar"%>
	<div class="container-fluid">


		<h3>所有開課-講師專區</h3>





		<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService" />
		<c:forEach var="cosVO" items="${cosSvc.all}">
			<c:if test="${cosVO.lecNo == lecVO.lecNo}">

				<div class="col-3 mb-1">
					<div class="card " style="width: 16rem; height: 30rem;">
						<img
							src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Course&column=cosPic&idname=cosNo&id=${cosVO.cosNo}"
							class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">${cosVO.cosName}</h5>
							<p class="card-text">${cosVO.cosIntro}</p>
							<a href="<%=request.getContextPath()%>/back-end/Lecturer/listAllCosDetail.jsp?cosNo=${cosVO.cosNo}
							" class="btn btn-primary">查詢報名名單</a>
						</div>

					</div>
				</div>
			</c:if>




		</c:forEach>
	</div>
	<%@include file="/back-end/tempFile/footer"%>
	<%@include file="/back-end/tempFile/srcJs"%>

</body>
</html>