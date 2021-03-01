<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ordermaster.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>


<jsp:useBean id="ordermasterSvc" scope="page" class="com.ordermaster.model.OrderMasterService" />
<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService" />


<!DOCTYPE html>
<html>
<head>
<style type="text/css">
img {
	width: 150px;
}
</style>
<meta charset="UTF-8">
<title>所有品牌資料 - listAllOrderMaster.jsp</title>
</head>
<body>
	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有品牌資料 - listAllOrderMaster.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/ordermaster/select_page.jsp">回首頁</a>
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
			<th>會員編號</th>
			<th>訂單狀態</th>
			<th>總金額</th>

		</tr>
		<c:forEach var="ordermasterVO" items="${ordermasterSvc.all}">
		<tr>
			<td>${ordermasterVO.ordNo}</td>
			<td>
				<c:forEach var="memVO" items="${memSvc.all}">
                    <c:if test="${ordermasterVO.memNo==memVO.memNo}">
	                    ${memVO.memNo}【${memVO.memName}】
                    </c:if>
                </c:forEach>
            </td>
			<td><c:if test="${ordermasterVO.ordStatus==0}">未出貨</c:if>
				<c:if test="${ordermasterVO.ordStatus==1}">已出貨</c:if>
				<c:if test="${ordermasterVO.ordStatus==2}">已結案</c:if>
				<c:if test="${ordermasterVO.ordStatus==3}">訂單取消</c:if>
				<c:if test="${ordermasterVO.ordStatus==9}">退貨</c:if>
			</td>
			<td>${ordermasterVO.ordAmt}</td>
			<td>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/ordermaster/ordermaster.do"
					style="margin-bottom: 0px;">
					<input type="submit" value="修改"> <input type="hidden"
						name="ordNo" value="${ordermasterVO.ordNo}"> <input
						type="hidden" name="action" value="getOne_For_Update">
				</FORM>
			</td>
			<td>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/ordermaster/ordermaster.do"
					style="margin-bottom: 0px;">
					<input type="submit" value="刪除"> <input type="hidden"
						name="ordNo" value="${ordermasterVO.ordNo}"> <input
						type="hidden" name="action" value="delete">
				</FORM>
			</td>
		</tr>
	</c:forEach>


	</table>


</body>
</html>