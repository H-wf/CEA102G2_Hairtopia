<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.member.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%-- <% --%>
<!--   MemVO memVO = (MemVO) request.getAttribute("memVO"); //EmpServlet.java(Concroller), 存入req的empVO物件 -->
<!-- %> -->

<html>
<head>
<title>員工資料 - listOneEmp.jsp</title>

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
	width: 100%;
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
.headshot{
	width : 75px;
	height: auto;
}
</style>

</head>
<body bgcolor='white'>

	<h4>此頁暫練習採用 Script 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>員工資料 - ListOneEmp.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/member/select_page.jsp"><img
						src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>會員編號</th>
			<th>會員姓名</th>
			<th>性別</th>
			<th>自介</th>
			<th>信箱</th>
			<th>密碼</th>
			<th>電話</th>
			<th>地址</th>
			<th>錢包餘額</th>
			<th>狀態</th>
			<th>停權到期日</th>
			<th>啟用碼</th>
			<th>大頭照</th>
			<th>修改</th>
			<th>刪除</th>
		</tr>
		<jsp:useBean id="memVO" scope="request" class="com.member.model.MemVO" />
		<tr>
			<td>${memVO.memNo}</td>
			<td>${memVO.memName}</td>
			<td>${(memVO.memGender == 0	)?"": (memVO.memGender == 1) ? "男" : "女"}</td>
			<td>${memVO.memInform}</td>
			<td>${memVO.memEmail}</td>
			<td>${memVO.memPswd}</td>
			<td>${memVO.memPhone}</td>
			<td>${memVO.memAddr}</td>
			<td>${memVO.memBal}</td>
			<td>${(memVO.memStatus == 0	)? "未驗證": (memVO.memStatus == 1) ? "正常" : "停權"}</td>
			<td><fmt:formatDate value="${memVO.memEndDate}" pattern="yyyy-MM-dd" /></td>
			<td>${memVO.memCode}</td>
			<td><img class="headshot"
				src="<%=request.getContextPath()%>/member/showImges.do?memNo=${memVO.memNo}"></td>
		</tr>
	</table>

</body>
</html>