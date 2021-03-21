<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.authority.model.*"%>
<%@ page import="com.staff.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	StaffVO staVO = (StaffVO) request.getAttribute("staVO");
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
<title>員工權限資料 - listAll_auth.jsp</title>
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

		<div class="card shadow mb-4">
		
			<div class="card-body">
				<div class="table-responsive">




					<c:if test="${not empty errorMsgs}">
						<font style="color: red">請修正以下錯誤:</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color: red">${message}</li>
							</c:forEach>
						</ul>
					</c:if>
					<h2>員工姓名</h2>
					<jsp:useBean id="staSvc" scope="page"
						class="com.staff.model.StaffService" />
					<p>
						${staSvc.getOneStaff(staVO.staNo).staName}

						<table class="table table-bordered" id="dataTable" width="100%"
						cellspacing="0"><thead>
							<tr>
								<th>功能編號</th>
								<th>功能名稱</th>
								<th colspan="2" >權限管理</th>
							</tr>
						</thead>

						<jsp:useBean id="funcSvc" scope="page"
							class="com.func.model.FuncService" />
						<c:set var="list" value="${list}" />
						<c:set var="i" value="0" />
						<tbody>
							<c:forEach var="funcVO" items="${funcSvc.all}" varStatus="s">
								<tr>
									<td>${funcVO.funcNo}</td>
									<td>${funcVO.funcName}</td>
									<c:choose>
											<c:when test="${funcVO.funcNo == list[i + s.index].funcNo}">
												<td>
													<FORM METHOD="post"
														ACTION="<%=request.getContextPath()%>/authority/authority.do"
														style="margin-bottom: 0px;">
														<input type="submit" value="刪除權限"> <input
															type="hidden" name="funcNo" value="${funcVO.funcNo}">
														<input type="hidden" name="staNo" value="${staVO.staNo}">
														<input type="hidden" name="action" value="listAll_auth">
													</FORM>
												</td>
												<td>
													<FORM METHOD="post"
														ACTION="<%=request.getContextPath()%>/authority/authority.do"
														style="margin-bottom: 0px;">
														<input type="submit" value="增加權限" disabled> <input
															type="hidden" name="funcNo" value="${funcVO.funcNo}">
														<input type="hidden" name="staNo" value="${staVO.staNo}">
														<input type="hidden" name="action" value="insert">
													</FORM>
												</td>
											</c:when>
											<c:otherwise>
												<td>
													<FORM METHOD="post"
														ACTION="<%=request.getContextPath()%>/authority/authority.do"
														style="margin-bottom: 0px;">
														<input type="submit" value="刪除權限" disabled> <input
															type="hidden" name="funcNo" value="${funcVO.funcNo}">
														<input type="hidden" name="staNo" value="${staVO.staNo}">
														<input type="hidden" name="action" value="listAll_auth">
													</FORM>
												</td>
												<td>
													<FORM METHOD="post"
														ACTION="<%=request.getContextPath()%>/authority/authority.do"
														style="margin-bottom: 0px;">
														<input type="submit" value="增加權限"> <input
															type="hidden" name="funcNo" value="${funcVO.funcNo}">
														<input type="hidden" name="staNo" value="${staVO.staNo}">
														<input type="hidden" name="action" value="insert">
													</FORM>
												</td>
												<c:set var="i" value="${i-1}" />
											</c:otherwise>
										</c:choose>
								</tr>

							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

</body>
</html>