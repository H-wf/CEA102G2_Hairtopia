<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService" />
<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService" />
<jsp:useBean id="coudetSvc" scope="page" class="com.coudet.model.CosdetService" />
<!DOCTYPE html>
<html lang="en">

<head>
<title>修課名單</title>
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


		<!-- DataTales Example -->
		<div class="card shadow mb-4">

			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%"
						cellspacing="0">
						<thead>
							<tr>
								<th>學員姓名</th>
								<th>學員Email</th>
								<th>學員電話</th>
						
							</tr>
						</thead>
						<tbody>
						<c:forEach var="coudetVO" items="${coudetSvc.getOneCosDet(param.cosNo)}">
							
							<tr>
							<td>${memSvc.getOneMem(coudetVO.memNo).memName}</td>
							<td>${memSvc.getOneMem(coudetVO.memNo).memEmail}</td>
							<td>${memSvc.getOneMem(coudetVO.memNo).memPhone}</td>
							</tr>
						</c:forEach>
						</tbody>	
					</table>
				</div>
			</div>
		</div>



	</div>
	<!-- Page Content END -->

	<%@include file="/back-end/tempFile/footer"%>
	<%@include file="/back-end/tempFile/srcJs"%>

</body>


</html>