<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.staff.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	StaffService staSvc2 = new StaffService();
	List<StaffVO> list = staSvc2.getAll();
	pageContext.setAttribute("list", list);
%>



<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>所有員工資料</title>
<%@include file="/back-end/tempFile/head"%>
<link href="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
</head>
<body id="page-top">
	<%@include file="/back-end/tempFile/navBar_sideBar"%>
	<div class="container-fluid">
		<div class="row">
			<jsp:useBean id="staSvc" scope="page"
									class="com.staff.model.StaffService" />
								<jsp:useBean id="authSvc" scope="page"
									class="com.authority.model.AuthorityService" />
								<jsp:useBean id="funcSvc" scope="page"
									class="com.func.model.FuncService" />

			<div class="col-12">
				<h3 class="text-center">所有員工資料</h3>

				<div class="card shadow mb-4">
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered" id="dataTable" width="100%"
								cellspacing="0">
								<thead>
									<tr>
										<th >員工編號</th>
										<th >員工姓名</th>
										<th >員工帳號</th>
										<th >在職狀態</th>
										<th  >員工權限</th>

									</tr>
								</thead>
								
								<tbody>
									<c:forEach var="staVO" items="${staSvc.all}">
										<tr>
											<td >${staVO.staNo}</td>
											<td ><a class="badge badge-light"
												href="<%=request.getContextPath()%>/authority/authority.do?
											action=queryByStaNo&staNo=${staVO.staNo}">
													${staVO.staName}</a></td>
											<td >${staVO.staAcct}</td>
											<td >
											${staVO.staStatus== 0 ? "離職" : "在職"}

											</td>
											<td >
											<c:forEach var="authVO"
												items="${authSvc.getAllByStaNo(staVO.staNo)}">
												
													${funcSvc.getOneFunc(authVO.funcNo).funcName} 
											</c:forEach>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>	
						</div>
					</div>
				</div>
			</div>
			<div class="col-2">

				<c:if test="${not empty errorMsgs}">
					<font style="color: red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>

			</div>
		</div>
	</div>

<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- Custom scripts for all pages-->
<script src="<%=request.getContextPath()%>/dist/backTemp/js/sb-admin-2.min.js"></script>
<!-- Page level plugins -->
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.js"></script>
<!-- Page level custom scripts -->
<script src="<%=request.getContextPath()%>/dist/backTemp/js/demo/datatables-demo.js"></script>
</body>


</html>