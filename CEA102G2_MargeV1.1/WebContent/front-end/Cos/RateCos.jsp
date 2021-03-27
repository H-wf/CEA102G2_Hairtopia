<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page
	import="java.util.*, com.coudet.model.*, com.coudet.controller.*, com.cos.controller.*"%>

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
<title>課程首頁</title>
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

	<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService" />
	<jsp:useBean id="cosdetSvc" scope="page"
		class="com.coudet.model.CosdetService" />

	<table style="width: 77.5rem" class="table table-striped">
		<tr>
			<th>課程名稱</th>
			<th>髮型師評價</th>
			<th>課程價格</th>
			<th>開始評價</th>
			<th>課程QRcode</th>
		</tr>

		<c:forEach var="cosdetVO" items="${cosdetVO}">
			<tr>
				<%
					long now = new Date().getTime();
						request.setAttribute("now", now);
				%>
				<td>${cosSvc.findByPrimaryKeyCos(cosdetVO.cosNo).cosName}</td>
				<td>${cosdetVO.cosComment}</td>
				<td>${cosdetVO.cosDetailPrice}</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/coudet/coudet.do"
						style="margin-bottom: 0px;">

						<c:if
							test="${cosSvc.findByPrimaryKeyCos(cosdetVO.cosNo).cosTo.getTime() <= now}">
							<input type="submit" value="評分">
						</c:if>
						<input type="hidden" name="cosNo" value="${cosdetVO.getCosNo()}">
						<input type="hidden" name="memNo" value="${cosdetVO.getMemNo()}">

						<input type="hidden" name="cosComment"
							value="${cosdetVO.getCosComment()}"> <input class="test"
							type="hidden" name="action" value="getOneCos_For_UpdateRate">

					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/coudet/coudet.do"
						style="margin-bottom: 0px;">
						<c:if
							test="${cosSvc.findByPrimaryKeyCos(cosdetVO.cosNo).cosTo.getTime() >= now}">
							<input type="submit" value="查詢QRCode">
						</c:if>
						<input type="hidden" name="cosNo" value="${cosdetVO.getCosNo()}">
						<input type="hidden" name="memNo" value="${cosdetVO.getMemNo()}">
						<input type="hidden" name="action"
							value="ShowQRCodeByCosNoAndMemNo">
					</FORM>
				</td>
			</tr>
			</tr>
		</c:forEach>

	</table>


	<!-- Page Content END -->
	<%@include file="/front-end/tempFile/footer"%>
	<%@include file="/front-end/tempFile/tempJs"%>
</body>
</html>