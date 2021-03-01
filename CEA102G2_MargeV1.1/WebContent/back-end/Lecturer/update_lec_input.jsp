<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.lecturer.model.*"%>

<%
	LecturerVO lecVO = (LecturerVO) request.getAttribute("lecVO");
%>
<html>
<head>
<meta charset="UTF-8">
<title>講師資料修改 - update_lec_input.jsp</title>
</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>員工資料修改 - update_lec_input.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Lecturer/select_lec_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
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

	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/lecturer/lecturer.do" name="form1" enctype="multipart/form-data">
		<table>
			<tr>
				<td>講師編號:<font color=red><b>*</b></font></td>
				<td>${lecVO.lecNo}</td>
			</tr>
			<tr>
				<td>講師名稱:</td>
				<td><input type="TEXT" name="lecName" size="45"
					value="${lecVO.lecName}" /></td>
			</tr>

			<tr>
				<td>講師照片</td>
				<td><input type="file" name="upfile1" id="myFile"></td>
			</tr>
			<tr>
				<td>講師簡介</td>
				<td><input type="TEXT" name="lecIntro" size="45"
					value="${lecVO.lecIntro}" /></td>
			</tr>

			<tr>
				<td>講師狀態</td>
				<td><select  name="lecStatus">
						<option value="0" ${lecVO.lecStatus==0 ? 'selected' : '' }>未聘請</option>
						<option value="1" ${lecVO.lecStatus==1 ? 'selected' : '' }>正常聘請</option>
						<option value="9" ${lecVO.lecStatus==9 ? 'selected' : '' }>不再聘請</option>
						
				</select></td>
			</tr>
	

		</table>
	
	
	<br> <input type="hidden" name="action" value="update"> <input
			type="hidden" name="lecNo" value="${lecVO.lecNo}"> <input
			type="submit" value="送出修改">
		
	</form>


</body>
</html>