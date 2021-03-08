<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.product.model.*,com.member.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
 <title>Mode II 範例程式 - Checkout.jsp</title>
 </head>

<body>
<img src="images/tomcat.gif"> <font size="+3">網路書店 - 結帳：（Checkout.jsp）</font>
<hr><p>
<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" /> 
<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" /> 
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" /> 
<table id="table-1" style="margin: auto;">
	<tr>
		<th>商品類別</th>
	    <th>品牌名稱</th>
	    <th>商品名稱</th>
	    <th>價格</th>
	    <th>商品主圖</th>
	    <th>商品副圖</th>
	    <th>商品描述</th>
	    <th>數量</th>
		<th width="120"><h3>小計</h3></th>
	</tr></table>
	
<form action="<%=request.getContextPath()%>/ordermaster/ordermaster.do" method="POST">		

<table style="margin: auto;">
	
 <%  @SuppressWarnings("unchecked") 
   Vector<ProductVO> buylist = (Vector<ProductVO>) session.getAttribute("shoppingcart");
   MemVO memVO = (MemVO)session.getAttribute("memVO");
   String ordAmt =  (String)session.getAttribute("ordAmt");%>

<c:forEach var="productVO" items="<%=buylist%>">
	<tr>
		<td width="200">${ptypeSvc.getOnePtype(productVO.ptypeNo).ptypeName}</td>
		<td width="100">${brandSvc.getOneBrand(productVO.braNo).braName}</td>
		<td width="100">${productVO.proName}</td>
		<td width="100">${productVO.proPrice}</td>
		<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' width="50"></td>
		<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proPic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' width="50"></td>
		<td width="120">${productVO.proDesc}</td>
		<td width="100">${productVO.quantity}</td>
		<td width="100">${(productVO.proPrice)*(productVO.quantity)}</td>
        <td width="120"></td>
	</tr>
 </c:forEach> 
	
	<tr>
		<td colspan="6" style="text-align:right;"> 
		   <font size="+2">總金額： <h4><%=ordAmt%></h4> </font>
	    </td>
	</tr>
</table>
<%session.setAttribute("buylist",buylist);%>

<input type="hidden" name="memNo" value="${sessionScope.memVO.memNo}">	                                
<input type="hidden" name="ordAmt" value="<%=ordAmt%>">	                
<input type="hidden" name="action" value="PAY">
<input type="submit" value="送出">
</form>       
       
       <p><a href="<%=request.getContextPath()%>/front-end/product/EShop.jsp"><font size="+1"> 是 否 繼 續 購 物</font></a>

</body>
</html>