<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.rule.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%-- 取出 Concroller EmpServlet.java已存入request的EmpVO物件--%>
<%-- <%EmpVO empVO = (EmpVO) request.getAttribute("empVO");%> --%>

<html>
<head>
<title>條款資料 - listOneRule.jsp</title>

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
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>

</head>
<body bgcolor='white'>

	<h4>此頁暫練習採用 Script 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>條款資料 - listOneRule.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/rule/select_rule_page.jsp"><img
						src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<jsp:useBean id="ruleVO" scope="request" class="com.rule.model.RuleVO" />
	<table>
		<tr>
			<th>條款編號</th>
			<th>條款名稱</th>
			<th>條款內容</th>
		</tr>
		<tr>
			<td>${ruleVO.ruleNo}</td>
			<td>${ruleVO.ruleName}</td>
			<td>${ruleVO.ruleCon}</td>
		</tr>
	</table>

</body>
</html>