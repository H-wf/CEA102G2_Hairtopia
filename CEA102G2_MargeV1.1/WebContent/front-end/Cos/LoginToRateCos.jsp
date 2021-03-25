<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*, com.coudet.model.*, com.coudet.controller.*, com.cos.controller.*, com.member.controller.*" %>


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

#h5{
color=D8CF9E
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

<form METHOD="POST" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" name="form1">  
<input type="hidden" name="memNo" value="${userSession.memNo }">	                
<input type="hidden" name="action" value="findByMenNoToCos">
<input type="submit" value="查詢歷史休課紀錄">
</form>

<!-- Page Content END -->

<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>
</html>