<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.sertype.model.*"%>

<%
	StypeVO stypeVO = (StypeVO) request.getAttribute("stypeVO");
%>
<!DOCTYPE html>
<html>
<head>

<title>服務類別資料新增 - addStype.jsp</title>
</head>

<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>服務類別資料新增 - addStype.jsp</h3>
			</td>
			<td>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Stype/select_stype_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/tomcat.png"
						width="100" height="100" border="0">回首頁</a>
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

	

	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/stype/stype.do" name="form1" enctype="application/x-www-form-urlencoded">
		<table>
			<tr>
				<td>服務類別名稱:</td>
				<td><input type="TEXT" name="stypeName" size="45"
					value="<%=(stypeVO == null) ? "" : stypeVO.getStypeName()%>" /></td>
					
			</tr>
		</table>
	
	
		<br> 
		<input name="action" value="insert" type="hidden" >
		<input type="submit" value="新增" >
		
	</form>
	
	
	


</body>
</html>