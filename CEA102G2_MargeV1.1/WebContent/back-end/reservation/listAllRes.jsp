<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.reservation.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
    ResService resSvc = new ResService();
    List<ResVO> list = resSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>�Ҧ��w����� - listAllRes.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>

<h3>�Ҧ��w����� - listAllRes.jsp</h3>


<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table class="table table-striped">
	<tr>
		<th>�w���s��</th>
		<th>�|���s��</th>
		<th>�A�ȶ���</th>
		<th>�]�p�v</th>
		<th>�w�����ͤ�</th>
		<th>�w���ɶ�</th>
		<th>�w�����A</th>
		<th>�w������</th>
		<th>�w�����ҽX</th>
		<th>�w�����B</th>
		<th>�ק�</th>
		<th>�R��</th>
	</tr>
	<jsp:useBean id="designerSvc" scope="page" class="com.designer.model.DesignerService" />
	<jsp:useBean id="serviceSvc" scope="page" class="com.service.model.ServiceService" />
	<%@ include file="page1.file" %> 
	<c:forEach var="resVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${resVO.resNo}</td>
			<td>${resVO.memNo}${param.memNo}</td>
			<td>${resVO.serNo}</td>
			<td>${resVO.desNo}</td>
			<td><fmt:formatDate value="${resVO.resProDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>
				<fmt:formatDate value="${resVO.resDate}" pattern="yyyy-MM-dd"/>
				<c:set var="serTime" value="${resVO.resTime}"/>
				<fmt:formatNumber type="number" value="${((resTime*30 -(resTime*30%60)))/60}"  var="hour"/>
				${hour}:${(serTime*30 %60 == 0)? "00" :"30" }
			</td>
			<td><c:if test="${resVO.resStatus == 0}">�f�֤�</c:if></td>
			<td>${resVO.resCom}</td> 
			<td>${resVO.resCode}</td>
			<td>${resVO.resPrice}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�">
			     <input type="hidden" name="serNo"  value="${resVO.serNo}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�R��">
			     <input type="hidden" name="resNo"  value="${resVO.resNo}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>