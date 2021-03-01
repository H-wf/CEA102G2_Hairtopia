<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.salon.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  SalonVO salonVO = (SalonVO) request.getAttribute("salonVO"); //SalonServlet.java(Concroller), 存入req的salonVO物件
%>

<html>
<head>
<title>髮廊資料 - listOneSalon.jsp</title>

</head>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>

<table>
	<tr>
		<th>髮廊編號</th>
		<th>髮廊名稱</th>
		<th>髮廊地址</th>
		<th>營業時間</th>
		<th>髮廊電話</th>
		<th>營業狀態</th>
	</tr>
	<tr>
		<td><%=salonVO.getSalNo()%></td>
		<td><%=salonVO.getSalName()%></td>
		<td><%=salonVO.getSalAdd()%></td>
		<td><%=salonVO.getSalTime()%></td>
		<td><%=salonVO.getSalPhone()%></td>
		<td><%=salonVO.getSalStatus()%></td>
	</tr>
</table>

</body>
</html>