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

.cosBtn {
	margin: 10px 10px 10px 0px;
}

</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">

<div class="container">
			<div class="row">
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/Course_Lec_1st.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">�ҵ{����</button>
					</a>
				</div>
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/listAllCosfront.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">���v�ҵ{</button>
					</a>
				</div>
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/listAllCosApplyFromfront.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn ">���W���ҵ{</button>
					</a>
				</div>
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/listAllCospostfront.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">���i�ҵ{</button>
					</a>
				</div>
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/select_cos_pagefront.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">�d�߽ҵ{</button>
					</a>
				</div>

				<div class="col-1.5" style="background-image: url()">
					<a onClick="javascript:history.back(1)">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">�^�W�@��</button>
					</a>
				</div>

			</div>
		</div>

<table  id='mytb' style="width: 77.5rem" class="table table-striped">
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