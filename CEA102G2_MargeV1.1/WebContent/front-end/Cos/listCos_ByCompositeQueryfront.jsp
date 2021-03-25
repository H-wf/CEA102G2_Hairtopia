<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.cos.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:useBean id="listCos_ByCompositeQuery" scope="request" type="java.util.List<CosVO>" /> 
<jsp:useBean id="costypeSvc" scope="page" class="com.coutype.model.CostypeService" />

<!DOCTYPE html>
<html>
<head>
<!-- �������D�n��O�o��! -->
 <title>�h�d��</title>
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
		 <h4>�^�ҵ{�e�x</h4>
		 <li><a href="<%=request.getContextPath()%>/front-end/Cos/Course_Lec_1st.jsp">�^�ҵ{�e�x</a></li>
	</td></tr>
</table>

<table>
	<tr>
		<th>�ҵ{�s��</th>
		<th>�ҵ{�W��</th>
		<th>�ҵ{���O</th>
		<th>�}�Ҥ��</th>
		<th>���W���</th>
		<th>���v�W��</th>
	</tr>
	
	<jsp:useBean id="lecSvc" scope="page" class="com.lecturer.model.LecturerService" />

<%@ include file="/back-end/Cos/page1_ByCompositeQuery.file" %>	
	<c:forEach var="cosVO" items="${listCos_ByCompositeQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr align='center' valign='middle' ${(cosVO.cosNo==param.cosNo) ? 'bgcolor=#CCCCFF':''}><!--�N�ק諸���@���[�J����Ӥw-->
			<td>${cosVO.cosNo}</td>
			<td>${cosVO.cosName}</td>	
			<td><c:forEach var="costypeVO" items="${costypeSvc.all}">
                    <c:if test="${cosVO.cosTypeNo==costypeVO.cosTypeNo}">
	                    �i${costypeVO.cosTypeName} - ${costypeVO.cosTypeIntro}�j
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