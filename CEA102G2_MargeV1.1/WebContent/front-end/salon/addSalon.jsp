<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.salon.model.*"%>

<%
	SalonVO salonVO = (SalonVO)request.getAttribute("salonVO");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/salon/salon.do" name="form1">
<table>
	<tr>
		<td>髮廊名稱:</td>
		<td><input type="TEXT" name="salName" size="45" 
			 value="<%= (salonVO==null)? "" : salonVO.getSalName()%>" /></td>
	</tr>
	<tr>
		<td>髮廊地址:</td>
		<td><input type="TEXT" name="salAdd" size="45"
			 value="<%= (salonVO==null)? "" : salonVO.getSalAdd()%>" /></td>
	</tr>
	<tr>
		<td>營業時間:</td>
		<td><input type="TEXT" name="salTime" size="15"
			 value="<%= (salonVO==null)? "" : salonVO.getSalTime() %>"/></td>
		
	</tr>
	<tr>
		<td>髮廊電話:</td>
		<td><input type="TEXT" name="salPhone" size="45"
			 value="<%= (salonVO==null)? "" : salonVO.getSalPhone()%>" /></td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</body>
</html>