<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ordermaster.model.*"%>


<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>

<jsp:useBean id="listOrderMasters_ByCompositeQuery" scope="request" type="java.util.List<OrderMasterVO>" />
<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService" />


<html>
<head><title>複合查詢 - listOrderMasters_ByCompositeQuery.jsp</title>



</head>
<body bgcolor='white'>

<h4>
☆萬用複合查詢  - 可由客戶端 select_page.jsp 隨意增減任何想查詢的欄位<br>
☆此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有商品資料 - listAllOrderMaster.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/ordermaster/select_page.jsp">>回首頁</a></h4>
	</td></tr>
</table>


<table>
	<tr>
		<th>訂單編號</th>
		<th>會員</th>
		<th>訂購日期</th>
		<th>訂單狀態</th>
		<th>訂單金額</th>
	</tr>
	<c:forEach var="ordermasterVO" items="${listOrderMasters_ByCompositeQuery}">
		<tr>
			<td>${ordermasterVO.ordNo}</td>
			<td>
				<c:forEach var="memVO" items="${memSvc.all}">
                    <c:if test="${ordermasterVO.memNo==memVO.memNo}">
	                    ${memVO.memNo}【${memVO.memName}】
                    </c:if>
                </c:forEach>
            </td>
			<td>${ordermasterVO.ordDate}</td>
			<td>
				<c:if test="${ordermasterVO.ordStatus==0}">未出貨</c:if>
				<c:if test="${ordermasterVO.ordStatus==1}">已出貨</c:if>
				<c:if test="${ordermasterVO.ordStatus==2}">已結案</c:if>
				<c:if test="${ordermasterVO.ordStatus==3}">訂單取消</c:if>
				<c:if test="${ordermasterVO.ordStatus==9}">退貨</c:if>
			</td>				
			<td>${ordermasterVO.ordAmt}</td>	
			
			<td>
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ordermaster/ordermaster.do" style="margin-bottom: 0px;">
					<input type="submit" value="修改"> 
					<input type="hidden" name="ordNo" value="${ordermasterVO.ordNo}">
					<input type="hidden" name="action" value="getOne_For_Update">
				</FORM>
			</td>
			<td>
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ordermaster/ordermaster.do" style="margin-bottom: 0px;">
					<input type="submit" value="刪除"> 
					<input type="hidden" name="ordNo" value="${ordermasterVO.ordNo}">
					<input type="hidden" name="action" value="delete">
				</FORM>
			</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>