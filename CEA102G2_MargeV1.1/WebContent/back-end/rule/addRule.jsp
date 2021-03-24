<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.rule.model.*"%>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>條款資料新增</title>
</head>
<style>
*{
	font-size:16px;
}
.h5{
	text-align:center;
}
</style>
<body>
	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/rule/rule.do" name="form1" enctype="multipart/form-data">
		<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
		</c:if>
		<p class="lead mb-0">條款標題:</p>
		<input required class="mb-3 mt-0" type="TEXT" name="ruleName" size="20" placeholder="請輸入條款標題" value="" />
		<p class="lead mb-0">條款內容:</p>
		<textarea required class="mb-3 mt-0" name="ruleCon" cols="30" rows="10" placeholder="請輸入商品描述"></textarea>
		<div class="modal-footer">
			<input name="action" value="insert" type="hidden" >
			<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			<input type="submit" class="btn btn-primary" value="新增">
		</div>
	</form>
<!-- 	<table id="table-1"> -->
<!-- 		<tr> -->
<!-- 			<td> -->
<!-- 				<h3>條款資料新增 - addRule.jsp</h3> -->
			
<!-- 			<h4><a -->
<%-- 				href="<%=request.getContextPath()%>/back-end/rule/select_rule_page.jsp"><img --%>
<%-- 					src="<%=request.getContextPath()%>/resource/images/back1.gif" --%>
<!-- 					width="100" height="32" border="0">回首頁</a></h4> -->
<!-- 					</td> -->
<!-- 		</tr> -->
<!-- 	</table> -->

<!-- 	<h3>資料新增:</h3> -->
	
 	<%-- 錯誤表列 --%> 
<%-- 	<c:if test="${not empty errorMsgs}"> --%>
<!-- 		<font style="color: red">請修正以下錯誤:</font> -->
<!-- 		<ul> -->
<%-- 			<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 				<li style="color: red">${message}</li> --%>
<%-- 			</c:forEach> --%>
<!-- 		</ul> -->
<%-- 	</c:if> --%>
<%-- 	<jsp:useBean id="ruleVO" scope="request" class="com.rule.model.RuleVO"/> --%>
<%-- 	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/rule/rule.do" name="form1"> --%>
<!-- 		<table> -->
<!-- 			<tr> -->
<!-- 				<td>條款標題:</td> -->
<!-- 				<td><input type="TEXT" name="ruleName" size="45" -->
<%-- 					value="${ruleVO.ruleName}" /></td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>條款內容:</td> -->
<!-- 				<td><input type="TEXT" name="ruleCon" size="45" -->
<%-- 					value="${ruleVO.ruleCon}" /></td> --%>
<!-- 			</tr> -->

<!-- 		</table> -->
<!-- 		<br> <input type="hidden" name="action" value="insert"> <input -->
<!-- 			type="submit" value="送出新增"> -->
<!-- 	</FORM> -->
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery/jquery.min.js"></script>
</body>
</html>