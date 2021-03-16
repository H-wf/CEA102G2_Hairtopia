<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.reservation.model.*"%>
<%@ page import="com.service.model.*"%>

<%
	ResVO resVO = (ResVO)request.getAttribute("resVO");
	ServiceVO serviceVO = (ServiceVO)request.getAttribute("serviceVO");
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
	#start{
		margin:auto;
		margin-top:100px;
	}
	#try{
		font-size:12px;
	}
	.form-control{
		height:10px !important;
		font-size:10px;
	}
</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid" id="start">
 <div class="row py-5 px-4 justify-content-center">
	        <div class="col-md-9 col-sm-9 mx-auto profileCard">
	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/service/service.do"
	  name="form1" id="try">

<!-- 怎麼捕捉新增服務的設計師 -->
		<div>
		設計師編號:
		<input type="TEXT" name="desNo" size="3"
			 value="<%= (serviceVO==null)? "" : serviceVO.getDesNo()%>" />
		</div>
<%--
類別建好改動態 	
<jsp:useBean id="stypeSvc" scope="page" class="com.stype.model.StypeService" /> 
--%>
	
		服務類別:<select size="1" name="stypeNo" class="form-control">
				<option value="1">洗髮
				<option value="2">剪髮
				<option value="3">染髮
				<option value="4">燙髮
				<option value="5">護髮
		</select>
		<br>
	
		服務名稱:<input class="form-control form-control-sm" type="TEXT" name="serName" size="40"
			 value="<%= (serviceVO==null)? "" : serviceVO.getSerName()%>" />
		服務金額:<input class="form-control form-control-sm" type="TEXT" name="serPrice" size="40"
			 value="<%= (serviceVO==null)? "" : serviceVO.getSerPrice()%>" />
		服務時長:<select class="form-control form-control-sm" name="serTime">
			<c:forEach var="serTime" begin="1" end="10">
			<fmt:formatNumber type="number" value="${((serTime*30 -(serTime*30%60)))/60}"  var="hour"/>
				<option value="${serTime}" ${(serviceVO.serTime==serTime)? 'selected':'' } >
					<c:if test="${hour>0}">${hour}小時</c:if>
					${(serTime*30 %60 == 0)? "" :"30分" }
			</c:forEach>
		</select>
	服務描述:<input class="form-control form-control-sm" type="TEXT" name="serDesc" size="40"
			 value="<%= (serviceVO==null)? "" : serviceVO.getSerDesc()%>" />
	服務狀態:<input type="range" name="serStatus" min=0 max=1
			 value="<%= (serviceVO==null)? "" : serviceVO.getSerStatus()%>" /><br>
			下架-----|-----上架	 
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</div>
</div>
</div>
<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>
</html>