<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.service.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    ServiceService serviceSvc = new ServiceService();
    List<ServiceVO> list = serviceSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有服務資料 - listAllService.jsp</title>

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
		<th>服務編號</th>
		<th>設計師編號</th>
		<th>服務類別</th>
		<th>服務名稱</th>
		<th>服務金額</th>
		<th>服務時長</th>
		<th>服務描述</th>
		<th>服務狀態</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	
	<c:forEach var="serviceVO" items="${list}">
		<tr>
			<td>${serviceVO.getSerNo()}</td>
			<td>${serviceVO.getDesNo()}</td>
			<td>${serviceVO.getStypeNo()}</td>
			<td>${serviceVO.getSerName()}</td>
			<td>${serviceVO.getSerPrice()}</td> 
			<td>${serviceVO.getSerTime()}</td>
			<td>${serviceVO.getSerDesc()}</td>
			<td>${serviceVO.getSerStatus()}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/service/service.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="serNo"  value="${serviceVO.serNo}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/service/service.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="serNo"  value="${serviceVO.serNo}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
		</c:forEach>
</table>

</body>
</html>