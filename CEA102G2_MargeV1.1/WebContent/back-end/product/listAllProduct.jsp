<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>

<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" />
<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" />
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" />

<!DOCTYPE html>
<html>
<head>
<title>所有商品資料</title>
<meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>
<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>
	<!-- Begin Page Content -->	
	<div class="container-fluid">
		<!-- Page Heading -->
		<div class="h3 mb-2 text-gray-800">
			商品管理
			<button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#add">								
				<i class="fas fa-plus"></i> 新增商品
			</button>
			<!-- Modal ADD -->					
			<div class="modal fade" id="add" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle">商品新增</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body pb-0">																	
					<jsp:include page="addProduct.jsp" />
				  </div>
				</div>
			</div>
		</div>		
		<!-- Modal ADD End-->
		</div>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">商品</h6>
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
						<c:forEach var="productVO" items="${productSvc.all}">
							<tr>
								<td>${productVO.proNo}</td>
								<td>
									<c:forEach var="ptypeVO" items="${ptypeSvc.all}">
                    				<c:if test="${productVO.ptypeNo==ptypeVO.ptypeNo}">
	             					【${ptypeVO.ptypeName}】
                    				</c:if>
                					</c:forEach>
            					</td>
								<td>
									<c:forEach var="brandVO" items="${brandSvc.all}">
                    				<c:if test="${productVO.braNo==brandVO.braNo}">
	                   				【${brandVO.braName}】
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
									<a href="<%=request.getContextPath()%>/product/product.do?proNo=${productVO.proNo}&action=getOne_For_Update" type="button" class="btn btn-primary btn-sm" >
										修改
									</a>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
					<!-- Modal GET_ONE-->
					<c:if test="${openModal!=null}">
						<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
						                <h4 class="modal-title" id="myModalLabel">商品修改</h4>
						                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						            </div>
									
									<div class="modal-body pb-0">
										<jsp:include page="update_product_input.jsp" />
									</div>
								</div>
							</div>
						</div>
					</c:if>	
					<!-- Modal GET_ONE End-->
				</div>
			</div>
		</div>
	</div>
<!-- Page Content END -->
                
<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>

<script>
$("#basicModal").modal({show: true});

</script>

</body>

</html>