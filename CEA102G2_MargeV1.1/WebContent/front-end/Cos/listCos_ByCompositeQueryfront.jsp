<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.cos.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:useBean id="listCos_ByCompositeQuery" scope="request" type="java.util.List<CosVO>" /> 
<jsp:useBean id="costypeSvc" scope="page" class="com.coutype.model.CostypeService" />

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <title>多查詢</title>
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
		 <h4>回課程前台</h4>
		 <li><a href="<%=request.getContextPath()%>/front-end/Cos/Course_Lec_1st.jsp">回課程前台</a></li>
	</td></tr>
</table>

<table>
	<tr>
		<th>課程編號</th>
		<th>課程名稱</th>
		<th>課程類別</th>
		<th>開課日期</th>
		<th>報名日期</th>
		<th>講師名稱</th>
	</tr>
	
	<jsp:useBean id="lecSvc" scope="page" class="com.lecturer.model.LecturerService" />

<%@ include file="/back-end/Cos/page1_ByCompositeQuery.file" %>	
	<c:forEach var="cosVO" items="${listCos_ByCompositeQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr align='center' valign='middle' ${(cosVO.cosNo==param.cosNo) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色而已-->
			<td>${cosVO.cosNo}</td>
			<td>${cosVO.cosName}</td>	
			<td><c:forEach var="costypeVO" items="${costypeSvc.all}">
                    <c:if test="${cosVO.cosTypeNo==costypeVO.cosTypeNo}">
	                    【${costypeVO.cosTypeName} - ${costypeVO.cosTypeIntro}】
                    </c:if>
                </c:forEach>
			</td>
			<td><fmt:formatDate value="${cosVO.cosFrom}" type="both"/></td>
			<td><fmt:formatDate value="${cosVO.cosApplyFrom}" type="both"/></td>
			<td>${lecSvc.getOneLecturer(cosVO.lecNo).lecName}</td>
						
		</tr>
	</c:forEach>
</table>
<%@ include file="/back-end/Cos/page2_ByCompositeQuery.file" %>

<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>
</html>