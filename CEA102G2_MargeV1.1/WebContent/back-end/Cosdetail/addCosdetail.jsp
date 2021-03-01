<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.coudet.model.*"%>

<%
  CosdetVO cosdetVO = (CosdetVO) request.getAttribute("cosdetVO");
%>
 
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>課程明細新增 - addCosdetail.jsp</title>

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
		 <h3>課程明細新增 - addCosdetail.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/Cosdetail/select_cosdetail_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>課程編號:</td>
		<td><input type="TEXT" name="cosNo" size="45" value="${cosdetVO.CosNo}" /></td>
	</tr>
	<tr>
		<td>會員編號:</td>
		<td><input type="TEXT" name="memNo" size="45" value="${cosdetVO.MemNo}" /></td>
	</tr>
	<tr>
		<td>課程評價:</td>
		<td><input type="TEXT" name="cosComment" size="45" value="${cosdetVO.CosComment}" /></td>
	</tr>
	<tr>
		<td>報名課程價格:</td>
		<td><input type="TEXT" name="cosDetailPrice" size="45" value="${cosdetVO.CosDetailPrice}" /></td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>
             
</html>