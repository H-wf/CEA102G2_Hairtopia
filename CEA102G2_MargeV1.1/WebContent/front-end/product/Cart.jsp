<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="java.util.* , com.orderdetail.model.*" %>
<html>
<head>
 <title>Cart.jsp</title>
</head>
<body><br>
   <% @SuppressWarnings("unchecked")
   Vector<OrderDetailVO> buylist = (Vector<OrderDetailVO>) session.getAttribute("shoppingcart");%>
<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" /> 
<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" /> 
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" /> 
<%if (buylist != null && (buylist.size() > 0)) {%>

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
	<%
	 for (int index = 0; index < buylist.size(); index++) {
		 OrderDetailVO order = buylist.get(index);
	%>
	<tr>
		<td width="200"><%=ptypeSvc.getOnePtype(productSvc.getOneProduct(order.getProNo()).getPtypeNo()).getPtypeName()%>     </td>
		<td width="100"><%=brandSvc.getOneBrand(productSvc.getOneProduct(order.getProNo()).getBraNo()).getBraName()%>   </td>
		<td width="100"><%=productSvc.getOneProduct(order.getProNo()).getProName()%></td>
		<td width="100"><%=order.getOrdDetPrice()%>    </td>
		<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${ProductVO.proNo}" alt='沒有圖片'></td>
		<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proPic&idname=proNo&id=${ProductVO.proNo}" alt='沒有圖片'></td>
		<td width="120"><%=productSvc.getOneProduct(order.getProNo()).getProDesc()%> </td>
		<td width="100"><%=order.getOrdDetAmt()%>    </td>
        <td width="120">
          <form name="deleteForm" action="<%=request.getContextPath()%>/orderdetail/orderdetail.do" method="POST">
              <input type="hidden" name="action"  value="DELETE">
              <input type="hidden" name="del" value="<%= index %>">
              <input type="submit" value="刪 除" class="button">
          </form></td>
	</tr>
	<%}%>
</table>
<p>
          <form name="checkoutForm" action="<%=request.getContextPath()%>/orderdetail/orderdetail.do" method="POST">
              <input type="hidden" name="action"  value="CHECKOUT"> 
              <input type="submit" value="付款結帳" class="button">
          </form>
<%}%>
</body>
</html>