<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.lecturer.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	LecturerService lecSvc2 = new LecturerService();
	List<LecturerVO> list = lecSvc2.getAll();
	pageContext.setAttribute("list", list);
%>



<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>所有講師資料 - listAll_lec.jsp</title>
<%@include file="/back-end/tempFile/head"%>
<link
	href="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<style type="text/css">
img {
	width: 150px;
}
</style>
</head>
<body id="page-top">
	<%@include file="/back-end/tempFile/navBar_sideBar"%>
	<!-- Begin Page Content -->
	<div class="container-fluid">



		<c:if test="${not empty errorMsgs}">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
		<div class="card shadow mb-4">
		
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%"
						cellspacing="0">
						<thead>
							<tr>
								<th>講師編號</th>
								<th>講師姓名</th>
								<th>照片</th>
								<th>簡介</th>
								<th>狀態</th>
								<th>修改資料</th>

							</tr>
						</thead>
						<jsp:useBean id="lecSvc" scope="page"
							class="com.lecturer.model.LecturerService" />

						<tbody>
							<c:forEach var="lecVO" items="${lecSvc.all}">

								<tr>
									<td>${lecVO.lecNo}</td>
									<td>${lecVO.lecName}</td>
									<td><img
										src="<%=request.getContextPath()%>/PicFinder?pic=1&table=lecturer&column=lecPic&idname=lecNo&id=${lecVO.lecNo}"
										alt='沒有圖片' /></td>
									<td>${lecVO.lecIntro}</td>
									<td><c:if test="${lecVO.lecStatus == 0}">
										 未聘請
										</c:if> <c:if test="${lecVO.lecStatus == 1}">
										 正常聘請
										</c:if> <c:if test="${lecVO.lecStatus == 9}">
										 不再聘請
										</c:if></td>
									<td>
										<FORM METHOD="post"
											ACTION="<%=request.getContextPath()%>/lecturer/lecturer.do"
											style="margin-bottom: 0px;">
											<input type="submit" value="修改" class="btn btn-primary"> <input type="hidden"
												name="lecNo" value="${lecVO.lecNo}"> <input
												type="hidden" name="action" value="getOne_For_Update" >
										</FORM>
									</td>
								
								</tr>

							</c:forEach>
						</tbody>



					</table>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/back-end/tempFile/footer"%>
	<%@include file="/back-end/tempFile/srcJs"%>
	<script
		src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/dist/backTemp/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- Core plugin JavaScript-->
	<script
		src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery-easing/jquery.easing.min.js"></script>
	<!-- Custom scripts for all pages-->
	<script
		src="<%=request.getContextPath()%>/dist/backTemp/js/sb-admin-2.min.js"></script>
	<!-- Page level plugins -->
	<script
		src="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/jquery.dataTables.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.js"></script>
	<!-- Page level custom scripts -->
	<script
		src="<%=request.getContextPath()%>/dist/backTemp/js/demo/datatables-demo.js"></script>
</body>
</html>