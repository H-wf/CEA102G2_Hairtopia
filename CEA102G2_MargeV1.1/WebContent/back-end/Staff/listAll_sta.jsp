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
<style type="text/css">
img {
	width: 150px;
}
</style>
<meta charset="UTF-8">
<title>所有講師資料 - listAll_sta.jsp</title>
<%@include file="/back-end/tempFile/head"%>
</head>
<body id="page-top">
	<%@include file="/back-end/tempFile/navBar_sideBar"%>


	<div class="container-fluid">
		<div class="row">
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

			<div class="col-8">

		
							<h3 class="text-center">所有員工資料</h3>

				


				<table class="table table-borderless">
					<thead class="thead-dark">
						<tr>
							<th colspan="1">員工編號</th>
							<th colspan="1">員工姓名</th>
							
							<th colspan="1">員工帳號</th>
							<th colspan="1">員工密碼</th>
							<th colspan="6" class="text-center">員工權限</th>


						</tr>
					</thead>
					<jsp:useBean id="staSvc" scope="page"
						class="com.staff.model.StaffService" />
					<jsp:useBean id="authSvc" scope="page"
						class="com.authority.model.AuthorityService" />	
					<jsp:useBean id="funcSvc" scope="page"
						class="com.func.model.FuncService" />	
						

					<%@ include file="/resource/pages/page1.file"%>
					<c:forEach var="staVO" items="${staSvc.all}" begin="<%=pageIndex%>"
						end="<%=pageIndex+rowsPerPage-1%>">
						<tbody>
						<tr>
							<td colspan="1">${staVO.staNo}</td>
							<td colspan="1">${staVO.staName}</td>
							
							<td colspan="1">${staVO.staAcct}</td>
							<td colspan="1">${staVO.staPswd}</td>
							
							<c:forEach var="authVO" items="${authSvc.getAllByStaNo(staVO.staNo)}">
							
							<td colspan="1">
							${funcSvc.getOneFunc(authVO.funcNo).funcName} 
							
							</c:forEach>
							</td>
						
						</tr>
					</tbody>
					</c:forEach>




				</table>
				<%@ include file="/resource/pages/page2.file"%>
			</div>
		</div>
	</div>

	<%@include file="/back-end/tempFile/footer"%>
	<%@include file="/back-end/tempFile/srcJs"%>
</body>
</html>