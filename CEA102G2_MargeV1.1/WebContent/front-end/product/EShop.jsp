<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
 
 <title>Eshop.jsp</title>

</head>
<body>
<font>商城：（EShop.jsp）</font>
<hr>
<table>
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

<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService"/>
<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService"/>
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService"/>

<c:forEach var="productVO" items="${productSvc.all}"> 
<form name="shoppingForm" action="<%=request.getContextPath()%>/product/product.do" method="POST">
  <table>
  <tr> 
    <td>${ptypeSvc.getOnePtype(productVO.ptypeNo).ptypeName}</td>
    <td>${brandSvc.getOneBrand(productVO.braNo).braName}</td>
    <td>${productVO.proName}</td>
    <td>${productVO.proPrice}</td>
    <td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' width="50"></td>
    <td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proPic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' width="50"></td>
    <td>${productVO.proDesc}</td>
    <td><div align="center">數量：<input type="text" name="quantity" size="3" value=1></div></td>
  	<td width="120"><div align="center"><input type="submit" class="button" value="放入購物車"> </div></td>
  </tr>
  </table>
	<input type="hidden" name="proNo" value="${productVO.proNo}">    
    <input type="hidden" name="action" value="ADD">
</form>
 </c:forEach> 

<a href="<%=request.getContextPath()%>/front-end/product/Cart.jsp">購物車</a>
<p> 
   <jsp:include page="/front-end/product/Cart.jsp" flush="true" />
</body>
</html>