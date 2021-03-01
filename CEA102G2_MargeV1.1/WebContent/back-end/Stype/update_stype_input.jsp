<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.sertype.model.*"%>

<%
	StypeVO stypeVO = (StypeVO) request.getAttribute("stypeVO");
%>
<html>
<head>
<meta charset="UTF-8">
<title>服務資料修改 - update_stype_input.jsp</title>



</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>服務資料修改 - update_stype_input.js</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/Stype/select_stype_page.jsp">
						<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁
					</a>
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

	<form METHOD="POST"
		ACTION="<%=request.getContextPath()%>/stype/stype.do" name="form1"
		enctype="application/x-www-form-urlencoded">
		<table>
			<tr>
				<td>服務編號:<font color=red><b>*</b></font></td>
				<td>${stypeVO.stypeNo}</td>
			</tr>
			<tr>
				<td>服務名稱:</td>
				<td><input type="TEXT" name="stypeName" size="45" required="true"
					value="${stypeVO.stypeName}" /></td>
			</tr>
		


		</table>


		<br> <input type="hidden" name="action" value="update"> <input
			type="hidden" name="stypeNo" value="${stypeVO.stypeNo}"> <input
			type="submit" id="submit"  value="送出修改">

	</form>






</body>
</html>