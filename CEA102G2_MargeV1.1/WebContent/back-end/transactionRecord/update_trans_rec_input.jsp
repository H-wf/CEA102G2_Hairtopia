<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.transactionRecord.model.*"%>

<%-- <% --%>
<!--   EmpVO empVO = (EmpVO) request.getAttribute("empVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件) -->
<!-- %> -->

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>交易資料修改 - update_trans_rec_input.jsp</title>

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
				<h3>交易資料修改 - update_trans_rec_input.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/transactionRecord/select_trans_rec_page.jsp"><img
						src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
			</td>
		</tr>
	</table>

	<h3>資料修改:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService" />
	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/transRec/transRec.do"
		name="form1">
		<table>
			<tr>
				<td>交易編號:<font color=red><b>*</b></font></td>
				<td>${param.traNo}</td>
			</tr>
			<tr>
				<td>交易會員:</td>
				<td><select size="1" name="memNo">
						<c:forEach var="memVO" items="${memSvc.all}">
							<option value="${memVO.memNo}"
								${transRecVO.memNo == memVO.memNo? "selected" : ""}>${memVO.memName}
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>交易項目:</td>
				<td><select size="1" name="traDes">
						<option value="1"
							${transRecVO.traDes == 1 ? "selected" : ""}>儲值
						<option value="2"
							${transRecVO.traDes == 2 ? "selected" : ""}>提領
				</select></td>
			</tr>
			
			<tr>
				<td>交易金額:</td>
				<td><input type="TEXT" name="traPri" size="45"
					value="${transRecVO.traPri}" /></td>
			</tr>
			<tr>
				<td>餘額:</td>
				<td><input type="TEXT" name="traBal" size="45"
					value="${transRecVO.traBal}" /></td>
			</tr>

		</table>
		<br> <input type="hidden" name="action" value="update"> <input
			type="hidden" name="traNo" value="${param.traNo}"> <input
			type="hidden" name="requestURL"
			value="<%=request.getParameter("requestURL")%>">
		<!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
		<input type="hidden" name="whichPage"
			value="<%=request.getParameter("whichPage")%>">
		<!--只用於:istAllEmp.jsp-->
		<input type="submit" value="送出修改">
	</FORM>

</body>

</html>