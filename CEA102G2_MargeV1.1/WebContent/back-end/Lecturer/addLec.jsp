<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.lecturer.model.*"%>

<%
	LecturerVO lecVO = (LecturerVO) request.getAttribute("lecVO");
%>


<html>
<head>
<script
	src="<%=request.getContextPath()%>/resource/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
	window.onload = function() {

		CKEDITOR.replace('lecIntro');

	}
</script>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>講師資料新增 - addLec.jsp</title>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>講師資料新增 - addLec.jsp</h3>
			</td>
			<td>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/Lecturer/select_lec_page.jsp">
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

	<form METHOD="POST"
		ACTION="<%=request.getContextPath()%>/lecturer/lecturer.do"
		name="form" enctype="multipart/form-data">
		<table>
			<tr>
				<td>講師名稱:</td>
				<td><input type="TEXT" name="lecName" size="48"
					value="<%=(lecVO == null) ? "" : lecVO.getLecName()%>" /></td>

			</tr>
			<tr>
				<td>員工編號:</td>
				<td><input type="TEXT" name="staNo" size="48"
					value="<%=(lecVO == null) ? "" : lecVO.getStaNo()%>" /></td>

			</tr>

			<tr>
				<td>講師照片</td>
				<td><input type="file" name="upfile1" id="myFile"></td>
			</tr>
			<tr>
				<td>講師狀態</td>
<!-- 				<td><input type="TEXT" name="lecStatus" size="48" -->
<%-- 					value="<%=(lecVO == null) ? "" : lecVO.getLecStatus()%>" /></td> --%>
				<td><select  name="lecStatus">
						<option value="0" ${lecVO.lecStatus==0 ? 'selected' : '' }>未聘請</option>
						<option value="1" ${lecVO.lecStatus==1 ? 'selected' : '' }>正常聘請</option>
						<option value="9" ${lecVO.lecStatus==9 ? 'selected' : '' }>不再聘請</option>
						
				</select></td>
			</tr>
			<tr>
				<td>講師簡介</td>
				<td><textarea id='lecIntro' row="10" cols="48" name="lecIntro"
						size="45"><%=(lecVO == null) ? "" : lecVO.getLecIntro()%></textarea>
				</td>
			</tr>
		</table>
		<br> <input name="action" value="insert" type="hidden"> <input
			type="button" value="新增" onclick="processData()">

	</form>





</body>
<script>
	function processData() {
		// getting data
		var data = CKEDITOR.instances.lecIntro.getData()
		form.submit();
	}
</script>

</html>