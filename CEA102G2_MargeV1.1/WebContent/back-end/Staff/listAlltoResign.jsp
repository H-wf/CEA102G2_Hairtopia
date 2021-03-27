<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.staff.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	StaffService staffSvc2 = new StaffService();
	List<StaffVO> list = staffSvc2.getAll();
	pageContext.setAttribute("list", list);
%>



<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>離職修改狀態</title>
<%@include file="/back-end/tempFile/head" %>
<link href="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
</head>
<body id="page-top">
	<%@include file="/back-end/tempFile/navBar_sideBar" %>
	<div class="container-fluid">
				<h3>員工離職 修改狀態 </h3>
	

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
					<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
					<thead>
		<tr>
			<th>員工姓名</th>
			<th>員工帳號</th>
			<th>員工狀態</th>
			<th>確認離職</th>
		</tr>
	</thead>
		<jsp:useBean id="staffSvc" scope="page"
			class="com.staff.model.StaffService" />

	 <tbody>
		<c:forEach var="staVO" items="${staffSvc.all}" >
			<c:if test="${staVO.staStatus==1}">
			<tr>
				<td>${staVO.staName}</td>
				<td>${staVO.staAcct}</td>
				<td>${staVO.staStatus==0 ? "離職" : "在職"}</td>
				
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/staff/staff.do"
						style="margin-bottom: 0px;">
						<input type="submit"  class="btn btn-primary btn-sm" value="離職"> <input type="hidden"
							name="staNo" value="${staVO.staNo}"> 
						<input
							type="hidden" name="action" value="updateForResign">
						<input
							type="hidden" name="staStatus" value="0">
					</FORM>
				</td>
			
			</tr>
			</c:if>
		</c:forEach>
</tbody>



	</table>
</div>
</div>
</div>
</div>

<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>

</body>
</html>