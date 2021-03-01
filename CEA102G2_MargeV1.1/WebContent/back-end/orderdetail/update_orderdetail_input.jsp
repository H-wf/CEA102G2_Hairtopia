<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.orderdetail.model.*"%>

<%
	OrderDetailVO orderdetailVO = (OrderDetailVO) request.getAttribute("orderdetailVO");
%>


<html>
<head>
<meta charset="UTF-8">
<title>訂單明細資料修改 - update_orderdetail_input.jsp</title>
</head>
<body bgcolor='white'>
	<table id="table-1">
		<tr>
			<td>
				<h3>訂單明細資料修改 - update_orderdetail_input.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/orderdetail/select_page.jsp">回首頁</a>
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

	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/orderdetail/orderdetail.do" name="form1" enctype="multipart/form-data">
		<table>
			<tr>
				<td>訂單編號:<font color=red><b>*</b></font></td>
				<td><%=orderdetailVO.getOrdNo()%></td>
			</tr>
			<tr>
				<td>商品編號:</td>
				<td><input type="TEXT" name="proNo" size="45"
					value="<%=orderdetailVO.getProNo()%>" /></td>
			</tr>
			<tr>
				<td>訂購數量</td>
				<td><input type="TEXT" name="ordDetAmt" size="45"
					value="<%=orderdetailVO.getOrdDetAmt()%>" /></td>
			</tr>

			<tr>
				<td>明細金額</td>
				<td><input type="TEXT" name="ordDetPrice" size="45"
					value="<%=orderdetailVO.getOrdDetPrice()%>" /></td>
			</tr>


		</table>
	
	
	<br> <input type="hidden" name="action" value="update"> 
		 <input type="hidden" name="ordNo" value="<%=orderdetailVO.getOrdNo()%>">
		 <input type="hidden" name="proNo" value="<%=orderdetailVO.getProNo()%>">
		 <input type="submit" value="送出修改">
		
	</form>


</body>
</html>