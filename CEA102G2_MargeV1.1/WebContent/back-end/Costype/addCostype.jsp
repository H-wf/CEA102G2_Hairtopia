<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.coutype.model.*"%>

<%
	CostypeVO costypeVO = (CostypeVO) request.getAttribute("costypeVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>課程類型新增 - addCostype.jsp</title>


</head>

<style>
* {
	font-size: 16px;
}

.h5 {
	text-align: center;
}
</style>
<body bgcolor='white'>



	<FORM METHOD="post"
		ACTION="<%=request.getContextPath()%>/coutype/coutype.do" name="form1"
		enctype="multipart/form-data">
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
		<input required class="mb-3 mt-0" type="TEXT" name="cosTypeName"
			size="20" placeholder="請輸入課程類別" value="" />
			
		<p class="lead mb-0">課程類別敘述:</p>
		<input required class="mb-3 mt-0" type="TEXT" name="cosTypeIntro" size="20" placeholder="請輸入類別敘述" value="" />



<!-- 		</table> -->
		<div class="modal-footer">
			<input type="hidden" name="action" value="insert"> 
			<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			<input type="submit" class="btn btn-primary" value="新增">
		</div>
	</FORM>
</body>



<script
	src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery/jquery.min.js"></script>
</html>