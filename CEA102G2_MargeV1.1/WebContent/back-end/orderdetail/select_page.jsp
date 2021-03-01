<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Hairtopia OrderDetail: Home</title>
</head>
<body>
<table>
	<tr><td><h3>Hairtopia OrderDetail: Home</h3></td></tr>
</table>
	
<%-- 錯誤列表 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllOrderDetail.jsp'>List</a> all OrderDetails<h4>(byDAO)</h4></li>
  <br>
  
  <li>
<h3>複合查詢</h3>	
	<form METHOD="post" ACTION="<%=request.getContextPath()%>/orderdetail/orderdetail.do" >
		
		<li><b>搜尋:</b><input type="text" name="search"></li>
		
		
		<jsp:useBean id="ordermasterSvc" scope="page" class="com.ordermaster.model.OrderMasterService" />
		<li><b>選擇訂單編號:</b>
	       <select size="1" name="ordNO" >
	         <option>
	         <c:forEach var="ordermasterVO" items="${ordermasterSvc.all}" > 
	          <option value="${ordermasterVO.ordNo}">${ordermasterVO.ordNo}
	         </c:forEach>   
	       </select>
        </li>
        
        <jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" />
     	<li><b><font color=orange>選擇商品名稱:</font></b>
	       <select size="1" name="proNo" >
	         <option>
	         <c:forEach var="productVO" items="${productSvc.all}" > 
	          <option value="${productVO.proNo}">${productVO.proName}
	         </c:forEach>   
	       </select>
        </li>
		
		<input type="hidden" name="action" value="listOrderDetails_ByCompositeQuery">
    	<input type="submit" value="送出">
	</form>
</ul>




	
</body>
</html>