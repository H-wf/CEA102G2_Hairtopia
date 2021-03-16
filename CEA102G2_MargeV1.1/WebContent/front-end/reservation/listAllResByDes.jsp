<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.reservation.model.*"%>

	<jsp:useBean id="serviceSvc" scope="page" class="com.service.model.ServiceService" />
	<jsp:useBean id="designerSvc" scope="page" class="com.designer.model.DesignerService" />

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <title>Hairtopia</title>
 <meta charset="utf-8">
<%@include file="/front-end/tempFile/head" %>
 
</head>
<style>
	.ftco-navbar-light{
		position:static;
	}
	a{
		text-decoration:none
	}
	body{
		font-size:.9rem;
		font-weight:400;
	}
	.btn-primary{
		border:0px;
		padding:.3rem .5rem;
	}
</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">
<div class="row">
	<div class="col-2"></div>
	<div class="col-8">
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<h4>設計師名稱:${designerSvc.getOneDesByDesNo(desNo).desName}</h4>
	<table class="table table-striped">
	<tr>
		<th>預約編號</th>
		<th>會員編號</th>
		<th>服務項目</th>
		<th>預約時間</th>
		<th>預約狀態</th>
		<th>預約評價</th>
		<th>預約金額</th>
		<th>預約操作</th>
	</tr>
 
	<c:forEach var="resVO" items="${list}" >
		
		<tr>
			<td><a href="res.do?resNo=${resVO.resNo}&action=getOne_For_Display_Of_Des">
				${resVO.resNo}</a></td>
			<td>${resVO.memNo}改名字</td>
			<td><c:forEach var="serviceVO" items="${serviceSvc.all}">
					<c:if test="${serviceVO.serNo==resVO.serNo}">
	            	${serviceVO.serNo}-${serviceVO.serName}
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
			<td>${resVO.resCom}</td> 
		
			<td>${resVO.resPrice}</td>
			<td style="width:8rem">
				<c:if test="${resVO.resStatus == 0}">
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" style="font-size:12px;display:inline">
			    	<input type="submit" value="確認" class="btn btn-primary" >
			    	<input type="hidden" name="resNo"  value="${resVO.resNo}">
			    	<input type="hidden" name="action"	value="getOne_For_Update_Confirm"></FORM>
			    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" style="font-size:12px;display:inline">
			    	<input type="submit" value="取消" class="btn btn-primary" style="display:inline">
			    	<input type="hidden" name="resNo"  value="${resVO.resNo}">
			   		<input type="hidden" name="action" value="cancelByDes"></FORM>
			   	</c:if>
			   	
			   
			    
			
				
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
<div class="col-2"></div>
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