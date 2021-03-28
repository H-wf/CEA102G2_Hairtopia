<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cospost.model.*"%>
<%@ page import="com.cos.model.*"%>

<%
    CospostService cospostSvc = new CospostService();
    List<CospostVO> list = cospostSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService" />


<!DOCTYPE html>
<html>
<head>
<!-- �������D�n��O�o��! -->
<title>�ҵ{�e�x����</title>
<meta charset="utf-8">
<%@include file="/front-end/tempFile/head"%>

</head>
<style>
.ftco-navbar-light {
	position: static;
}

#mytb {
	font-size: 0.8rem;
}

#mytb td {
	height: 30%;
}

#table-1 h4 {
	color: black;
	font-family: "Open Sans", Arial, sans-serif;
}

.submitToWhite {
	color: gray;
}

.cosBtn {
	margin: 10px 10px 10px 0px;
}
</style>
<body>
	<%@include file="/front-end/tempFile/navBar"%>

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<div class="container">
			<div class="row">
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/Course_Lec_1st.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">�ҵ{����</button>
					</a>
				</div>
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/listAllCosfront.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">���v�ҵ{</button>
					</a>
				</div>
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/listAllCosApplyFromfront.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn ">���W���ҵ{</button>
					</a>
				</div>
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/listAllCospostfront.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">���i�ҵ{</button>
					</a>
				</div>
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/select_cos_pagefront.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">�d�߽ҵ{</button>
					</a>
				</div>

				<div class="col-1.5" style="background-image: url()">
					<a onClick="javascript:history.back(1)">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">�^�W�@��</button>
					</a>
				</div>

			</div>
		</div>

		<%-- ���~��C --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color: red">�Эץ��H�U���~:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>

		<table id='mytb' style="width: 77.5rem" class="table table-striped">
			<tr>
				<th>���i�s��</th>
				<th>�ҵ{�W��</th>
				<th>���i���e</th>
				<th>���i�ɶ�</th>
			</tr>
			<%@ include file="/back-end/pages/page1.file"%>
			<c:forEach var="cospostVO" items="${list}" begin="<%=pageIndex%>"
				end="<%=pageIndex+rowsPerPage-1%>">

				<tr>
					<td>${cospostVO.getCosPubNo()}</td>
					<!-- <td><a href="<%=request.getContextPath()%>/cos/cos.do?cosNo=${cospostVO.cosNo}&action=getOne_For_Display">${cosSvc.findByPrimaryKeyCos(cospostVO.cosNo).cosName}</a></td> -->
					<td>${cosSvc.findByPrimaryKeyCos(cospostVO.cosNo).cosName}</td>

					<td>${cospostVO.getCosPubCon()}</td>
					<td><fmt:formatDate value="${cospostVO.getCosPubTime()}"
							type="both" /></td>
				</tr>
			</c:forEach>
		</table>
		<%@ include file="/back-end/pages/page2.file"%>

		<!-- Page Content END -->
		<%@include file="/front-end/tempFile/footer"%>
		<%@include file="/front-end/tempFile/tempJs"%>
</body>
</html>