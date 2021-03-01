<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chat.model.*"%>
<%@ page import="com.member.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	ChatService chatSvc = new ChatService();
	List<ChatVO> list = chatSvc.getAll();
	pageContext.setAttribute("list", list);
%>


<html>
<head>
<title>所有訊息資料 - listAllChat.jsp</title>

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

	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有訊息資料 - listAllChat.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/front-end/chat/select_chat_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<table>
		<tr>
			<th>訊息編號</th>
			<th>發送者</th>
			<th>接收者</th>
			<th>訊息內容</th>
			<th>訊息時間</th>
			<th>已讀</th>
			<th>圖片</th>
			<th>修改</th>
			<th>刪除</th>
		</tr>
		<jsp:useBean id="memSvc" scope="request" class="com.member.model.MemService" />
		<%@ include file="/resource/pages/page1.file"%>
		<c:forEach var="chatVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
		
			<tr>
				<td>${chatVO.chatNo}</td>
				<td>${memSvc.getOneMem(chatVO.chatSender).memName}</td>
				<td>${memSvc.getOneMem(chatVO.chatReceiver).memName}</td>
				<td>${chatVO.chatText}</td>
				<td><fmt:formatDate value="${chatVO.chatTime}"
						pattern="yyyy-MM-dd  HH:mm:ss" /></td>
				<td>${(chatVO.chatIsRead)?"已讀":"未讀"}</td>
				<td><img class="headshot" 
				src="<%=request.getContextPath()%>/showImges.do?tableName=chat&picColumn=chatPic&pkColumn=chatNo&chatNo=${chatVO.chatNo}"></td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/chat/chat.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改"> 
						<input type="hidden" name="chatNo" value="${chatVO.chatNo}">
						<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> <!--送出本網頁的路徑給Controller-->
						<input type="hidden" name="whichPage" value="<%=whichPage%>"> <!--送出當前是第幾頁給Controller-->
						<input type="hidden" name="action" value="getOne_For_Update">
						 
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/chat/chat.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="chatNo" value="${chatVO.chatNo}"> 
						<input type="hidden" name="requestURL"
							value="<%=request.getServletPath()%>"> <!--送出本網頁的路徑給Controller-->
						<input type="hidden" name="whichPage" value="<%=whichPage%>"> <!--送出當前是第幾頁給Controller-->
						<input type="hidden" name="action" value="delete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/pages/page2.file"%>

</body>
</html>