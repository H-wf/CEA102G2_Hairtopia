<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.authority.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>




<!DOCTYPE html>
<html>
<head>
<style type="text/css">
img {
	width: 150px;
}
</style>
<meta charset="UTF-8">
<title>員工權限資料 - listAll_auth.jsp</title>
</head>
<body>
	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>員工權限資料 - listAll_auth.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Authority/select_auth_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>


	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<h2>員工姓名</h2>
	<jsp:useBean id="staSvc" scope="page" class="com.staff.model.StaffService" />
	<p> ${staSvc.getOneStaff(param.staNo).staName}
	<table>
		<tr>
			<th>功能編號</th>
			<th>功能名稱</th>
		</tr>
	
		
	<jsp:useBean id="funcSvc" scope="page" class="com.func.model.FuncService" />
		<c:set var="list" value="${list}"/>
		<c:set var="i" value="0"/>
		<c:forEach var="funcVO" items="${funcSvc.all}" varStatus="s">
			<tr>
				<td>${funcVO.funcNo}</td>
				<td>${funcVO.funcName}</td>
				<td>
				<c:choose>
				 <c:when test="${funcVO.funcNo == list[i + s.index].funcNo}">
				 <td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/authority/authority.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除權限"> 
						<input type="hidden" name="funcNo" value="${funcVO.funcNo}"> 
						<input type="hidden" name="staNo" value="${param.staNo}">
						<input type="hidden" name="action" value="listAll_auth">
					</FORM>
				</td>
				<td>
						<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/authority/authority.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="增加權限" disabled> 
						<input type="hidden" name="funcNo" value="${funcVO.funcNo}"> 
						<input type="hidden" name="staNo" value="${param.staNo}">
						<input type="hidden" name="action" value="insert">
						</FORM>
				</td>		
				</c:when>	
				<c:otherwise>
						 <td>
						<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/authority/authority.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除權限"  disabled> 
						<input type="hidden" name="funcNo" value="${funcVO.funcNo}"> 
						<input type="hidden" name="staNo" value="${param.staNo}">
						<input type="hidden" name="action" value="listAll_auth">
						</FORM>
						</td>
						<td>
						<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/authority/authority.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="增加權限" > 
						<input type="hidden" name="funcNo" value="${funcVO.funcNo}"> 
						<input type="hidden" name="staNo" value="${param.staNo}">
						<input type="hidden" name="action" value="insert">
						</FORM>
						</td>
						<c:set var="i" value="${i-1}"/>
				</c:otherwise>
				</c:choose>	
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>