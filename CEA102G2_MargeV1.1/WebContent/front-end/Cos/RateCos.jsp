<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*, com.coudet.model.*, com.coudet.controller.*, com.cos.controller.*" %>

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <title>課程首頁</title>
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

.submitToWhite {
        color:gray;
}

</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">
</div>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService"/>
<jsp:useBean id="cosdetSvc" scope="page" class="com.coudet.model.CosdetService"/>

<table style="width: 100%">
	<tr>
		<th>課程名稱</th>
		<th>課程評價</th>
		<th>報名課程價格</th>
	</tr>
	
	<c:forEach var="cosdetVO" items="${cosdetVO}">
	<tr>
	 <% long now = new Date().getTime();
			     	request.setAttribute("now", now);
			     %>
		<td>${cosSvc.findByPrimaryKeyCos(cosdetVO.cosNo).cosName}</td>
		<td>${cosdetVO.cosComment}</td>
		<td>${cosdetVO.cosDetailPrice}</td>
		<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" style="margin-bottom: 0px;" >
			   
			     <c:if  test="${cosSvc.findByPrimaryKeyCos(cosdetVO.cosNo).cosTo.getTime() >= now}">
			     <input type="submit" value="評分">
			     </c:if>
			     <input type="hidden" name="cosNo"  value="${cosdetVO.getCosNo()}">
			     <input type="hidden" name="memNo"  value="${cosdetVO.getMemNo()}">
			     
			     <input type="hidden" name="cosComment"  value="${cosdetVO.getCosComment()}">
			     
			     <input class="test" type="hidden" name="action" value="getOneCos_For_UpdateRate">
				
			     </FORM>
		</td>
		<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" style="margin-bottom: 0px;" >
			     <input type="submit" value="查詢QRCode">
			     <input type="hidden" name="cosNo"  value="${cosdetVO.getCosNo()}">
			     <input type="hidden" name="memNo"  value="${cosdetVO.getMemNo()}">
			     <input type="hidden" name="action"	value="ShowQRCodeByCosNoAndMemNo"></FORM>
		</td>
		</tr>
	</tr>
	</c:forEach>
	
</table>


<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>
</html>