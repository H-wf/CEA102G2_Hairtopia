<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.chat.model.*"%>
<%@ page import="com.member.model.*"%>
<%-- <% --%>
<!-- 	ChatVO chatVO = (ChatVO) request.getAttribute("ChatVO"); -->
<!-- 	ChatService chatSvc = new ChatService(); -->
<!-- %> -->

<%-- <%= chatVO==null%> -- ${chatVO==null}<br>${chatVO.chatNo}<!-- 100 --> --%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>訊息資料新增 - addEmp.jsp</title>
<script src="\MVCModelVer002\resource\build\ckeditor.js"></script>

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

#output {
	width: 100px;
	height: auto;
}
</style>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>訊息資料新增 - addChat.jsp</h3>
			</td>
			<td>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/chat/select_chat_page.jsp">
						<img
						src="<%=request.getContextPath()%>/resource/images/tomcat.png"
						width="100" height="100" border="0">回首頁
					</a>
				</h4>
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
	
 	<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService" />
	<jsp:useBean id="chatVO" scope="request" class="com.chat.model.ChatVO" />
	
	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/chat/chat.do"
		name="form1" enctype="multipart/form-data">
		<table>

			<tr>
				<td>發送者:</td>
				<td><select size="1" name="chatSender" >
						<c:forEach var="memVO" items="${memSvc.all}">
							<option value="${memVO.memNo}" ${chatVO.chatSender == memVO.memNo? "checked" : ""}>${memVO.memName}
						</c:forEach>
				</select></td>
			</tr>
			
			<tr>
				<td>接收者:</td>
				<td><select size="1" name="chatReceiver">
						<c:forEach var="memVO" items="${memSvc.all}">
							<option value="${memVO.memNo}" ${chatVO.chatReceiver == memVO.memNo? "checked" : ""}>${memVO.memName}
						</c:forEach>
				</select></td>
			</tr>
			
			<tr>
				<td>訊息內容:</td>
				<td><input type="text" name="chatText" size="50"
					value="" /></td>
			</tr>
			
			<tr>
				<td>圖片:</td>
				<td><input type="file" name="chatPic" accept="image/*"
					onchange="loadFile(event)"></td>
			</tr>
			<tr>
				<td></td>
				<td><img id="output" /></td>
				<!-- 給前端預覽用  -->
				<script>
					var loadFile = function(event) {
						var output = document.getElementById('output');
						output.src = URL.createObjectURL(event.target.files[0]);
						output.onload = function() {
							URL.revokeObjectURL(output.src) // free memory
						}
					};
				</script>

			</tr>

			<!-- 	<tr> -->
			<!-- 		<td>新聞日期:</td> -->
			<!-- 		<td><input name="chatDate" id="f_date1" type="text"></td> -->
			<!-- 	</tr> -->
			<%-- 	<jsp:useBean id="deptSvc" scope="page" class="com.dept.model.DeptService" /> --%>
			<!-- 	<tr> -->
			<!-- 		<td>部門:<font color=red><b>*</b></font></td> -->
			<!-- 		<td><select size="1" name="deptno"> -->
			<%-- 			<c:forEach var="deptVO" items="${deptSvc.all}"> --%>
			<%-- 				<option value="${deptVO.deptno}" ${(chatVO.deptno==deptVO.deptno)? 'selected':'' } >${deptVO.dname} --%>
			<%-- 			</c:forEach> --%>
			<!-- 		</select></td> -->
			<!-- 	</tr> -->

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>
</body>
</html>