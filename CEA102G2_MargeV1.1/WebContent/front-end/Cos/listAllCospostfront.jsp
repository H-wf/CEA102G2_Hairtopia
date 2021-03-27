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
<!-- 網頁標題要改記得改! -->
<title>課程前台首頁</title>
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
							class="btn btn-outline-primary btn-login cosBtn">課程首頁</button>
					</a>
				</div>
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/listAllCosfront.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">歷史課程</button>
					</a>
				</div>
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/listAllCosApplyFromfront.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn ">報名中課程</button>
					</a>
				</div>
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/listAllCospostfront.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">公告課程</button>
					</a>
				</div>
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/select_cos_pagefront.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">查詢課程</button>
					</a>
				</div>

				<div class="col-1.5" style="background-image: url()">
					<a onClick="javascript:history.back(1)">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">回上一頁</button>
					</a>
				</div>

			</div>
		</div>

		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>

		<table id='mytb' style="width: 77.5rem" class="table table-striped">
			<tr>
				<th>公告編號</th>
				<th>課程名稱</th>
				<th>公告內容</th>
				<th>公告時間</th>
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