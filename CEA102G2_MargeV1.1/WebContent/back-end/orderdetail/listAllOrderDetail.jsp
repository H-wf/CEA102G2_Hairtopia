<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.orderdetail.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	OrderDetailService orderdetailSvc = new OrderDetailService();
	List<OrderDetailVO> list = orderdetailSvc.getAll();
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
<title>所有品牌資料 - listAllOrderDetail.jsp</title>
</head>
<body>
	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有品牌資料 - listAllOrderDetail.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/orderdetail/select_page.jsp">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<%-- 錯誤表列 --%>
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
			<th>訂單編號</th>
			<th>商品名稱</th>
			<th>訂購數量</th>
			<th>明細金額</th>

		</tr>
		
	<c:forEach var="orderdetailVO" items="${list}">
		<tr>
			<td>${orderdetailVO.ordNo}</td>			
			<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" />
			<td>${productSvc.getOneProduct(orderdetailVO.proNo).proName}</td>			
			<td>${orderdetailVO.ordDetAmt}</td>
			<td>${orderdetailVO.ordDetPrice}</td>
			<td>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/orderdetail/orderdetail.do"
					style="margin-bottom: 0px;">
					<input type="submit" value="修改"> 
					<input type="hidden" name="ordNo" value="${orderdetailVO.ordNo}>">
					<input type="hidden" name="proNo" value="${orderdetailVO.proNo}>">  
					<input type="hidden" name="action" value="getOne_For_Update">
				</FORM>
			</td>
			<td>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/orderdetail/orderdetail.do"
					style="margin-bottom: 0px;">
					<input type="submit" value="刪除"> 
					<input type="hidden" name="ordNo" value="${orderdetailVO.ordNo}>">
					<input type="hidden" name="proNo" value="${orderdetailVO.proNo}>"> 
					<input type="hidden" name="action" value="delete">
				</FORM>
			</td>
		</tr>
	</c:forEach>


	</table>


</body>
</html>