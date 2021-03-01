<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.chat.model.*"%>
<%@ page import="com.member.model.*"%>

<%-- <% --%>
<!--   ChatVO chatVO = (ChatVO) request.getAttribute("chatVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件) -->
<!-- %> -->
<%-- <%= chatVO==null%> -- ${chatVO== ull}<br>${empVO.deptno} --%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>訊息資料修改 - update_chat_input.jsp</title>

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
	<tr><td>
		 <h3>訊息資料修改 - update_chat_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/chat/select_chat_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

	<jsp:useBean id="memSvc" scope="request" class="com.member.model.MemService" />
	<jsp:useBean id="chatVO" scope="request" class="com.chat.model.ChatVO" />
	
	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/chat/chat.do"
		name="form1" enctype="multipart/form-data">
		<table>
			<tr>
				<td>訊息編號:<font color=red><b>*</b></font></td>
				<td>${chatVO.chatNo}</td>
			</tr>
			<tr>
				<td>發送者:</td>
				<td><select size="1" name="chatSender" >
						<c:forEach var="memVO" items="${memSvc.all}">
							<option value="${memVO.memNo}" ${chatVO.chatSender == memVO.memNo? "selected" : ""}>${memVO.memName}
						</c:forEach>
				</select></td>
			</tr>
			
			<tr>
				<td>接收者:</td>
				<td><select size="1" name="chatReceiver">
						<c:forEach var="memVO" items="${memSvc.all}">
							<option value="${memVO.memNo}" ${chatVO.chatReceiver == memVO.memNo? "selected" : ""}>${memVO.memName}
						</c:forEach>
				</select></td>
			</tr>
			
			
			<tr>
				<td>訊息內容:</td>
				<td><input type="text" name="chatText" size="50"
					value="${chatVO.chatText}" /></td>
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
<!-- 			<tr> -->
<!-- 				<td>消息時間:</td> -->
<!-- 				<td><input type="datetime-local" name="chatTime" id="f_date1" type="text"  -->
<%-- 				value="<%=chatVO.getChatTime()%>"></td> --%>
<!-- 			</tr> -->


<%-- 			<jsp:useBean id="memSvc" scope="page" --%>
<%-- 				class="com.member.model.MemService" /> --%>
<!-- 			<tr> -->
<!-- 				<td>部門:<font color=red><b>*</b></font></td> -->
<!-- 				<td><select size="1" name="deptno"> -->
<%-- 						<c:forEach var="deptVO" items="${deptSvc.all}"> --%>
<%-- 							<option value="${deptVO.deptno}" --%>
<%-- 								${(empVO.deptno==deptVO.deptno)?'selected':'' }>${deptVO.dname} --%>
<%-- 						</c:forEach> --%>
<!-- 				</select></td> -->
<!-- 			</tr> -->

		</table>
		<br> 
			<input type="hidden" name="action" value="update"> 
			<input type="hidden" name="chatNo" value="<%=chatVO.getChatNo()%>"> 
			<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
			<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:istAllEmp.jsp-->
			<input type="submit" value="送出修改">
	</FORM>
</body>

</html>