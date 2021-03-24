<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.designer.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	DesignerService designerSvc = new DesignerService();
	List<DesignerVO> list = designerSvc.getAll();
	pageContext.setAttribute("list", list);
%>


<html>
<head>
<title>所有設計師資料for後台 - listAllDesigner.jsp</title>
 <meta charset="utf-8">
<%@include file="/back-end/tempFile/head"%>
<link
	href="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
</head>

<body id="page-top">
	<%@include file="/back-end/tempFile/navBar_sideBar"%>
	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->
		
		<p class="mb-4">
			<%-- 錯誤表列 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
		</p>

		<div class="card shadow mb-4">
		
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
						<thead>
							<tr>

								<th>服務沙龍</th>
								<th>設計師名稱</th>
								<th>審核狀態</th>
								<th>設計師照片</th>
								<th>修改</th>
							</tr>
						</thead>
						<tfoot>
							<tr>

								<th>服務沙龍</th>
								<th>設計師名稱</th>
								<th>審核狀態</th>
								<th>設計師照片</th>
								<th>修改</th>

							</tr>
						</tfoot>
						<jsp:useBean id="salonSvc" scope="page"
							class="com.salon.model.SalonService" />
						<tbody>	
						<c:forEach var="designerVO" items="${list}">
							
								<tr>
									<td>${salonSvc.getOneSalon(designerVO.salNo).salName}</td>
									<td>${designerVO.getDesName()}</td>


									<td><c:if test="${designerVO.desStatus == 0}">
									未審核
								</c:if> <c:if test="${designerVO.desStatus == 1}">
									正常
								</c:if> <c:if test="${designerVO.desStatus == 2}">
								 	   停權
								</c:if> <c:if test="${designerVO.desStatus == 3}">
									超過方案到期日
								</c:if></td>

									<td><img
										src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}"
										alt='沒有圖片' width="50px" /></td>
									<td>
										<FORM METHOD="post"
											ACTION="<%=request.getContextPath()%>/designer/designer.do"
											style="margin-bottom: 0px;">
											<input  class="btn btn-primary" type="submit" value="審核"> <input type="hidden"
												name="desNo" value="${designerVO.desNo}"> <input
												type="hidden" name="action"   value="getOne_For_Update_Back">
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