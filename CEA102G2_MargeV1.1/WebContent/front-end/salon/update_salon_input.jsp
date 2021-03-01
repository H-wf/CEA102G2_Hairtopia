<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.salon.model.*"%>

<%
  SalonVO salonVO = (SalonVO) request.getAttribute("salonVO"); 
//SalonServlet.java (Concroller) 存入req的salonVO物件 (包括幫忙取出的salonVO, 也包括輸入資料錯誤時的salonVO物件)
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>髮廊資料修改 - update_salon_input.jsp</title>

</head>
<body>

<h3>髮廊資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="salon.do" name="form1">
<table>
	<tr>
		<td>髮廊編號:<font color=red><b>*</b></font></td>
		<td><%=salonVO.getSalNo()%></td>
	</tr>
	<tr>
		<td>髮廊名稱:</td>
		<td><input type="TEXT" name="salName" size="45" value="<%=salonVO.getSalName()%>" /></td>
	</tr>
	<tr>
		<td>髮廊地址:</td>
		<td><input type="TEXT" name="salAdd" size="45"	value="<%=salonVO.getSalAdd()%>" /></td>
	</tr>
	<tr>
		<td>營業時間:</td>
		<td><input type="TEXT" name="salTime" size="15" value="<%=salonVO.getSalTime()%>" /></td>
	</tr>
	<tr>
		<td>髮廊電話:</td>
		<td><input type="TEXT" name="salPhone" size="45" value="<%=salonVO.getSalPhone()%>" /></td>
	</tr>

	<tr>
		<td>髮廊狀態:</td>
		<td><select size="1" name="salStatus">
				<option value="1">營運中
				<option value="0">已停業
		</select></td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="salNo" value="<%=salonVO.getSalNo()%>">
<input type="submit" value="送出修改"></FORM>
</body>


        

</html>