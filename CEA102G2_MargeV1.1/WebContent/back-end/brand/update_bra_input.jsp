<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.brand.model.*"%>

<%
	BrandVO brandVO = (BrandVO) request.getAttribute("brandVO");
%>

<html>
<head>
<meta charset="UTF-8">
<title>商品品牌資料修改</title>
</head>
<body>
<form METHOD="POST" ACTION="<%=request.getContextPath()%>/brand/brand.do" name="form1" enctype="multipart/form-data"> 
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<p class="lead mb-0">商品品牌編號:<i>${brandVO.braNo}</i></p>
	<p class="lead mb-0">商品品牌名稱:</p>
	<input required class="mb-3 mt-0" type="TEXT" name="braName" size="45" value="${brandVO.braName}" />
	<p class="lead mb-0">商品類別Logo:</p>
		<input class="mb-3 mt-0" type="file" name="braLogo" id="myFile">
	<p class="lead mb-0">商品類別介紹:</p>
	<textarea required class="mb-3 mt-0" name="braIntro" cols="30" rows="10" placeholder="請輸入品牌介紹">${brandVO.braIntro}</textarea>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		<input type="submit" class="btn btn-primary" value="修改">
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="braNo" value="${brandVO.braNo}">
	</div>
</form>
<!-- 	<table id="table-1"> -->
<!-- 		<tr> -->
<!-- 			<td> -->
<!-- 				<h3>品牌資料修改 - update_bra_input.jsp</h3> -->
<!-- 				<h4> -->
<%-- 					<a href="<%=request.getContextPath()%>/back-end/brand/select_page.jsp">回首頁</a> --%>
<!-- 				</h4> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 	</table> -->

<!-- 	<h3>資料修改:</h3> -->


 	<%-- 錯誤表列 --%> 
<%-- 	<c:if test="${not empty errorMsgs}"> --%>
<!-- 		<font style="color: red">請修正以下錯誤:</font> -->
<!-- 		<ul> -->
<%-- 			<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 				<li style="color: red">${message}</li> --%>
<%-- 			</c:forEach> --%>
<!-- 		</ul> -->
<%-- 	</c:if> --%>

<%-- 	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/brand/brand.do" name="form1" enctype="multipart/form-data"> --%>
<!-- 		<table> -->
<!-- 			<tr> -->
<!-- 				<td>品牌編號:<font color=red><b>*</b></font></td> -->
<%-- 				<td><%=brandVO.getBraNo()%></td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>品牌名稱:</td> -->
<!-- 				<td><input type="TEXT" name="braName" size="45" -->
<%-- 					value="<%=brandVO.getBraName()%>" /></td> --%>
<!-- 			</tr> -->

<!-- 			<tr> -->
<!-- 				<td>品牌Logo</td>				 -->
<!-- 				<td><input type="file" name="braLogo" id="myFile" /></td> -->
				
				
<!-- 			</tr> -->
			
			
				
				
			
			
<!-- 			<tr> -->
<!-- 				<td>品牌簡介</td> -->
<!-- 				<td><input type="TEXT" name="braIntro" size="45" -->
<%-- 					value="<%=brandVO.getBraIntro()%>" /></td> --%>
<!-- 			</tr> -->


<!-- 		</table> -->
	
	
<!-- 	<br> <input type="hidden" name="action" value="update">  -->
<%-- 		 <input type="hidden" name="braNo" value="<%=brandVO.getBraNo()%>"> --%>
<!-- 		 <input type="submit" value="送出修改"> -->
		
<!-- 	</form> -->


</body>
</html>