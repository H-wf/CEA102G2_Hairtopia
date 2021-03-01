<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.transactionRecord.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%-- 取出 Concroller EmpServlet.java已存入request的EmpVO物件--%>
<%-- <%EmpVO empVO = (EmpVO) request.getAttribute("empVO");%> --%>

<html>
<head>
<title>交易資料 - listOneTransRec.jsp</title>

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
				<h3>交易資料 - listOneRule.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/transactionRecord/select_trans_rec_page.jsp"><img
						src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<jsp:useBean id="transRecVO" scope="request" class="com.transactionRecord.model.TransRecVO" />
	<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService" />
	<table>
		<tr>
			<th>交易編號</th>
			<th>交易會員</th>
			<th>交易時間</th>
			<th>交易項目</th>
			<th>交易金額</th>
			<th>餘額</th>
		</tr>
		<tr>
			<td>${transRecVO.traNo}</td>
			<td>${memSvc.getOneMem(transRecVO.memNo).memName}</td>
			<td><fmt:formatDate value="${transRecVO.traTime}"
						pattern="yyyy-MM-dd  HH:mm:ss" /></td>
			<td>${transRecVO.traDes == 1 ? "儲值": transRecVO.traDes == 2 ? "提領": ""}</td>
			<td>${transRecVO.traPri}</td>
			<td>${transRecVO.traBal}</td>
		</tr>
	</table>

</body>
</html>