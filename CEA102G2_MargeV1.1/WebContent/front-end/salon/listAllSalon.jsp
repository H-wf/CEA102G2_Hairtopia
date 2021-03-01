<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.salon.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    SalonService salonSvc = new SalonService();
    List<SalonVO> list = salonSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有髮廊資料 - listAllSalon.jsp</title>

</head>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>髮廊編號</th>
		<th>髮廊名稱</th>
		<th>髮廊地址</th>
		<th>營業時間</th>
		<th>髮廊電話</th>
		<th>髮廊狀態</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	
	<c:forEach var="salonVO" items="${list}">
		<tr>
			<td>${salonVO.getSalNo()}</td>
			<td>${salonVO.getSalName()}</td>
			<td>${salonVO.getSalAdd()}</td>
			<td>${salonVO.getSalTime()}</td>
			<td>${salonVO.getSalPhone()}</td> 
			<td>${salonVO.getSalStatus()}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/salon/salon.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="salNo"  value="${salonVO.salNo}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/salon/salon.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="salNo"  value="${salonVO.salNo}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
		</c:forEach>
</table>

</body>
</html>