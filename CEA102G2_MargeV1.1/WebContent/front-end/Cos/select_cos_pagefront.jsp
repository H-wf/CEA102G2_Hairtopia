<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>

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

		<jsp:useBean id="costypeSvc" scope="page"
			class="com.coutype.model.CostypeService" />
		<jsp:useBean id="lecSvc" scope="page"
			class="com.lecturer.model.LecturerService" />

		<ul>
			<li>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/cos/cos.do" name="form1">
					<b>輸入課程關鍵字：</b> <input type="text" name="cosName" value="瘋狂理髮師"><br>

					<b>選擇課程類別：</b> <select size="1" name="cosTypeNo">
						<option value="">
							<c:forEach var="costypeVO" items="${costypeSvc.all}">
								<option value="${costypeVO.getCosTypeNo()}">${costypeVO.getCosTypeName()}
							</c:forEach>
					</select><br> <b>選擇課程公告：</b> <select size="1" name="cosPubNo">
						<option value="">
							<c:forEach var="costypeVO" items="${costypeSvc.all}">
								<option value="${costypeVO.getCosTypeNo()}">${costypeVO.getCosTypeName()}
							</c:forEach>
					</select><br> <b>選擇講師名字：</b> <select size="1" name="lecNo">
						<option value="">
							<c:forEach var="LecturerVO" items="${lecSvc.all}">
								<option value="${LecturerVO.getLecNo()}">${LecturerVO.getLecName()}
							</c:forEach>
					</select><br> <input type="submit" value="送出"> <input
						type="hidden" name="action"
						value="listCos_ByCompositeQuery_forFront">
				</FORM>
			</li>
		</ul>
</body>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>

<script>
	var somedate1 = new Date();
	$('#f_date1')
			.datetimepicker(
					{
						beforeShowDay : function(date) {
							if (date.getYear() < somedate1.getYear()
									|| (date.getYear() == somedate1.getYear() && date
											.getMonth() < somedate1.getMonth())
									|| (date.getYear() == somedate1.getYear()
											&& date.getMonth() == somedate1
													.getMonth() && date
											.getDate() < somedate1.getDate())) {
								return [ false, "" ]
							}
							return [ true, "" ];
						}
					});

	var somedate2 = new Date();
	$('#f_date2')
			.datetimepicker(
					{
						beforeShowDay : function(date) {
							if (date.getYear() < somedate2.getYear()
									|| (date.getYear() == somedate2.getYear() && date
											.getMonth() < somedate2.getMonth())
									|| (date.getYear() == somedate2.getYear()
											&& date.getMonth() == somedate2
													.getMonth() && date
											.getDate() < somedate2.getDate())) {
								return [ false, "" ]
							}
							return [ true, "" ];
						}
					});
</script>
</div>

<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer"%>
<%@include file="/front-end/tempFile/tempJs"%>
</body>
</html>