<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.service.model.*"%>

<%
	ServiceVO serviceVO = (ServiceVO)request.getAttribute("serviceVO");
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/service/service.do"
	  name="form1">
<table>
<!-- 怎麼捕捉新增服務的設計師 -->
	<tr>
		<td>設計師編號:</td>
		<td><input type="TEXT" name="desNo" size="3"
			 value="<%= (serviceVO==null)? "" : serviceVO.getDesNo()%>" /></td>
	</tr>
<%--
類別建好改動態 	
<jsp:useBean id="stypeSvc" scope="page" class="com.stype.model.StypeService" /> 
--%>
	<tr>
		<td>服務類別:</td>
		<td><select size="1" name="stypeNo">
				<option value="1">洗髮
				<option value="2">剪髮
				<option value="3">染髮
				<option value="4">燙髮
				<option value="5">護髮
		</select></td>
	</tr>
	<tr>
		<td>服務名稱:</td>
		<td><input type="TEXT" name="serName" size="40"
			 value="<%= (serviceVO==null)? "" : serviceVO.getSerName()%>" /></td>
	</tr>
	
	<tr>
		<td>服務金額:</td>
		<td><input type="TEXT" name="serPrice" size="40"
			 value="<%= (serviceVO==null)? "" : serviceVO.getSerPrice()%>" /></td>
	</tr>
	
	<tr>
		<td>服務時長:</td>
		<td><select name="serTime">
			<c:forEach var="serTime" begin="1" end="10">
			<fmt:formatNumber type="number" value="${((serTime*30 -(serTime*30%60)))/60}"  var="hour"/>
				<option value="${serTime}" ${(serviceVO.serTime==serTime)? 'selected':'' } >
					<c:if test="${hour>0}">${hour}小時</c:if>
					${(serTime*30 %60 == 0)? "" :"30分" }
			</c:forEach>
		</select></td>
	</tr>
	
	<tr>
		<td>服務描述:</td>
		<td><input type="TEXT" name="serDesc" size="40"
			 value="<%= (serviceVO==null)? "" : serviceVO.getSerDesc()%>" /></td>
		
	</tr>
	
	<tr>
		<td>服務狀態:</td>
		<td><input type="range" name="serStatus" min=0 max=1
			 value="<%= (serviceVO==null)? "" : serviceVO.getSerStatus()%>" /><br>
			下架-----|-----上架	 
		</td>
		
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>
</html>