<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.reservation.model.*"%>
<%@ page import="com.designer.model.*"%>

	<jsp:useBean id="serviceSvc" scope="page" class="com.service.model.ServiceService" />
	<jsp:useBean id="designerSvc" scope="page" class="com.designer.model.DesignerService" />
	<jsp:useBean id="resSvc" scope="page" class="com.reservation.model.ResService" />
	<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService" />
<%
	DesignerService desSvc = new DesignerService();
	DesignerVO desSession = desSvc.getOneDesByDesNo(2);
	pageContext.setAttribute("desSession", desSession);
%>
<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <title>Hairtopia</title>
 <meta charset="utf-8">
<%@include file="/front-end/tempFile/head" %>
 
</head>
<style>
	td,th{
		font-size:1rem;
	}
	.ftco-navbar-light{
		position:static;
	}
	a{
		text-decoration:none;
		text-align:center
	}
	.checkDetail{
		font-size:.8rem;
	}
	.btn-primary{
		border:0px;
		padding:.3rem .5rem;
	}
	.list-group-item{
		font-weight:400;
	}
	.list-group-item.active{
		background-color:#D8CF9E;
		border:0px;
	}
	.container-fluid{
		margin:5rem 0;
	}
</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>
<!-- Begin Page Content -->
<div class="container-fluid">
<div class="row">
	<div class="col-1"></div>
	<div class="col-2">
		<div class="list-group">
  			<a href="<%=request.getContextPath()%>/service/service.do?action=queryByDesNo&desNo=${desSession.desNo}" class="list-group-item list-group-item-action">
    			服務項目管理
  			</a>
  			<a href="#" class="list-group-item list-group-item-action active">
  				預約狀態管理
  			</a>
  			<a href="<%=request.getContextPath()%>/front-end/reservation/listScheduleOfDes.jsp" class="list-group-item list-group-item-action">
  				查看預約行程
  			</a>
  			<a href="<%=request.getContextPath()%>/designer/designer.do?action=getOne_For_Update&desNo=${desSession.desNo}" class="list-group-item list-group-item-action">
				個人資訊修改
			</a>
			<a href="" class="list-group-item list-group-item-action">
				貼文狀態管理
			</a>
		</div>
	</div>
	<div class="col-8">
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<h4>My Reservation</h4>
	<table class="table table-striped">
	<tr>
		<th>編號</th>
		<th>預約會員</th>
		<th>服務項目</th>
		<th>預約時間</th>
		<th>預約狀態</th>
		<th>預約明細</th>
	</tr>
 
	<c:forEach var="resVO" items="${resSvc.getAllResByDesNo(desSession.desNo)}" >
		
		<tr>
			<td>${resVO.resNo}</td>
			<td>${memSvc.getOneMemName(resVO.memNo)}</td>
			<td><c:forEach var="serviceVO" items="${serviceSvc.all}">
					<c:if test="${serviceVO.serNo==resVO.serNo}">
	            	${serviceVO.serName}
            		</c:if>
				</c:forEach></td>
			
			<td>
				<c:forEach var="serviceVO" items="${serviceSvc.all}">
					<c:if test="${serviceVO.serNo==resVO.serNo}">
	            	<c:set var="serPeriod" value="${serviceVO.serTime}"/>
            		</c:if>
				</c:forEach>
				<fmt:formatDate value="${resVO.resDate}" pattern="yyyy-MM-dd"/>
				<c:set var="startTime" value="${resVO.resTime}"/>
				<c:set var="endTime" value="${startTime+serPeriod}"/>
				<fmt:formatNumber type="number" value="${((startTime*30 -(startTime*30%60)))/60}"  var="shour"/>
				<fmt:formatNumber type="number" value="${((endTime*30 -(endTime*30%60)))/60}"  var="ehour"/>
				<c:if test="${shour<10}">0</c:if>${shour}:${(startTime*30 %60 == 0)? "00" :"30" }
				~<c:if test="${ehour<10}">0</c:if>${ehour}:${(endTime*30 %60 == 0)? "00" :"30" }
			</td>
			<td>
			<c:choose>
				<c:when test="${resVO.resStatus == 0}">
				預約待確認
				</c:when>
				<c:when test="${resVO.resStatus == 1}">
				確認待認證
				</c:when>
				<c:when test="${resVO.resStatus == 2}">
				已到店認證
				</c:when>
				<c:when test="${resVO.resStatus == 3}">
				服務已完成
				</c:when>
				<c:when test="${resVO.resStatus == 4}">
				您取消預約
				</c:when>
				<c:when test="${resVO.resStatus == 5}">
				會員已取消
				</c:when>
				<c:otherwise>
				會員未到
				</c:otherwise>
			</c:choose>
			</td>
			<td>
			   	<a href="res.do?resNo=${resVO.resNo}&action=getOne_For_Display_Of_Des" class="checkDetail" style="display:inline">查看明細</a>
			</td>
			
		</tr>
	</c:forEach>
</table>
<c:if test="${openModal!=null}">
<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Reservation Detail</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
			
			<div class="modal-body">
<!-- =========================================以下為原listOneEmp.jsp的內容========================================== -->
               <jsp:include page="listOneResOfDes.jsp" />
<!-- =========================================以上為原listOneEmp.jsp的內容========================================== -->
			</div>
			
			<div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
		
		</div>
	</div>
</div>
</c:if>
</div>
<div class="col-1"></div>
</div>
</div>

<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>
<script>
    $("#basicModal").modal({show: true});
</script>
</html>