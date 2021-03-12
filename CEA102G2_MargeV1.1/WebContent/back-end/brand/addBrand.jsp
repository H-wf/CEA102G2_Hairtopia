<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.brand.model.*"%>

<%
	BrandVO brandVO = (BrandVO) request.getAttribute("brandVO");
%>


<html lang="en">

<head>
    <title>品牌資料新增 - addBrand.jsp</title>
    <meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>


<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>
<!-- Begin Page Content -->
<div class="container-fluid">
	<table id="table-1">
		<tr>
			<td>
				<h3>品牌資料新增 - addBrand.jsp</h3>
			</td>
			<td>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/brand/select_page.jsp">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>
	<h3>資料新增:</h3>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	

	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/brand/brand.do" name="form1" enctype="multipart/form-data">
		<table>
			<tr>
				<td>品牌名稱:</td>
				<td><input type="TEXT" name="braName" size="45"
					value="<%= (brandVO == null) ? "" : brandVO.getBraName()%>" /></td>
					
			</tr>

			<tr>
				<td>品牌logo</td>
				<td><input type="file" name="braLogo" id="myFile"></td>
			</tr>
			<tr>
				<td>品牌介紹</td>
				<td><input type="TEXT" name="braIntro" size="45"
					value="<%= (brandVO == null) ? "" : brandVO.getBraIntro()%>" /></td>
			</tr>


		</table>
	
	
		<br> 
		<input name="action" value="insert" type="hidden" >
		<input type="submit" value="新增">
		
	</form>
</div>
<!-- Page Content END -->
                
<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>
</body>
</html>