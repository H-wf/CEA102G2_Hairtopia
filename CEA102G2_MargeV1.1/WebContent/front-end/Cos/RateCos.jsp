<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*, com.coudet.model.*, com.coudet.controller.*, com.cos.controller.*" %>

<html>
<head>
<title>課程評分</title>
</head>
<body>

<%-- <%session.getAttribute("memVO");%> --%>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table style="width: 100%">
	<tr>
		<th>課程編號</th>
		<th>課程評價</th>
		<th>報名課程價格</th>
	</tr>
	<c:forEach var="cosdetVO" items="${cosdetVO}">
	<tr>
		<td>${cosdetVO.cosNo}</td>
		<td>${cosdetVO.cosComment}</td>
		<td>${cosdetVO.cosDetailPrice}</td>
		<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" style="margin-bottom: 0px;" >
			     <input type="submit" value="評分">
			     <input type="hidden" name="cosNo"  value="${cosdetVO.getCosNo()}">
			     <input type="hidden" name="memNo"  value="${cosdetVO.getMemNo()}">
			     <input type="hidden" name="cosComment"  value="${cosdetVO.getCosComment()}">
			     <input type="hidden" name="action"	value="getOneCos_For_UpdateRate"></FORM>
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


</body>
</html>