<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.chat.model.*"%>
<%@ page import="com.member.model.*"%>

<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%-- <% --%>
<!--   NewsVO newsVO = (NewsVO) request.getAttribute("newsVO"); //EmpServlet.java(Concroller), 存入req的empVO物件 -->
<!-- %> -->

<html>
<head>
<title>訊息資料 - listOneEmp.jsp</title>

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
	width: 600px;
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

	<jsp:useBean id="newVO" scope="request" class="com.chat.model.ChatVO" />
	<jsp:useBean id="memSvc" scope="request" class="com.member.model.MemService" />
	<h4>此頁暫練習採用 Script 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>訊息資料 - ListOneChatEmp.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/chat/select_chat_page.jsp"><img
						src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>訊息編號</th>
			<th>發送者</th>
			<th>接收者</th>
			<th>訊息內容</th>
			<th>訊息時間</th>
			<th>已讀</th>
			<th>圖片</th>

		</tr>
		<tr>
			<td>${chatVO.chatNo}</td>
			<td>${memSvc.getOneMem(chatVO.chatSender).memName}</td>
			<td>${memSvc.getOneMem(chatVO.chatReceiver).memName}</td>
			<td>${chatVO.chatText}</td>
			<td><fmt:formatDate value="${chatVO.chatTime}"
					pattern="yyyy-MM-dd  HH:mm:ss" /></td>
			<td>${chatVO.chatText}</td>
			<td><img class="headshot"
				src="<%=request.getContextPath()%>/showImges.do?tableName=chat&picColumn=chatPic&pkColumn=chatNo&chatNo=${chatVO.chatNo}"></td>
		</tr>
	</table>

</body>
</html>