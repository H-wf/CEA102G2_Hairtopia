<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.orderdetail.model.*"%>


<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>

<jsp:useBean id="listOrderDetails_ByCompositeQuery" scope="request" type="java.util.List<OrderDetailVO>" />
<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" />


<html>
<head><title>複合查詢 - listOrderDetails_ByCompositeQuery.jsp</title>



</head>
<body bgcolor='white'>

<h4>
☆萬用複合查詢  - 可由客戶端 select_page.jsp 隨意增減任何想查詢的欄位<br>
☆此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有商品資料 - listAllOrderDetail.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/orderdetail/select_page.jsp">>回首頁</a></h4>
	</td></tr>
</table>


<table>
	<tr>
		<th>訂單編號</th>
		<th>商品名稱</th>
		<th>訂購數量</th>
		<th>明細金額</th>
	</tr>
	<c:forEach var="orderdetailVO" items="${listOrderDetails_ByCompositeQuery}">
		<tr>
			<td>${orderdetailVO.ordNo}</td>
			<td>
				<c:forEach var="productVO" items="${productSvc.all}">
                    <c:if test="${orderdetailVO.proNo==productVO.proNo}">
	                    ${productVO.proNo}【${productVO.proName}】
                    </c:if>
                </c:forEach>
            </td>
			<td>${orderdetailVO.ordDetAmt}</td>
			<td>${orderdetailVO.ordDetPrice}</td>				

			<td>
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/orderdetail/orderdetail.do" style="margin-bottom: 0px;">
					<input type="submit" value="修改"> 
					<input type="hidden" name="ordNo" value="${orderdetailVO.ordNo}">
					<input type="hidden" name="proNo" value="${orderdetailVO.proNo}"> 
					<input type="hidden" name="action" value="getOne_For_Update">
				</FORM>
			</td>
			<td>
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/orderdetail/orderdetail.do" style="margin-bottom: 0px;">
					<input type="submit" value="刪除"> 
					<input type="hidden" name="ordNo" value="${orderdetailVO.ordNo}">
					<input type="hidden" name="proNo" value="${orderdetailVO.proNo}">  
					<input type="hidden" name="action" value="delete">
				</FORM>
			</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>