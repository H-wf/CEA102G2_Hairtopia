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
	<title>所有商品資料 - listAllProduct.jsp<a href="<%=request.getContextPath()%>/back-end/product/select_page.jsp">回首頁</a></title>
	<meta charset="UTF-8">
<%@include file="/back-end/tempFile/head" %>
<link href="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
</head>
<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>
	<!-- Begin Page Content -->	
	<div class="container-fluid">
		<!-- Page Heading -->
		<h1 class="h3 mb-2 text-gray-800">所有商品資料 - listAllProducts.jsp</h1>
        <p class="mb-4">	
        	<%-- 錯誤表列 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
				</ul>
			</c:if>
		</p>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
						<thead>		
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
								<th>修改</th>
							</tr>
						</thead>
						<tfoot>
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
								<th>修改</th>
							</tr>
						</tfoot>
                        <tbody>
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
								<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' width="50px"/></td>
								<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proPic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' width="50px"/></td>
								<td>${productVO.proDesc}</td>
								<td>
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" style="margin-bottom: 0px;">
										<input type="submit" value="修改"> <input type="hidden" name="proNo" value="${productVO.proNo}"> <input type="hidden" name="action" value="getOne_For_Update">
									</FORM>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

<!-- Page Content END -->
                
<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- Custom scripts for all pages-->
<script src="<%=request.getContextPath()%>/dist/backTemp/js/sb-admin-2.min.js"></script>
<!-- Page level plugins -->
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.js"></script>
<!-- Page level custom scripts -->
<script src="<%=request.getContextPath()%>/dist/backTemp/js/demo/datatables-demo.js"></script>


</body>

</html>