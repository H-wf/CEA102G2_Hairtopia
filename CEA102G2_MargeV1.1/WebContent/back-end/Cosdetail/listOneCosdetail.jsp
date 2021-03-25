<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coudet.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>單一修課明細</title>
    <meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>

<style>

#mytb{
	font-size:0.6rem;
}

#mytb td{
	height:30%;
}
#table-1 h4{
	color:black; font-family: "Open Sans", Arial, sans-serif;
}

</style>

<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">

<table id="table-1">
	<tr>
	<td><h3>單一修課明細</h3></td>
	<td><h5><a href="<%=request.getContextPath()%>/back-end/Cos/select_cos_page.jsp">回後台主頁</a></h5></td>
	</tr>
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

<jsp:useBean id="cosSvc" scope="page"
			class="com.cos.model.CosService" />

	<jsp:useBean id="memSvc" scope="page"
			class="com.member.model.MemService" />

<table style="width: 100%">
	<tr>
		<th>課程名稱</th>
		<th>會員名稱</th>
		<th>課程評價</th>
		<th>報名課程價格</th>
	</tr>
<c:forEach var="cosdetVar" items="${cosdetVO}">	
	<tr>
		<td>${cosSvc.findByPrimaryKeyCos(cosdetVar.cosNo).cosName}</td>
		<td>${memSvc.getOneMem(cosdetVar.memNo).memName}</td>
		<td>${cosdetVar.cosComment}</td>
		<td>${cosdetVar.cosDetailPrice}</td>
	</tr>
	</c:forEach>
</table>
<!-- Page Content END -->
                
<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>
</body>

</html>