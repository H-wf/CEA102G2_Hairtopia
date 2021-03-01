<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.coudet.model.*"%>

<%
  CosdetVO cosdetVO = (CosdetVO) request.getAttribute("cosdetVO"); 
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>課程明細修改 - update_cosdetail_input.jsp</title>

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
	<tr><td>
		 <h3>課程類型修改 - update_cosdetail_input.jsp</h3>
		 <h4><a href="<%= request.getContextPath()%>/back-end/Cosdetail/select_cosdetail_page.jsp"><img src="<%= request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正~~以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>課程編號:<font color=red><b>*</b></font></td>
		<td>${cosdetVO.getCosNo()}</td>
	</tr>
	<tr>
		<td>會員編號:</td>
		<td><input type="TEXT" name="memNo" size="45" value="${cosdetVO.getMemNo()}" /></td>
	</tr>
	<tr>
		<td>課程評價:</td>
		<td><input type="TEXT" name="cosComment" size="45" value="${cosdetVO.getCosComment()}" /></td>
	</tr>
	<tr>
		<td>報名課程價格:</td>
		<td><input type="TEXT" name="cosDetailPrice" size="45" value="${cosdetVO.getCosDetailPrice()}" /></td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="cosNo" value="${cosdetVO.getCosNo()}"> <%-- 真正送出修改處 --%>
<input type="submit" value="送出修改"></FORM>
</body>
</html>       