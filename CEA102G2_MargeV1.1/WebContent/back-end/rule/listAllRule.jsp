<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.rule.model.*"%>

<jsp:useBean id="ruleSvc" scope="page" class="com.rule.model.RuleService" />


<!DOCTYPE html>
<html lang="en">
<head>
<title>所有前台條款資料</title>
<meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>
<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>
	<!-- Begin Page Content -->	
	<div class="container-fluid">
		<!-- Page Heading -->
		<div class="h3 mb-2 text-gray-800">
			條款管理
			<button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#add">								
				<i class="fas fa-plus"></i> 新增條款
			</button>
			<!-- Modal ADD -->					
			<div class="modal fade" id="add" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle">條款新增</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body pb-0">																	
					<jsp:include page="addRule.jsp" />
				  </div>
				</div>
			</div>
		</div>		
		<!-- Modal ADD End-->
		</div>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">條款</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>條款編號</th>
								<th>條款名稱</th>
								<th>條款內容</th>
								<th>修改</th>
								<th>刪除</th>
							</tr>
						</thead>
                        <tfoot>
                            <tr>
                                <th>條款編號</th>
								<th>條款名稱</th>
								<th>條款內容</th>
								<th>修改</th>
								<th>刪除</th>
                        	</tr>
                        </tfoot>
                        <tbody>
						<c:forEach var="ruleVO" items="${ruleSvc.all}">
							<tr><!--將修改的那一筆加入對比色而已-->
								<td>${ruleVO.ruleNo}</td>
								<td>${ruleVO.ruleName}</td>
								<td>${ruleVO.ruleCon}</td>
								<td>
								 <a href="<%=request.getContextPath()%>/rule/rule.do?ruleNo=${ruleVO.ruleNo}&action=getOne_For_Update" type="button" class="btn btn-primary btn-sm" >
										修改
									</a>
								</td>
								<td>
								  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/rule/rule.do" style="margin-bottom: 0px;">
								     <input type="submit" value="刪除" class="btn btn-primary btn-sm">
								     <input type="hidden" name="ruleNo"      value="${ruleVO.ruleNo}">
								     <%--  <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">--%><!--送出本網頁的路徑給Controller-->
								     <input type="hidden" name="action"     value="delete"></FORM>
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
						                <h4 class="modal-title" id="myModalLabel">條款修改</h4>
						                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						            </div>
									
									<div class="modal-body pb-0">
										<jsp:include page="update_rule_input.jsp" />
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