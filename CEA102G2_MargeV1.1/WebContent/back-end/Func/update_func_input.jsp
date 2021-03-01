<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.func.model.*"%>

<%
	FuncVO funcVO = (FuncVO) request.getAttribute("funcVO");
%>
<html>
<head>
<meta charset="UTF-8">
<title>講師資料修改 - update_func_input.jsp</title>



</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>員工資料修改 - update_func_input.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/Func/select_func_page.jsp">
						<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁
					</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料修改:</h3>


	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<form METHOD="POST"
		ACTION="<%=request.getContextPath()%>/func/func.do" name="form1"
		enctype="application/x-www-form-urlencoded">
		<table>
			<tr>
				<td>功能編號:<font color=red><b>*</b></font></td>
				<td>${funcVO.funcNo}</td>
			</tr>
			<tr>
				<td>功能名稱:</td>
				<td><input type="TEXT" name="funcName" size="45" required="true"
					value="${funcVO.funcName}" /></td>
			</tr>
		


		</table>


		<br> <input type="hidden" name="action" value="update"> <input
			type="hidden" name="funcNo" value="${funcVO.funcNo}"> <input
			type="submit" id="submit"  value="送出修改">

	</form>






</body>
</html>