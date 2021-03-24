<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.authority.model.*"%>
<%@ page import="com.staff.model.*"%>

<%
	StaffVO staVO = (StaffVO) request.getAttribute("staVO");
%>


<!DOCTYPE html>
<html>
<head>

<title>修改權限</title>
<%@include file="/back-end/tempFile/head"%>
<link
	href="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
</head>
<body id="page-top">
	<%@include file="/back-end/tempFile/navBar_sideBar"%>

	<div class="container-fluid">
		<div class="row">
		
			<div class="col-12">

				<div class="card shadow mb-4">

					<div class="card-body">
						<div class="table-responsive">

							<form METHOD="POST"
								ACTION="<%=request.getContextPath()%>/authority/authority.do"
								id="form1" name="form1"
								enctype="application/x-www-form-urlencoded">



								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<tr>
										<th>員工姓名:</th>
										<td><input type="TEXT" name="staName" size="45" required
											value="<%=(staVO == null) ? "" : staVO.getStaName()%>" /></td>

									</tr>
									<tr>
										<th>員工帳號:</th>
										<td><input type="email" name="staAcct" size="45" required
											value="<%=(staVO == null) ? "" : staVO.getStaAcct()%>" /></td>

									</tr>

									<jsp:useBean id="funcSvc" scope="page" class="com.func.model.FuncService" />
									<tr>

										<th>功能名稱:<font color=red><b>*</b></font></th>
										<td><c:forEach var="funcVO" items="${funcSvc.all}">
												<input type="checkbox" id="ckBox" name="funcNo"
													value="${funcVO.funcNo}">
  														${funcVO.funcName}<br>

											</c:forEach></td>
									</tr>
								</table>
								<br> <input name="action" value="insertMuti" type="hidden">
								<input type="submit" value="新增" class="btn btn-info">

							</form>
						</div>
					</div>
				</div>

			</div>
			<div class="col-3">
				<%-- 錯誤表列 --%>
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
</body>
</html>