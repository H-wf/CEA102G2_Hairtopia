<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.product.model.*"%>

<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" />
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" />

<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>商品資料新增</title>
</head>
<style>
*{
	font-size:16px;
}
.h5{
	text-align:center;
}
</style>
<body>
	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/product/product.do" name="form1" enctype="multipart/form-data">
		<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
		</c:if>
		<p class="lead mb-0">商品類別:</p>
			<select size="1" name="ptypeNo">
				<c:forEach var="ptypeVO" items="${ptypeSvc.all}">
					<option value="${ptypeVO.ptypeNo}">${ptypeVO.ptypeName}
				</c:forEach>
			</select>
		<p class="lead mb-0">商品品牌:</p>
			<select size="1" name="braNo">
				<c:forEach var="brandVO" items="${brandSvc.all}">
					<option value="${brandVO.braNo}">${brandVO.braName}
				</c:forEach>
			</select>
		<p class="lead mb-0">商品名稱:</p>
		<input required class="mb-3 mt-0" type="TEXT" name="proName" size="20" placeholder="請輸入商品名稱" value="" />
		<p class="lead mb-0">上架狀態:</p>
		<label><input type="radio" name="proStatus" value="${prodouctVO.proStatus}" checked/>上架</label>					
		<label><input type="radio" name="proStatus" value="${productVO.proStatus}" />下架</label>	
		<p class="lead mb-0">商品單價:</p>
		<input required class="mb-3 mt-0" type="number" min="0" name="proPrice" size="20" placeholder="請輸入商品金額" value="" />		
		<p class="lead mb-0">商品主圖:</p>
		<input required class="mb-3 mt-0" type="file" name="proMpic" id="myFile">
		<p class="lead mb-0">商品副圖:</p>
		<input required class="mb-3 mt-0" type="file" name="proPic" id="myFile">
		<p class="lead mb-0">商品描述:</p>
		<textarea required class="mb-3 mt-0" name="proDesc" cols="30" rows="10" placeholder="請輸入商品描述"></textarea>
		<div class="modal-footer">
			<input name="action" value="insert" type="hidden" >
			<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			<input type="submit" class="btn btn-primary" value="新增">
		</div>
	</form>
                
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery/jquery.min.js"></script>
<!-- 	<table id="table-1"> -->
<!-- 		<tr> -->
<!-- 			<td> -->
<!-- 				<h3>商品資料新增 - addProduct.jsp</h3> -->
<!-- 			</td> -->
<!-- 			<td> -->
<!-- 				<h4> -->
<%-- 					<a href="<%=request.getContextPath()%>/back-end/product/select_page.jsp">回首頁</a> --%>
<!-- 				</h4> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 	</table> -->
<!-- 	<h3>資料新增:</h3> -->
 	<%-- 錯誤表列 --%>
<%-- 	<c:if test="${not empty errorMsgs}"> --%>
<!-- 		<font style="color: red">請修正以下錯誤:</font> -->
<!-- 		<ul> -->
<%-- 			<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 				<li style="color: red">${message}</li> --%>
<%-- 			</c:forEach> --%>
<!-- 		</ul> -->
<%-- 	</c:if> --%>

	

<%-- 	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/product/product.do" name="form1" enctype="multipart/form-data"> --%>
<!-- 		<table> -->
<!-- 			<tr> -->
<!-- 				<td>商品類別:</td> -->
<%-- 				 <jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" /> --%>
<!-- 				<td> -->
<!-- 					<select size="1" name="ptypeNo"> -->
<%-- 						<c:forEach var="ptypeVO" items="${ptypeSvc.all}"> --%>
<%-- 							<option value="${ptypeVO.ptypeNo}">${ptypeVO.ptypeName} --%>
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
<!-- 				</td> -->
					
<!-- 			</tr> -->

<!-- 			<tr> -->
<!-- 				<td>品牌名稱</td> -->
<%-- 				<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" /> --%>
<!-- 				<td> -->
<!-- 					<select size="1" name="braNo"> -->
<%-- 						<c:forEach var="brandVO" items="${brandSvc.all}"> --%>
<%-- 							<option value="${brandVO.braNo}">${brandVO.braName} --%>
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>商品名稱</td> -->
<!-- 				<td><input type="TEXT" name="proName" size="45" -->
<%-- 					value="<%= (productVO == null) ? "" : productVO.getProName()%>" /></td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>上架狀態</td> -->
<!-- 				<td> -->
<%-- 					<label><input type="radio" name="proStatus" value="${prodouctVO.proStatus}" checked/>上架</label>					 --%>
<%-- 					<label><input type="radio" name="proStatus" value="${productVO.proStatus}" />下架</label>				 --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>商品單價</td> -->
<!-- 				<td><input type="TEXT" name="proPrice" size="45" -->
<%-- 					value="<%= (productVO == null) ? "" : productVO.getProPrice()%>" /></td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>商品主圖</td> -->
<!-- 				<td><input type="file" name="proMpic" id="myFile"></td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>商品副圖</td> -->
<!-- 				<td><input type="file" name="proPic" id="myFile"></td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>商品描述</td> -->
<%-- 				<td><textarea name="proDesc"><%= (productVO == null) ? "" : productVO.getProDesc()%></textarea></td>					 --%>
<!-- 			</tr> -->
<!-- 		</table> -->
	
	
<!-- 		<br>  -->
<!-- 		<input name="action" value="insert" type="hidden" > -->
<!-- 		<input type="submit" value="新增"> -->
		
<!-- 	</form> -->

</body>
</html>