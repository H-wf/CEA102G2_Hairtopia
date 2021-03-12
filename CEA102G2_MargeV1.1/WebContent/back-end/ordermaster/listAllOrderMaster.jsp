<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ordermaster.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>


<jsp:useBean id="ordermasterSvc" scope="page" class="com.ordermaster.model.OrderMasterService" />
<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService" />


<!DOCTYPE html>
<html>
<head>
	<title>所有品牌資料 - listAllOrderMaster.jsp<a href="<%=request.getContextPath()%>/back-end/ordermaster/select_page.jsp">回首頁</a></title>
	<meta charset="UTF-8">
<%@include file="/back-end/tempFile/head" %>
<link href="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
</head>
<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>
	<!-- Begin Page Content -->	
	<div class="container-fluid">
		<!-- Page Heading -->
		<h1 class="h3 mb-2 text-gray-800">所有品牌資料 - listAllBrand.jsp</h1>
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
                           		<th>訂單編號</th>
								<th>會員編號</th>
								<th>訂單狀態</th>
								<th>總金額</th>
								<th>修改</th>
                            </tr>
                        </thead>
						<tfoot>
							<tr>
                           		<th>訂單編號</th>
								<th>會員編號</th>
								<th>訂單狀態</th>
								<th>總金額</th>
								<th>修改</th>
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
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ordermaster/ordermaster.do" style="margin-bottom: 0px;">
										<input type="submit" value="修改"> <input type="hidden" name="ordNo" value="${ordermasterVO.ordNo}"> <input type="hidden" name="action" value="getOne_For_Update">
									</FORM>
								 </td>
								 </tr>
							</c:forEach>
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

</body>
</html>