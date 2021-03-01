<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.rule.model.*"%>

<%-- <% --%>
<!--   EmpVO empVO = (EmpVO) request.getAttribute("empVO"); -->
<!-- %> -->

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>條款資料新增 - addRule.jsp</title>

<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>

<style>
table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
}

table, th, td {
	border: 0px solid #CCCCFF;
}

th, td {
	padding: 1px;
}
</style>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>條款資料新增 - addRule.jsp</h3>
			
			<h4><a
				href="<%=request.getContextPath()%>/back-end/rule/select_rule_page.jsp"><img
					src="<%=request.getContextPath()%>/resource/images/back1.gif"
					width="100" height="32" border="0">回首頁</a></h4>
					</td>
		</tr>
	</table>

	<h3>資料新增:</h3>
	
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<jsp:useBean id="ruleVO" scope="request" class="com.rule.model.RuleVO"/>
	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/rule/rule.do" name="form1">
		<table>
			<tr>
				<td>條款標題:</td>
				<td><input type="TEXT" name="ruleName" size="45"
					value="${ruleVO.ruleName}" /></td>
			</tr>
			<tr>
				<td>條款內容:</td>
				<td><input type="TEXT" name="ruleCon" size="45"
					value="${ruleVO.ruleCon}" /></td>
			</tr>

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>
</body>

</html>