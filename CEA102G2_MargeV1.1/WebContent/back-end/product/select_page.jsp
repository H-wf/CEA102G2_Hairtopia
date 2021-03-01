<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Hairtopia Product: Home</title>
</head>
<body>
<table>
	<tr><td><h3>Hairtopia Product: Home</h3></td></tr>
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
  <li><a href='listAllProduct.jsp'>List</a> all Products<h4>(byDAO)</h4></li>
  <br>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" >
        <b>輸入商品編號:</b>
        <input type="text" name="proNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">                   <h4>(資料格式驗證  by Controller ).</h4> 
    </FORM>
  </li>


  <jsp:useBean id="dao" scope="page" class="com.product.model.ProductService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" >
       <b>選擇商品編號:</b>
       <select size="1" name="proNo">
         <c:forEach var="productVO" items="${dao.all}" > 
          <option value="${productVO.proNo}">${productVO.proNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" />
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ptype/ptype.do" >
       <b><font color=orange>選擇商品類別:</font></b>
       <select size="1" name="ptypeNo">
         <c:forEach var="ptypeVO" items="${ptypeSvc.all}" > 
          <option value="${ptypeVO.ptypeNo}">${ptypeVO.ptypeName}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="listProducts_ByPtypeNo">
     </FORM>
  </li>
  
  <jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" />
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/brand/brand.do" >
       <b><font color=orange>選擇品牌名稱:</font></b>
       <select size="1" name="braNo">
         <c:forEach var="brandVO" items="${brandSvc.all}" > 
          <option value="${brandVO.braNo}">${brandVO.braName}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="listProducts_ByBraNo">
     </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" >
       <b>選擇商品名稱:</b>
       <select size="1" name="proNo">
         <c:forEach var="productVO" items="${dao.all}" > 
          <option value="${productVO.proNo}">${productVO.proName}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
  
</ul>

	<h3>商品管理</h3>

	<ul>
		<li><a href='addProduct.jsp'>Add</a> a new Product.</li>
	</ul>

<h3>複合查詢</h3>
<ul>	
	<form METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" >
		<li><b>搜尋:</b><input type="text" name="search"></li>
		<li><b>選擇商品編號:</b>
	       <select size="1" name="braNO" >
	         <option>
	         <c:forEach var="productVO" items="${dao.all}" > 
	          <option value="${productVO.proNo}">${productVO.proNo}
	         </c:forEach>   
	       </select>
        </li>
     	<li><b><font color=orange>選擇商品類別:</font></b>
	       <select size="1" name="ptypeNo" >
	         <option>
	         <c:forEach var="ptypeVO" items="${ptypeSvc.all}" > 
	          <option value="${ptypeVO.ptypeNo}">${ptypeVO.ptypeName}
	         </c:forEach>   
	       </select>
        </li>
        <li><b><font color=orange>選擇品牌名稱:</font></b>
	       <select size="1" name="braNo">
	       	<option>
	         <c:forEach var="brandVO" items="${brandSvc.all}" > 
	          <option value="${brandVO.braNo}">${brandVO.braName}
	         </c:forEach>   
	       </select>
        </li>
        <li><b>選擇商品名稱:</b>
	       <select size="1" name="proNo">
	       	<option>
	         <c:forEach var="productVO" items="${dao.all}" > 
	          <option value="${productVO.proNo}">${productVO.proName}
	         </c:forEach>   
	       </select>
        </li>
		
		<input type="hidden" name="action" value="listProducts_ByCompositeQuery">
    	<input type="submit" value="送出">
	</form>
</ul>

	
</body>
</html>