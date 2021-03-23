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
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/sweetAlert2/dist/sweetalert2.min.css">
</head>
<style>

</style>
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
								<th>上架</th>
								<th>明細</th>
                            </tr>
                        </thead>
						<tfoot>
							<tr>
                           		<th>訂單編號</th>
								<th>會員編號</th>
								<th>訂單狀態</th>
								<th>總金額</th>
								<th>更改狀態</th>
								<th>明細</th>
                            </tr>
						</tfoot>
						<tbody>	
						<c:forEach var="ordermasterVO" items="${ordermasterSvc.all}">
							<tr class="papa">
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
								 <form class="updateform" METHOD="POST" ACTION="<%=request.getContextPath()%>/ordermaster/ordermaster.do" enctype="multipart/form-data">
									<select size="1" name="ordStatus" class="ordStatus">										
										<option value="0"${(ordermasterVO.ordStatus==0)?'selected':'' }>未出貨
										<option value="1"${(ordermasterVO.ordStatus==1)?'selected':'' }>已出貨
										<option value="2"${(ordermasterVO.ordStatus==2)?'selected':'' }>已結案
										<option value="3"${(ordermasterVO.ordStatus==3)?'selected':'' }>訂單取消
										<option value="9"${(ordermasterVO.ordStatus==9)?'selected':'' }>退貨
									</select>
									<input type="hidden" name="ordNo" value="${ordermasterVO.ordNo}"/>
									<input type="hidden" name="memNo" value="${ordermasterVO.memNo}"/>
									<input type="hidden" name="ordAmt" value="${ordermasterVO.ordAmt}"/>
									<input type="hidden" name="action" value="update"/>
								 </form>
								 </td>
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
						<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
						  <div class="modal-dialog modal-lg">
						    <div class="modal-content">
						      <jsp:include page="listOrderMasters_ByCompositeQuery.jsp" />
						    </div>
						  </div>
						</div>
					</c:if>	
					<!-- Modal GET_ONE End-->
				</div>
			</div>
		</div>
	
<!-- Page Content END -->
                
<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>
<script src="<%=request.getContextPath()%>/resource/sweetAlert2/dist/sweetalert2.min.js"></script>
<script>
$(".bd-example-modal-lg").modal({show: true});
$(".ordStatus").change(function(){
	var index = $(this).parent().parent().parent().index();
	Swal.fire({
		title: '確定更改訂單狀態?',
		showDenyButton: true,
		confirmButtonText: '確認',
		denyButtonText: '不!!!',
	}).then((result) => {
		if (result.isConfirmed) {
			Swal.fire('Saved!', '', 'success');
			setTimeout(function(){ $(".papa").eq(index).find(".updateform").submit();}, 1500);
		}			  
	})
});
</script>

</body>

</html>

</body>
</html>