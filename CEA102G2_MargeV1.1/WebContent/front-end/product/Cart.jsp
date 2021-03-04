<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.* , com.product.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
 <title>Cart.jsp</title>
</head>
<body><br>
<%-- <% @SuppressWarnings("unchecked") --%>
<%-- Vector<ProductVO> buylist = (Vector<ProductVO>) session.getAttribute("shoppingcart");%> --%>
<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" /> 
<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" /> 
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" /> 

<c:if test="${not empty sessionScope.shoppingcart}">
<%-- <%if (buylist != null && (buylist.size() > 0)) {%> --%>
<img src="images/tomcat.gif"> <font size="+3">目前購物車的內容如下：（Cart.jsp）</font>

<table id="table-1">
    <tr> 
	    <th>商品類別</th>
	    <th>品牌名稱</th>
	    <th>商品名稱</th>
	    <th>價格</th>
	    <th>商品主圖</th>
	    <th>商品副圖</th>
	    <th>商品描述</th>
	    <th>數量</th>
	    <th><img src="images/shopping-cart.png" width="45px" height="35px"></th>
    </tr>
</table>
   
<table>
<%-- <%-- 	<% --%> 
<!-- // 	 for (int index = 0; index < buylist.size(); index++) { -->
<!-- // 		 ProductVO productVO = buylist.get(index); -->
<%-- <%-- 	%> --%> 
 <c:forEach var="productVO" items="${sessionScope.shoppingcart}" varStatus="i">
	<tr>
		<td width="200">${ptypeSvc.getOnePtype(productVO.ptypeNo).ptypeName}</td>
		<td width="100">${brandSvc.getOneBrand(productVO.braNo).braName}</td>
		<td width="100">${productVO.proName}</td>
		<td width="100">${productVO.proPrice}</td>
		<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' width="50"></td>
		<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proPic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' width="50"></td>
		<td width="120">${productVO.proDesc}</td>
		<td width="100">${productVO.quantity}</td>
        <td width="120">
          <form name="deleteForm" action="<%=request.getContextPath()%>/product/product.do" method="POST">
              <input type="hidden" name="action"  value="DELETE">
              <input type="hidden" name="del" value="${i.index}">
              <input type="submit" value="刪 除" class="button">
          </form></td>
	</tr>
 </c:forEach>
<%--  	<%} %> --%>
</table>
<p>
          <form name="checkoutForm" action="<%=request.getContextPath()%>/product/product.do" method="POST">
              <input type="hidden" name="action"  value="CHECKOUT"> 
              <input type="submit" value="付款結帳" class="button">
          </form>
<%-- <%} %> --%>
</c:if>
</body>
</html>