<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.staff.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	StaffService staSvc2 = new StaffService();
	List<StaffVO> list = staSvc2.getAll();
	pageContext.setAttribute("list", list);
%>



<!DOCTYPE html>
<html>
<head>
<style type="text/css">
img {
	width: 150px;
}
</style>
<meta charset="UTF-8">
<title>所有講師資料 - listAll_sta.jsp</title>
</head>
<body>
	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有講師資料 - listAll_sta.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Staff/select_sta_page.jsp">
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


	<table>
		<tr>
			<th>員工編號</th>
			<th>員工姓名</th>
			<th>員工帳號</th>
			<th>員工密碼</th>
			

		</tr>
	
		<jsp:useBean id="staSvc" scope="page"
			class="com.staff.model.StaffService" />

		<%@ include file="/resource/pages/page1.file" %> 
		<c:forEach var="staVO" items="${staSvc.all}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">>
			<tr>
				<td>${staVO.staName}</td>
				<td>${staVO.staNo}</td>
				<td>${staVO.staAcct}</td>
				<td>${staVO.staPswd}</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/staff/staff.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改"> <input type="hidden"
							name="staNo" value="${staVO.staNo}"> <input
							type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/staff/staff.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="staNo" value="${staVO.staNo}"> <input
							type="hidden" name="action" value="delete">
					</FORM>
				</td>
			</tr>

		</c:forEach>




	</table>
<%@ include file="/resource/pages/page2.file" %>

</body>
</html>