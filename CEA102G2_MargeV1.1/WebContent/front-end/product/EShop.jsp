<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
 
 <title>Eshop.jsp</title>

</head>
<body>
<font size="+3">商城：（EShop.jsp）</font>
<hr>
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
 
 <!--  
       第一種action寫法: <form name="shoppingForm" action="Shopping.html" method="POST">
       第二種action寫法: <form name="shoppingForm" action="/IBM_MVC/Shopping.html" method="POST">
       第三種action寫法: <form name="shoppingForm" action="<%=request.getContextPath()%>/Shopping.html" method="POST">
 -->
 <!-- 
       當某網頁可能成為被forward的網頁時, 此網頁內的所有html連結 , 如果採用相對路徑寫法時, 因為會被加上原先forward者的路徑
       在更複雜的MVC架構中, 上面第三種寫法, 先以request.getContextPath()方法, 先取得環境(Servlet Context)目錄路徑的寫法,
       將是最佳解決方案
 -->
<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService"/>
<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService"/>
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService"/>

<c:forEach var="productVO" items="${productSvc.all}"> 
<form name="shoppingForm" action="<%=request.getContextPath()%>/orderdetail/orderdetail.do" method="POST">
  <table>
  <tr> 
    <td>${ptypeSvc.getOnePtype(productVO.ptypeNo).ptypeName}</td>
    <td>${brandSvc.getOneBrand(productVO.braNo).braName}</td>
    <td>${productVO.proName}</td>
    <td>${productVO.proPrice}</td>
    <td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${ProductVO.proNo}" alt='沒有圖片'></td>
    <td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proPic&idname=proNo&id=${ProductVO.proNo}" alt='沒有圖片'></td>
    <td>${productVO.proDesc}</td>
    <td><div align="center">數量：<input type="text" name="ordDetAmt" size="3" value=1></div></td>
  	<td width="120"><div align="center">     <input type="submit" class="button" value="放入購物車"> </div></td>
  </tr>
  </table>
	<input type="hidden" name="proNo" value="${productVO.proNo}">
	<input type="hidden" name="proPrice" value="${productVO.proPrice}">	    
    <input type="hidden" name="action" value="ADD">
</form>
 </c:forEach> 


<p> 
   <jsp:include page="${request.contextPath}/front-end/product/Cart.jsp" flush="true" /> 
</body>
</html>