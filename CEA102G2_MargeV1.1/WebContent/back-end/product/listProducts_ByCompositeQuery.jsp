<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.product.model.*"%>


<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>

<jsp:useBean id="listProducts_ByCompositeQuery" scope="request" type="java.util.List<ProductVO>" />
<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" />
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" />


<html>
<head><title>複合查詢 - listProducts_ByCompositeQuery.jsp</title>



</head>
<body bgcolor='white'>

<h4>
☆萬用複合查詢  - 可由客戶端 select_page.jsp 隨意增減任何想查詢的欄位<br>
☆此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有商品資料 - listAllProduct.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/product/select_page.jsp">>回首頁</a></h4>
	</td></tr>
</table>


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
	<c:forEach var="productVO" items="${listProducts_ByCompositeQuery}">
		<tr>
			<td>${productVO.proNo}</td>
			<td>
				<c:forEach var="ptypeVO" items="${ptypeSvc.getAll() }">
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