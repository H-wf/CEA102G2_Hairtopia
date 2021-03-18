<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.service.model.*"%>
<%@ page import="com.designer.model.*"%>

<%
  ServiceVO serviceVO = (ServiceVO) request.getAttribute("serviceVO"); 
  DesignerVO designerVO = (DesignerVO) request.getAttribute("designerVO"); 
//ServiceServlet.java (Concroller) 存入req的serviceVO物件 (包括幫忙取出的serviceVO, 也包括輸入資料錯誤時的serviceVO物件)
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>服務資料修改 - update_service_input.jsp</title>

</head>
<body>

<h3>服務資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/service/service.do" name="form1">
<table>
	<!-- 怎麼捕捉新增服務的設計師 -->
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
				<option value="${serTime}" ${(serviceVO.serTime==serTime)? 'selected':'' } >${serTime*30}分鐘
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
<input type="hidden" name="action" value="update">
<input type="hidden" name="serNo" value="<%=serviceVO.getSerNo()%>">
<input type="hidden" name="desNo" value="<%=serviceVO.getDesNo()%>">
<input type="submit" value="送出修改"></FORM>
</body>


        

</html>