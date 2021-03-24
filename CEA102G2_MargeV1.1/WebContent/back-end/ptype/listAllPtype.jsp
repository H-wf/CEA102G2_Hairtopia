<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ptype.model.*"%>

<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" />

<!DOCTYPE html>
<html lang="en">
<head>
<title>所有商品類別資料</title>
<meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>

<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>
	<!-- Begin Page Content -->	
	<div class="container-fluid">
		<!-- Page Heading -->
		<div class="h3 mb-2 text-gray-800">
			商品類別管理
			<button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#add">								
				<i class="fas fa-plus" style="color:white !important;"></i> 新增商品類別
			</button>
			<!-- Modal ADD -->					
			<div class="modal fade" id="add" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle">商品類別新增</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body pb-0">																	
					<jsp:include page="addPtype.jsp" />
				  </div>
				</div>
			</div>
		</div>		
		<!-- Modal ADD End-->
		</div>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">商品類別</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
						<thead>
							<tr>
                           		<th>商品類別編號</th>
								<th>商品類別名稱</th>                         
                                <th>修改</th>                                
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                               <th>商品類別編號</th>
							   <th>商品類別名稱</th>  
                               <th>修改</th>                               
                        	</tr>
                        </tfoot>
                        <tbody>
						<c:forEach var="ptypeVO" items="${ptypeSvc.all}">
                            <tr ${(ptypeVO.ptypeNo==param.ptypeNo) ? 'bgcolor=#F8F7F1':''}>
                                <td>${ptypeVO.ptypeNo}</td>
                                <td>${ptypeVO.ptypeName}</td>
                                <td>
									<a href="<%=request.getContextPath()%>/ptype/ptype.do?ptypeNo=${ptypeVO.ptypeNo}&action=getOne_For_Update" type="button" class="btn btn-primary btn-sm" >
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
						                <h4 class="modal-title" id="myModalLabel">商品類別修改</h4>
						                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						            </div>
									
									<div class="modal-body pb-0">
										<jsp:include page="update_ptype_input.jsp" />
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