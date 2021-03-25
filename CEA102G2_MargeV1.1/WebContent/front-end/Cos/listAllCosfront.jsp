<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cos.model.*"%>

<%
    CosService cosSvc = new CosService();
    List<CosVO> list = cosSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <title>Hairtopia</title>
 <meta charset="utf-8">
<%@include file="/front-end/tempFile/head" %>
 
</head>
<style>
.ftco-navbar-light{
		position:static;
	}
#mytb{
	font-size:0.8rem;
}
#mytb td{
	height:30%;
}
#table-1 h4{
	color:black; font-family: "Open Sans", Arial, sans-serif;
}

</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">

<table id="table-1">
	<tr><td>
		 <li><a href="<%=request.getContextPath()%>/front-end/Cos/Course_Lec_1st.jsp">回課程前台</a></li>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<li><a href="<%=request.getContextPath()%>/front-end/Cos/listAllCosApplyFromfront.jsp">列出所有報名中課程</a><br><br></li>

<table id="mytb" style="width: 77.5rem" class="table table-striped" >
	<tr>
		<th style="width: 4rem" valign="middle">課程<br>編號</th>
		<th style="width: 4rem" valign="middle">講師<br>編號</th>
		<th style="width: 4rem" valign="middle">類別<br>編號</th>
		<th style="width: 4rem" valign="middle">上課<br>起</th>
		<th style="width: 4rem" valign="middle">上課<br>迄</th>
		<th style="width: 9.5rem" valign="middle">課程<br>介紹</th>
		<th style="width: 4rem" valign="middle">課程<br>圖片</th>
		<th style="width: 4rem" valign="middle">課程<br>地址</th>
		<th style="width: 6rem" valign="middle">報名<br>總人數</th>
		<th style="width: 6rem" valign="middle">評價<br>總分數</th>
		<th style="width: 4rem" valign="middle">課程<br>狀態</th>
		<th style="width: 4rem" valign="middle">最低<br>人數</th>
		<th style="width: 4rem" valign="middle">最高<br>人數</th>
		<th style="width: 4rem" valign="middle">課程<br>價格</th>
		<th style="width: 4rem" valign="middle">報名<br>開始日</th>
		<th style="width: 4rem" valign="middle">報名<br>截止日</th>
		<th style="width: 4rem" valign="middle">課程<br>名稱</th>
	</tr>
	
	<%
			for (CosVO cosVO : list) {
				byte[] cosPic = cosVO.getCosPic();
				Base64.Encoder encoder = Base64.getEncoder();
				String src = "data:image/jpeg;base64,";
				if (cosPic != null){
					src += encoder.encodeToString(cosPic);	
				}else{
					src="/back-end/resource/images/back1.gif";
				}
			}
		%>
	
	<%@ include file="/back-end/pages/page1.file"%>
	
	<jsp:useBean id="costypeSvc" scope="page" class="com.coutype.model.CostypeService"/>
	<jsp:useBean id="lecSvc" scope="page" class="com.lecturer.model.LecturerService"/>
	 
	<c:forEach var="cosVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<td>${cosVO.cosNo}</td>
			<td>${lecSvc.getOneLecturer(cosVO.lecNo).lecName}</td>
			<td>${costypeSvc.getOneCosType(cosVO.cosTypeNo).cosTypeName}</td>
			<td><fmt:formatDate value="${cosVO.cosFrom}" type="both"/></td>
			<td><fmt:formatDate value="${cosVO.cosTo}" type="both"/></td>
			<td>${cosVO.cosIntro}</td>
			<td><img width="100" src="<%=request.getContextPath()%>/PicFinder?pic=1&table=course&column=cosPic&idname=cosNo&id=${cosVO.cosNo}" alt='沒有圖片' /></td>
			<td>${cosVO.cosAdd}</td>
			<td>${cosVO.cosCount}</td>
			<td>${cosVO.cosRate}</td>
			<td>${cosVO.cosStatus==true?"上架":"下架"}</td>
			<td>${cosVO.cosMinCount}</td>
			<td>${cosVO.cosMaxCount}</td>
			<td>${cosVO.cosPrice}</td>
			<td><fmt:formatDate value="${cosVO.cosApplyFrom}" type="both"/></td>
			<td><fmt:formatDate value="${cosVO.cosApplyTo}" type="both"/></td>
			<td>${cosVO.cosName}</td>
			</tr>
	</c:forEach>
</table>
<%@ include file="/back-end/pages/page2.file" %>

</div>
<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>
</html>