<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	ProductService productSvc = new ProductService();
	List<ProductVO> list = productSvc.getAll();
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" />
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" />

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
img {
	width: 150px;
}
</style>
<meta charset="UTF-8">
<title>所有商品資料 - listAllProduct.jsp</title>
</head>
<body>
	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有商品資料 - listAllProduct.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/product/select_page.jsp">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
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

	<c:forEach var="productVO" items="${list}">
		<tr>
			<td>${productVO.proNo}</td>
			<td>
				<c:forEach var="ptypeVO" items="${ptypeSvc.all}">
                    <c:if test="${productVO.ptypeNo==ptypeVO.ptypeNo}">
	                    ${ptypeVO.ptypeNo}【${ptypeVO.ptypeName}】
                    </c:if>
                </c:forEach>
            </td>
			<td>
				<c:forEach var="brandVO" items="${brandSvc.all}">
                    <c:if test="${productVO.braNo==brandVO.braNo}">
	                    ${brandVO.braNo}【${brandVO.braName}】
                    </c:if>
                </c:forEach>
			</td>
			<td>${productVO.proName}</td>			
			<td>${productVO.proStatus==true?"上架":"下架"}</td>
			<td>${productVO.proPrice}</td>
			<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' /></td>
			<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proPic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' /></td>
			<td>${productVO.proDesc}</td>
			
			

			<td>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/product/product.do"
					style="margin-bottom: 0px;">
					<input type="submit" value="修改"> <input type="hidden"
						name="proNo" value="${productVO.proNo}"> <input
						type="hidden" name="action" value="getOne_For_Update">
				</FORM>
			</td>
			<td>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/product/product.do"
					style="margin-bottom: 0px;">
					<input type="submit" value="刪除"> <input type="hidden"
						name="proNo" value="${productVO.proNo}"> <input
						type="hidden" name="action" value="delete">
				</FORM>
			</td>
		</tr>
	</c:forEach>

	</table>


</body>
</html>