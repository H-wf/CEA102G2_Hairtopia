<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ordermaster.model.*"%>

<%
	OrderMasterVO ordermasterVO = (OrderMasterVO) request.getAttribute("ordermasterVO");
%>


<html>
<head>
<meta charset="UTF-8">
<title>訂單主檔資料修改 - update_ordermaster_input.jsp</title>
</head>
<body bgcolor='white'>
	<table id="table-1">
		<tr>
			<td>
				<h3>訂單主檔資料修改 - update_ordermaster_input.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/ordermaster/select_page.jsp">回首頁</a>
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

	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/ordermaster/ordermaster.do" name="form1" enctype="multipart/form-data">
		<table>
			<tr>
				<td>訂單編號:<font color=red><b>*</b></font></td>
				<td><%=ordermasterVO.getOrdNo()%></td>
			</tr>
			<tr>
				<td>會員編號:</td>
				<td><input type="TEXT" name="memNo" size="45"
					value="<%=ordermasterVO.getMemNo()%>" /></td>
			</tr>
			<tr>
				<td>訂單狀態:</td>
				<td><input type="TEXT" name="ordStatus" size="45"
					value="<%=ordermasterVO.getOrdStatus()%>" /></td>
			</tr>
			<tr>
				<td>總金額:</td>
				<td><input type="TEXT" name="ordAmt" size="45"
					value="<%=ordermasterVO.getOrdAmt()%>" /></td>
			</tr>



		</table>
	
	
	<br> <input type="hidden" name="action" value="update"> 
		 <input type="hidden" name="ordNo" value="<%=ordermasterVO.getOrdNo()%>">
		 <input type="submit" value="送出修改">
		
	</form>


</body>
</html>