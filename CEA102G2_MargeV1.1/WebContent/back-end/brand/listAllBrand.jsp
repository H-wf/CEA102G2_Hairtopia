<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.brand.model.*"%>

<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" />

<!DOCTYPE html>
<html lang="en">
<head>
<title>所有商品品牌資料</title>
<meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>
<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>
	<!-- Begin Page Content -->	
	<div class="container-fluid">
		<!-- Page Heading -->
		<div class="h3 mb-2 text-gray-800">
			商品品牌管理
			<button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#add">								
				<i class="fas fa-plus"></i> 新增商品品牌
			</button>
			<!-- Modal ADD -->					
			<div class="modal fade" id="add" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle">商品品牌新增</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body pb-0">																	
					<jsp:include page="addBrand.jsp" />
				  </div>
				</div>
			</div>
		</div>		
		<!-- Modal ADD End-->
		</div>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">商品品牌</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
						<thead>
							<tr>
                           		<th>品牌編號</th>
					 			<th>品牌名稱</th>
								<th>品牌logo</th>
					 			<th>品牌介紹</th> 
					 			<th>修改</th>                              
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                               	<th>品牌編號</th>
					 			<th>品牌名稱</th>
								<th>品牌logo</th>
					 			<th>品牌介紹</th> 
					 			<th>修改</th>                                 
                        	</tr>
                        </tfoot>
                        <tbody>
						<c:forEach var="brandVO" items="${brandSvc.all}">
                            <tr ${(brandVO.braNo==param.braNo) ? 'bgcolor=#F8F7F1':''}>
                                <td>${brandVO.braNo}</td>
                                <td>${brandVO.braName}</td>                                
                                <td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=brand&column=braLogo&idname=braNo&id=${brandVO.braNo}" alt='沒有圖片' width="50" height="40"></td>
                                <td>${brandVO.braIntro}</td>
                                <td>
									<a href="<%=request.getContextPath()%>/brand/brand.do?braNo=${brandVO.braNo}&action=getOne_For_Update" type="button" class="btn btn-primary btn-sm" >
										修改
									</a>									
								</td>                              
                            </tr>
						</c:forEach>       
					</table>
					<!-- Modal GET_ONE-->
					<c:if test="${openModal!=null}">
						<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
						                <h4 class="modal-title" id="myModalLabel">商品品牌修改</h4>
						                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						            </div>
									
									<div class="modal-body pb-0">
										<jsp:include page="update_bra_input.jsp" />
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

<!-- 	<h4>此頁練習採用 EL 的寫法取值:</h4> -->
<!-- 	<table id="table-1"> -->
<!-- 		<tr> -->
<!-- 			<td> -->
<!-- 				<h3>所有品牌資料 - listAllBrand.jsp</h3> -->
<!-- 				<h4> -->
<%-- 					<a href="<%=request.getContextPath()%>/back-end/brand/select_page.jsp">回首頁</a> --%>
<!-- 				</h4> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 	</table> -->

 	<%-- 錯誤表列 --%>
<%-- 	<c:if test="${not empty errorMsgs}"> --%>
<!-- 		<font style="color: red">請修正以下錯誤:</font> -->
<!-- 		<ul> -->
<%-- 			<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 				<li style="color: red">${message}</li> --%>
<%-- 			</c:forEach> --%>
<!-- 		</ul> -->
<%-- 	</c:if> --%>


<!-- 	<table> -->
<!-- 		<tr> -->
<!-- 			<th>品牌編號</th> -->
<!-- 			<th>品牌名稱</th> -->
<!-- 			<th>品牌logo</th> -->
<!-- 			<th>品牌介紹</th> -->

<!-- 		</tr> -->
<%-- 		<% --%>
<!--  			for (BrandVO brandVO : list) { -->
				
<%-- 		%> --%>

<!-- 		<tr> -->
<%-- 			<td><%=brandVO.getBraNo()%></td> --%>
<%-- 			<td><%=brandVO.getBraName()%></td> --%>
<%-- 			<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=brand&column=braLogo&idname=braNo&id=<%=brandVO.getBraNo()%>" alt='沒有圖片' /></td> --%>
<%-- 			<td><%=brandVO.getBraIntro()%></td> --%>
<!-- 			<td> -->
<!-- 				<FORM METHOD="post" -->
<%-- 					ACTION="<%=request.getContextPath()%>/brand/brand.do" --%>
<!-- 					style="margin-bottom: 0px;"> -->
<!-- 					<input type="submit" value="修改"> <input type="hidden" -->
<%-- 						name="braNo" value="<%=brandVO.getBraNo()%>"> <input --%>
<!-- 						type="hidden" name="action" value="getOne_For_Update"> -->
<!-- 				</FORM> -->
<!-- 			</td> -->
<!-- 			<td> -->
<!-- 				<FORM METHOD="post" -->
<%-- 					ACTION="<%=request.getContextPath()%>/brand/brand.do" --%>
<!-- 					style="margin-bottom: 0px;"> -->
<!-- 					<input type="submit" value="刪除"> <input type="hidden" --><%-- 						name="braNo" value="<%=brandVO.getBraNo()%>"> <input --%>
<!-- 						type="hidden" name="action" value="delete"> -->
<!-- 				</FORM> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<%-- 		<% --%>
<!--  			} -->
<%-- 		%> --%>


<!-- 	</table> -->


</body>
</html>