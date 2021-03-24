<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.coudet.model.*"%>

<%
    CosdetService cosdetSvc = new CosdetService();
    List<CosdetVO> list = cosdetSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>所有修課明細</title>
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
	<td><h3>所有修課明細</h3></td>
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

<table>
	<tr>
		<th>課程編號</th>
		<th>會員編號</th>
		<th>課程評價</th>
		<th>報名課程價格</th>
		<th>明細修改</th>
		<th>明細刪除</th>
	</tr>
	
	
	
	<%@ include file="/back-end/pages/page1.file"%> 
	<c:forEach var="cosdetVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${cosSvc.findByPrimaryKeyCos(cosdetVO.cosNo).cosName}</td>
			<td>${memSvc.getOneMem(cosdetVO.memNo).memName}</td>
			<td>${cosdetVO.getCosComment()}</td>
			<td>${cosdetVO.getCosDetailPrice()}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" style="margin-bottom: 0px;" >
			     <input type="submit" value="修改">
			     <input type="hidden" name="cosNo"  value="${cosdetVO.getCosNo()}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="cosNo"  value="${cosdetVO.getCosNo()}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="/back-end/pages/page2.file" %>

<!-- Page Content END -->
                
<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>
</body>

</html>