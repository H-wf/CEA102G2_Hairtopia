<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.coutype.model.*"%>

<%
  CostypeVO costypeVO = (CostypeVO) request.getAttribute("costypeVO"); 
%>
<html>
<head>
<meta charset="UTF-8">
<title>課程類別資料修改</title>
</head>
<body>
<form METHOD="POST" ACTION="<%=request.getContextPath()%>/coutype/coutype.do" name="form1" enctype="multipart/form-data"> 
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<p class="lead mb-0">課程類別名稱:</p>
	<input required class="mb-3 mt-0" type="TEXT" name="cosTypeName" size="45" value="${costypeVO.cosTypeName}" />
	<p class="lead mb-0">課程類別敘述:</p>
	<input required class="mb-3 mt-0" type="TEXT" name="cosTypeIntro" size="45" value="${costypeVO.cosTypeIntro}" />
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		<input type="submit" class="btn btn-primary" value="修改">
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="cosTypeNo" value="${costypeVO.cosTypeNo}">
	</div>
</form>
</body>
</html> 