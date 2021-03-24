<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cospost.model.*"%>

<%
    CospostService cospostSvc = new CospostService();
    List<CospostVO> list = cospostSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService" />

<!DOCTYPE html>
<html>
<head>
<title>�Ҧ��ҵ{���i���</title>
<meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>
<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>
	<!-- Begin Page Content -->	
	<div class="container-fluid">
		<!-- Page Heading -->
		<div class="h3 mb-2 text-gray-800">
			�ҵ{���i�޲z
			<button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#add">								
				<i class="fas fa-plus" style="color:white !important;"></i> �s�W�ҵ{���i
			</button>
			<!-- Modal ADD -->					
			<div class="modal fade" id="add" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle">�ҵ{���i</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body pb-0">																	
					<jsp:include page="addCospost.jsp" />
				  </div>
				</div>
			</div>
		</div>		
		<!-- Modal ADD End-->
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
								<th>���i�s��</th>
								<th>�ҵ{�W��</th>
								<th>���i���e</th>
								<th>���i�ɶ�</th>
								<th>�ק�</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th>���i�s��</th>
								<th>�ҵ{�W��</th>
								<th>���i���e</th>
								<th>���i�ɶ�</th>
								<th>�ק�</th>
							</tr>
						</tfoot>
                        <tbody>
						<c:forEach var="cospostVO" items="${list}">
							<tr>
								<td>${cospostVO.cosPubNo}</td>
								<td>
									<c:forEach var="cosVO" items="${cosSvc.all}">
                    				<c:if test="${cosVO.cosNo==cospostVO.cosNo}">
	             					�i${cosVO.cosName}�j
                    				</c:if>
                					</c:forEach>
            					</td>
								<td>${cospostVO.cosPubCon}</td>			
								<td><fmt:formatDate value="${cospostVO.cosPubTime}" pattern="yyyy-MM-dd"/></td>
								<td>
									<a href="<%=request.getContextPath()%>/cospost/cospost.do?cosPostNo=${cospostVO.cosPubNo}&action=getOne_For_Update" type="button" class="btn btn-primary btn-sm" >
										�ק�
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
						                <h4 class="modal-title" id="myModalLabel">�ҵ{���i�ק�</h4>
						                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						            </div>
									
									<div class="modal-body pb-0">
<%-- 										<jsp:include page="update_cospost_input.jsp" /> --%>
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