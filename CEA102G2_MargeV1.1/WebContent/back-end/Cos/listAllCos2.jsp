<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cos.model.*"%>
<%@ page import="com.lecturer.model.*"%>

<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService" />
<jsp:useBean id="lecSvc" scope="page" class="com.lecturer.model.LecturerService" />
<jsp:useBean id="cosdetSvc" scope="page" class="com.coudet.model.CosdetService" />
<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService" />
<!DOCTYPE html>
<html lang="en">
<head>
<title>所有課程資料</title>
<meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>
<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>
	<!-- Begin Page Content -->	
	<div class="container-fluid">
		<!-- Page Heading -->
		<div class="h3 mb-2 text-gray-800">
			課程管理
			<button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#add">								
				<i class="fas fa-plus"></i> 新增課程
			</button>
			<!-- Modal ADD -->					
			<div class="modal fade" id="add" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle">課程新增</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body pb-0">																	
					<jsp:include page="addCos2.jsp" />
				  </div>
				</div>
			</div>
		</div>		
		<!-- Modal ADD End-->
		</div>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">課程</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
						<thead>
							<tr>
                           		<th>課程編號</th>
					 			<th>課程名稱</th>
					 			<th>課程照片</th>
								<th>講師名稱</th>
					 			<th>上課期間</th>
					 			
					 			<th>查看詳情</th>  
					 			<th>修改</th>                              
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                           		<th>課程編號</th>
					 			<th>課程名稱</th>
					 			<th>課程照片</th>
								<th>講師名稱</th>
					 			<th>上課期間</th>
					 			
					 			<th>查看詳情</th>  
					 			<th>修改</th>                              
                            </tr>
                        </tfoot>
                        <tbody>
						<c:forEach var="cosVO" items="${cosSvc.all}">
                            <tr>
                                <td>${cosVO.cosNo}</td>
                                <td>${cosVO.cosName}</td>                                
                                <td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=course&column=cosPic&idname=cosNo&id=${cosVO.cosNo}" alt='沒有圖片' width="50" height="40"/></td>
                                <td>${lecSvc.getOneLecturer(cosVO.lecNo).lecName}</td>
                                <td><fmt:formatDate value="${cosVO.cosFrom}" pattern="yyyy-MM-dd"/><div style="text-align:center;">∣</div><fmt:formatDate value="${cosVO.cosTo}" pattern="yyyy-MM-dd"/></td>
                                <td>
	                                <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target=".bd-example-modal-lg${cosVO.cosNo}">查看詳情</button>
	                                <div class="modal fade bd-example-modal-lg${cosVO.cosNo}" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
									  <div class="modal-dialog modal-lg">
									    <div class="modal-content p-1">
											<div>課程編號:${cosVO.cosNo}</div>
										    <div>課程名稱:${cosVO.cosName}</div>
										    <div>講師名稱:${lecSvc.getOneLecturer(cosVO.lecNo).lecName}</div>
										    <div>類別名稱:${costypeSvc.getOneCosType(cosVO.cosTypeNo).cosTypeName}</div>
										    <div>上課期間:<fmt:formatDate value="${cosVO.cosFrom}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${cosVO.cosTo}" pattern="yyyy-MM-dd"/></div>
										    <div>報名期間:<fmt:formatDate value="${cosVO.cosApplyFrom}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${cosVO.cosApplyTo}" pattern="yyyy-MM-dd"/></div>
										    <div>課程介紹:${cosVO.cosIntro}</div>
										    <div>課程地址:${cosVO.cosAdd}</div>
										    <div>報名總人數:${cosVO.cosCount}</div>
										    <div>評價總分數:${cosVO.cosRate}</div>
										    <div>課程狀態:${cosVO.cosStatus==true?"上架":"下架"}</div>
										    <div>最低人數:${cosVO.cosMinCount}</div>
										    <div>最高人數:${cosVO.cosMaxCount}</div>
										    <div>課程價格:${cosVO.cosPrice}</div>
										    <div>報名會員:</div>
										    <c:forEach var="coudetVO" items="${cosdetSvc.getOneCosDet(cosVO.cosNo)}">
												${memSvc.getOneMem(coudetVO.memNo).memName}&emsp;

											</c:forEach>
									    </div>
									  </div>
									</div>
                                </td>
                                <td>
									<a href="<%=request.getContextPath()%>/cos/cos.do?cosNo=${cosVO.cosNo}&action=getOne_For_Update" type="button" class="btn btn-primary btn-sm" >
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
						                <h4 class="modal-title" id="myModalLabel">課程修改</h4>
						                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						            </div>									
									<div class="modal-body pb-0">
										<jsp:include page="update_cos_input2.jsp" />
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
 <script src="<%=request.getContextPath()%>/dist/backTemp/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
 <script src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery-easing/jquery.easing.min.js"></script>
 <script src="<%=request.getContextPath()%>/dist/backTemp/js/sb-admin-2.min.js"></script>
 <script src="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/jquery.dataTables.min.js"></script>
 <script src="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.js"></script>
 <script src="<%=request.getContextPath()%>/dist/backTemp/js/demo/datatables-demo.js"></script>

<script>

$("#basicModal").modal({show: true});


</script>

</body>
</html>