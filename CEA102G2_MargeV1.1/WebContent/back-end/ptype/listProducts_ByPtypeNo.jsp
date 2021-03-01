<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.product.model.*"%>

<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" />
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" />

<html>
<head><title> listProducts_ByPtypeNo.jsp</title>

<style>
  table#table-2 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-2 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-2">
	<tr><td>
		 <h3>此商品類別之商品 - listProducts_ByPtypeNo.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/product/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>商品編號</th>
		<th>商品類別編號</th>
		<th>品牌編號</th>
		<th>商品名稱</th>
		<th>上架狀態</th>
		<th>商品單價</th>
		<th>商品主圖</th>
		<th>商品副圖</th>
		<th>商品描述</th>
	</tr>
	
	<c:forEach var="productVO" items="${listProducts_ByPtypeNo}" >
		<tr ${(productVO.proNo==param.proNo) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色-->
			<td>${productVO.proNo}</td>
			<td><c:forEach var="ptypeVO" items="${ptypeSvc.all}">
                    <c:if test="${productVO.ptypeNo==ptypeVO.ptypeNo}">
	                    ${ptypeVO.ptypeNo}【<font color=orange>${ptypeVO.ptypeName}</font>】
                    </c:if>
                </c:forEach>
			</td>
			<td>
				<c:forEach var="brandVO" items="${brandSvc.all}">
                    <c:if test="${productVO.braNo==brandVO.braNo}">
	                    ${brandVO.braNo}【<font color=orange>${brandVO.braName}</font>】
                    </c:if>
                </c:forEach>
            </td>
			<td>${productVO.proName}</td>
			<td>${productVO.proStatus==false?"未上架":"已上架"}</td>
			<td>${productVO.proPrice}</td>
			<td>${productVO.proMpic}</td>
			<td>${productVO.proPic}</td>			
			<td>${productVO.proDesc}</td>			
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" style="margin-bottom: 0px;">
			    <input type="submit" value="修改"> 
			    <input type="hidden" name="proNo"      value="${productVO.proNo}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--><!-- 目前尚未用到  -->
			    <input type="hidden" name="action"	   value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" style="margin-bottom: 0px;">
			    <input type="submit" value="刪除">
			    <input type="hidden" name="proNo"      value="${productVO.proNo}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			    <input type="hidden" name="action"     value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>