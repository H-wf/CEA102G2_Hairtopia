<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ordermaster.model.*"%>

<jsp:useBean id="ordermasterSvc" scope="page" class="com.ordermaster.model.OrderMasterService" />
<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService" />

<!DOCTYPE html>
<html>
<head>
<title>所有訂單資料</title>
<meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>
<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>
	<!-- Begin Page Content -->	
<!-- 	<div class="container-fluid"> -->
		<!-- Page Heading -->
		<div class="h3 mb-2 text-gray-800">
			訂單管理
		</div>
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
                           		<th>訂單編號</th>
								<th>會員編號</th>
								<th>訂單狀態</th>
								<th>總金額</th>
								<th>明細</th>
                            </tr>
                        </thead>
						<tfoot>
							<tr>
                           		<th>訂單編號</th>
								<th>會員編號</th>
								<th>訂單狀態</th>
								<th>總金額</th>
								<th>明細</th>
                            </tr>
						</tfoot>
						<tbody>	
						<c:forEach var="ordermasterVO" items="${ordermasterSvc.all}">
							<tr>
								<td>${ordermasterVO.ordNo}</td>
								<td>
									<c:forEach var="memVO" items="${memSvc.all}">
                    					<c:if test="${ordermasterVO.memNo==memVO.memNo}">
	                    				${memVO.memNo}【${memVO.memName}】
                    					</c:if>
                					</c:forEach>
           						 </td>
								 <td><c:if test="${ordermasterVO.ordStatus==0}">未出貨</c:if>
									 <c:if test="${ordermasterVO.ordStatus==1}">已出貨</c:if>
									 <c:if test="${ordermasterVO.ordStatus==2}">已結案</c:if>
									 <c:if test="${ordermasterVO.ordStatus==3}">訂單取消</c:if>
									 <c:if test="${ordermasterVO.ordStatus==9}">退貨</c:if>
								 </td>
								 <td>${ordermasterVO.ordAmt}</td>
								 <td>
									<a href="<%=request.getContextPath()%>/ordermaster/ordermaster.do?ordNo=${ordermasterVO.ordNo}&action=listOrderMasters_ByCompositeQuery" type="button" class="btn btn-primary btn-sm" >
										查看明細
									</a>
								 </td>
								 </tr>
							</c:forEach>
							</tbody>
						</table>
					<!-- Modal GET_ONE-->
					<c:if test="${openModal!=null}">
						<div class="modal fade bd-example-modal-lg" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal myLargeModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
						                <h4 class="modal-title" id="myModalLabel">訂單明細</h4>
						                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						            </div>
									
									<div class="modal-body pb-0">
										<jsp:include page="listOrderMasters_ByCompositeQuery.jsp" />
									</div>
								</div>
							</div>
						</div>
					</c:if>	
					<!-- Modal GET_ONE End-->
				</div>
			</div>
		</div>
<!-- 	</div> -->
<!-- Page Content END -->
                
<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>

<script>
$("#basicModal").modal({show: true});

</script>

</body>

</html>

</body>
</html>