<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.reservation.model.*"%>
<%@ page import="com.service.model.*"%>
<%@ page import="com.designer.model.*"%>

<jsp:useBean id="designerSvc" scope="page" class="com.designer.model.DesignerService" />
<jsp:useBean id="stypeSvc" scope="page" class="com.sertype.model.StypeService" />
<jsp:useBean id="serviceSvc" scope="page" class="com.service.model.ServiceService" />

<%	
	DesignerVO designerVO = (DesignerVO) request.getAttribute("designerVO");
    ServiceVO serviceVO = (ServiceVO)request.getAttribute("serviceVO");
    
%>

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <title>Hairtopia</title>
 <meta charset="utf-8">
<%@include file="/front-end/tempFile/head" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
</head>
<style>
.ftco-navbar-light{
	position:static;
}
.btn{
	font-size: 1rem;
}
.collapse{
	margin:10px auto;
}
.form-control{
	height:2.2rem !important;
	font-size:1rem;
}
input{
	font-size:1rem;
}
body{
	font-size:1rem;
	color:#777;
	font-weight:400;
}
		
/* callOutCSS */
.callout {
  background-color: #fff;
  border: 1px solid #e4e7ea;
  border-left: 4px solid #c8ced3;
  border-radius: .25rem;
  padding: .75rem 1.25rem;
  position: relative;
  margin-top:1rem;
}
.callout h4 {
  font-size: 1.3125rem;
  margin-top: 0;
  margin-bottom: .8rem
}
.callout p:last-child {
  margin-bottom: 0;
}
.callout-default{
  border-left-color: #D8CF9E;
}
.callout-default h4 {
  color: #777;
}
.callout-dismissible .close {
    position: absolute;
    top: 0;
    right: 0;
    padding: .75rem 1.25rem;
    color: inherit;
}
</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">
<div class="row">
	<div class="col-3"></div>
	<div class="col-6">
		<div class="addService">
			<a class="btn btn-primary btn-block" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
			<i class="fas fa-plus"></i>新增服務
			</a>
			<div class="collapse" id="collapseExample">
  			<div class="card card-body">
  			<%-- 錯誤表列 --%>
				<c:if test="${not empty errorMsgs}">
				<font style="color:red">請修正以下錯誤:</font>
				<ul>
				<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
				</c:forEach>
				</ul>
				</c:if>
   			 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/service/service.do"
	  			name="form1">
	  			<div class="form-group">
	  			服務類別:
	  			<select name="stypeNo" class="custom-select">
	  			<c:forEach var="stypeVO" items="${stypeSvc.all}">
	  				<option value="${stypeVO.stypeNo}">${stypeVO.stypeName}</option>
	  			</c:forEach>
	  			</select>
	  			</div>
	  			<div class="form-group">
	  			服務名稱:
	  			<input type="TEXT" name="serName" class="form-control"
			 	value="<%= (serviceVO==null)? "" : serviceVO.getSerName()%>" />
			 	</div>
			 	<div class="form-group">
			 	服務金額:
			 	<input type="TEXT" name="serPrice" class="form-control"
			 	value="<%= (serviceVO==null)? "" : serviceVO.getSerPrice()%>" />
			 	</div>
			 	<div class="form-group">
			 	服務時長:
			 	<select name="serTime" class="custom-select">
					<c:forEach var="serTime" begin="1" end="10">
					<fmt:formatNumber type="number" value="${((serTime*30 -(serTime*30%60)))/60}"  var="hour"/>
						<option value="${serTime}" ${(serviceVO.serTime==serTime)? 'selected':'' } >
						<c:if test="${hour>0}">${hour}小時</c:if>
						${(serTime*30 %60 == 0)? "" :"30分" }
					</c:forEach>
				</select>
				</div>
				<div class="form-group">
				服務描述:
				<textarea name="serDesc" class="form-control"><%= (serviceVO==null)? "" : serviceVO.getSerDesc()%></textarea><br>
			 	</div>
			 	<input type="hidden" name="desNo" value="${designerVO.desNo}">
			 	<input type="hidden" name="action" value="insert">
				<input type="submit" value="送出新增" class="btn btn-primary">
	  			
	  		 </FORM>
  			</div>
		</div>
		</div>
		<div class="ServiceCard">
		<c:forEach  var="serviceVO" items="${serviceSvc.getAllServiceByDesNo(designerVO.desNo)}">
		<div class="callout callout-default">
		<h4>${serviceVO.serName}<br><h4 style="font-size:1rem;">服務時間:　
			<c:set var="serTime" value="${serviceVO.serTime}"/>
			<fmt:formatNumber type="number" value="${((serTime*30 -(serTime*30%60)))/60}"  var="hour"/>
			<c:if test="${hour>0}">${hour}小時</c:if>${(serTime*30 %60 == 0)? "" :"30分" }</h4></h4>
										  	
		<span style="font-size:1rem;">${serviceVO.serDesc}</span>
		<hr>
		<div class="price">
		<h4 style="display:inline;font-size: unset;">優惠價:　${serviceVO.serPrice}元</h4>
		<div class="serviceAction">
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/service/service.do">
			<input type="submit" value="修改" class="btn btn-outline-primary bookingBtn">
			<input type="hidden" name="serNo"  value="${serviceVO.serNo}">
			<input type="hidden" name="action"	value="getOne_For_Update">
		</FORM>
		</div>
		</div>
		</div>
		</c:forEach>
<c:if test="${openModal!=null}">
<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
				
			<div class="modal-header">
                <h3 class="modal-title" id="myModalLabel">Service Modify</h3>
            </div>
			
			<div class="modal-body">
<!-- =========================================以下為原update_service_input.jsp的內容========================================== -->
               <jsp:include page="update_service_input.jsp" />
<!-- =========================================以上為原update_service_input.jsp的內容========================================== -->
			</div>
			
			<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
		
		</div>
	</div>
</div>
     
</c:if>
		<br><br><br><br><br><br><br><br><br><br></div>
		</div>
	<div class="col-3"></div>
		

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