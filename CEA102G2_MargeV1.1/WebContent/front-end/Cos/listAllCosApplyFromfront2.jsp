<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page
	import="com.cos.model.*, com.coudet.model.*, com.coudet.controller.*"%>

<%
	CosService cosSvc = new CosService();
	List<CosVO> list = cosSvc.getAllCosApplyFrom();

	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
<title>Hairtopia</title>
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
				<th style="width: 4rem" valign="middle">課程<br>編號
				</th>
				<th style="width: 4rem" valign="middle">講師<br>名稱
				</th>
				<th style="width: 4rem" valign="middle">類別<br>名稱
				</th>
				<th style="width: 4rem" valign="middle">上課<br>起
				</th>
				<th style="width: 4rem" valign="middle">上課<br>迄
				</th>
				<th style="width: 5.5rem" valign="middle">課程<br>介紹
				</th>
				<th style="width: 4rem" valign="middle">課程<br>圖片
				</th>
				<th style="width: 4rem" valign="middle">課程<br>地址
				</th>
				<th style="width: 6rem" valign="middle">報名<br>總人數
				</th>
				<th style="width: 6rem" valign="middle">評價<br>總分數
				</th>
				<th style="width: 4rem" valign="middle">課程<br>狀態
				</th>
				<th style="width: 4rem" valign="middle">最低<br>人數
				</th>
				<th style="width: 4rem" valign="middle">最高<br>人數
				</th>
				<th style="width: 4rem" valign="middle">課程<br>價格
				</th>
				<th style="width: 4rem" valign="middle">報名<br>開始日
				</th>
				<th style="width: 4rem" valign="middle">報名<br>截止日
				</th>
				<th style="width: 4rem" valign="middle">課程<br>名稱
				</th>
				<th style="width: 4rem" valign="middle">點選<br>報名
				</th>
			</tr>

			<%
				for (CosVO cosVO : list) {
					byte[] cosPic = cosVO.getCosPic();
					Base64.Encoder encoder = Base64.getEncoder();
					String src = "data:image/jpeg;base64,";
					if (cosPic != null) {
						src += encoder.encodeToString(cosPic);
					} else {
						src = "/back-end/resource/images/back1.gif";
					}
				}
			%>

			<%@ include file="/back-end/pages/page1.file"%>

			<%
				long now = new Date().getTime();
				request.setAttribute("now", now);
			%>

			<jsp:useBean id="costypeSvc" scope="page"
				class="com.coutype.model.CostypeService" />
			<jsp:useBean id="lecSvc" scope="page"
				class="com.lecturer.model.LecturerService" />

			<c:forEach var="cosVO" items="${list}" begin="<%=pageIndex%>"
				end="<%=pageIndex+rowsPerPage-1%>">
				<c:if test="${cosVO.cosStatus==true}">
					<c:if test="${cosVO.cosApplyTo.getTime() >= now}">
						<FORM name="shoppingForm" METHOD="post"
							ACTION="<%=request.getContextPath()%>/cos/order.do"
							style="margin-bottom: 0px;">

							<tr>
								<td id=cosNo>${cosVO.cosNo}</td>
								<td>${lecSvc.getOneLecturer(cosVO.lecNo).lecName}</td>
								<td>${costypeSvc.getOneCosType(cosVO.cosTypeNo).cosTypeName}</td>
								<td><fmt:formatDate value="${cosVO.cosFrom}" type="both" /></td>
								<td><fmt:formatDate value="${cosVO.cosTo}" type="both" /></td>
								<td>${cosVO.cosIntro}</td>
								<td><img width="100"
									src="<%=request.getContextPath()%>/PicFinder?pic=1&table=course&column=cosPic&idname=cosNo&id=${cosVO.cosNo}"
									alt='沒有圖片' /></td>
								<td>${cosVO.cosAdd}</td>
								<td id=cosCount>${cosVO.cosCount}</td>
								<td>${cosVO.cosRate}</td>
								<td>${cosVO.cosStatus==true?"上架":"下架"}</td>
								<td id=cosMinCount>${cosVO.cosMinCount}</td>
								<td id=cosMaxCount>${cosVO.cosMaxCount}</td>
								<td>${cosVO.cosPrice}</td>
								<td><fmt:formatDate value="${cosVO.cosApplyFrom}"
										type="both" /></td>
								<td><fmt:formatDate value="${cosVO.cosApplyTo}" type="both" /></td>
								<td>${cosVO.cosName}</td>
								<td><input class="test" type="submit" value="報名" id="myBtnClickToStop"
									onclick="var e=this;setTimeout(function(){e.disabled=true;},0);return true;" /> <input
									type="hidden" name="cosNo" value="${cosVO.cosNo}"> <input
									type="hidden" name="memNo"
									value="${sessionScope.userSession.memNo}"> <input
									type="hidden" name="cosDetailPrice" value="${cosVO.cosPrice}">
									<input type="hidden" name="cosCount" value="${cosVO.cosCount}">
									<input type="hidden" name="action" value="ADD"> <input
									type="hidden" name="add" value="${cosVO.cosNo}"></td>
							</tr>
						</FORM>
					</c:if>
				</c:if>
			</c:forEach>

		</table>
		<form method="POST"
			action="<%=request.getContextPath()%>/front-end/Cos/Cart.jsp">
			<input type="hidden" name="action" value="checkCart">
			<button type="submit">查看購物車</button>
		</form>

		<%@ include file="/back-end/pages/page2.file"%>

		<script src="https://code.jquery.com/jquery-1.11.3.js"></script>



		<script type="text/javascript">
			$(".test").click(function() {
				if (cosCount)
				alert("已加入");
				$(this).addClass("submitToWhite");
			});
			
			var cosCount = document.getElementById('cosCount');
			var cosMinCount = document.getElementById('cosMinCount');
			var cosMaxCount = document.getElementById('cosMaxCount');
			var a = cosCount.innerText;
			var b = cosMinCount.innerText;
			var c = cosMaxCount.innerText;
			console.log(parseInt(a));
			console.log(parseInt(b));
			console.log(parseInt(c));
			window.onload = changeState(a);
			function changeState() {
				if (a = c) {
					document.getElementById('myBtnClickToStop').disabled = true;
				} if else (a>c){
					document.getElementById('myBtnClickToStop').disabled = true;
				}
				else {
					document.getElementById('myBtnClickToStop').disabled = false;
				}
			}
		<%--var table=document.getElementById('mytb');
var rows = document.getElementById('listAllCosApplyFrom').rows.length;
console.log(rows);
var cells = document.getElementById('listAllCosApplyFrom').rows.item(0).cells.length;
console.log(cells);

var d = table.rows[1].cells[8].innerHTML;
var e = table.rows[1].cells[11].innerHTML;
var f = table.rows[1].cells[12].innerHTML;

var g = table.rows[2].cells[8].innerHTML;
var h = table.rows[2].cells[11].innerHTML;
var i = table.rows[2].cells[12].innerHTML;

var j = table.rows[3].cells[8].innerHTML;
var k = table.rows[3].cells[11].innerHTML;
var l = table.rows[3].cells[12].innerHTML;

var cosNo=document.getElementById('cosNo');
var m = cosNo.innerText;
console.log(m);--%>
			
		</script>

	</div>
	<!-- Page Content END -->
	<%@include file="/front-end/tempFile/footer"%>
	<%@include file="/front-end/tempFile/tempJs"%>
</body>
</html>