<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.member.model.*,com.ordermaster.model.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <title>Hairtopia</title>
 <meta charset="utf-8">
<%-- <%@include file="/front-end/tempFile/head" %> --%>
 
</head>
<style>
.ftco-navbar-light{
	position:static;
	z-index:100;
}
.myorder{
	text-align:center;
	font-size:25px;
}
td,th{
	text-align:center;
	font-size:1rem;
}
.table-2 tbody tr:nth-of-type(odd){
    background-color: rgba(0, 0, 0, 0);
}
.paper{
	border:0.1px solid #969592;
	box-shadow: 12px 12px 7px rgba(150, 149, 146, 0.6);
}
.modal-content>*{
	text-align:left;
}
.line{
	border-bottom:solid #BDB58C;
	font-size:22px;
	color:#333333;
}
ul{
	list-style-type:none;
}
</style>
<body>
<%-- <%@include file="/front-end/tempFile/navBar" %> --%>

<!-- Begin Page Content -->
<div class="container-fluid px-0">
<jsp:useBean id="ordmSvc" scope="page" class="com.ordermaster.model.OrderMasterService" />
<jsp:useBean id="orddSvc" scope="page" class="com.orderdetail.model.OrderDetailService" />
<jsp:useBean id="proSvc" scope="page" class="com.product.model.ProductService" />
<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" />
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" />
	
	
	
	
	<table class="table table-striped">
	<tr>
		<th>訂單編號</th>
		<th>訂購日期</th>
		<th>訂單狀態</th>
		<th>訂單金額</th>
		<th></th>
		<th></th>	
	</tr>

		<c:forEach var="ordmVO" items="${ordmSvc.all}">
		<c:if test="${sessionScope.userSession.memNo==ordmVO.memNo}">
	<tr>
		<td class="ordNo">${ordmVO.ordNo}</td>
		<td class="ordDate"><fmt:formatDate pattern="yyyy-MM-dd" value="${ordmVO.ordDate}" /></td>
		<td class="ordStatus">
			<c:choose>
				<c:when test="${ordmVO.ordStatus == 0}">
				未出貨
				</c:when>
				<c:when test="${ordmVO.ordStatus == 1}">
				已出貨
				</c:when>
				<c:when test="${ordmVO.ordStatus == 2}">
				已結案
				</c:when>
				<c:when test="${ordmVO.ordStatus == 3}">
				訂單取消
				</c:when>
				<c:otherwise>
				退貨
				</c:otherwise>
			</c:choose>
		</td>
		<td class="ordAmt">${ordmVO.ordAmt}</td>
		<td><button type="button" class="btn btn-primary cancel">取消訂單</button></td>
		<td>
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target=".mymodal${ordmVO.ordNo}">查看明細</button>
			<div class="modal fade bd-example-modal-lg mymodal${ordmVO.ordNo}" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
			  <div class="modal-dialog modal-lg">
			    <div class="modal-content" style="padding:10px;">
					<div class="line">訂單資訊</div>
					<div class="row">
						<div class="col-6">
							<ul>
								<li>訂單編號:&emsp;${ordmVO.ordNo}
								<li>訂單狀態:&emsp;
									<c:choose>
										<c:when test="${ordmVO.ordStatus == 0}">
										未出貨
										</c:when>
										<c:when test="${ordmVO.ordStatus == 1}">
										已出貨
										</c:when>
										<c:when test="${ordmVO.ordStatus == 2}">
										已結案
										</c:when>
										<c:when test="${ordmVO.ordStatus == 3}">
										訂單取消
										</c:when>
										<c:otherwise>
										退貨
										</c:otherwise>
									</c:choose>
							</ul>
						</div>
						<div class="col-6">
							<ul>
								<li>訂購日期:&emsp;<fmt:formatDate pattern="yyyy-MM-dd" value="${ordmVO.ordDate}" />
								<li>付款方式:&emsp;信用卡
							</ul>
						</div>						
					</div>
					<div class="line">購買清單</div>	
					<table class="table table-2">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">商品圖片</th>
								<th scope="col">商品名稱</th>
								<th scope="col">商品類別</th>
								<th scope="col">品牌名稱</th>
								<th scope="col">價格</th>
								<th scope="col">數量</th>
								<th scope="col">小計</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="i" value="0" />
					        <c:forEach var="orddVO" items="${orddSvc.all}">			      				      		
					      	<c:if test="${orddVO.ordNo == ordmVO.ordNo}">
					      	<c:set var="i" value="${i+1}" />
							<tr>
								<th scope="row">${i}</th>
								<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${orddVO.proNo}"alt='沒有圖片' width="50" height="40"></td>
								<td>${proSvc.getOneProduct(orddVO.proNo).proName}</td>
								<td>${ptypeSvc.getOnePtype(proSvc.getOneProduct(orddVO.proNo).ptypeNo).ptypeName}</td>
								<td>${brandSvc.getOneBrand(proSvc.getOneProduct(orddVO.proNo).braNo).braName}</td>
								<td>${orddVO.ordDetPrice/orddVO.ordDetAmt}</td>
								<td>${orddVO.ordDetAmt}</td>
								<td>${orddVO.ordDetPrice}</td>
							</tr>
							</c:if>						   
					      	</c:forEach>
					      	<tr>
					      		<th scope="row"></th>
					      		<td></td>
					      		<td></td>
					      		<td></td>
					      		<td></td>
					      		<td></td>
								<td>TOTAL</td>
								<td>NT$${ordmVO.ordAmt}</td>
					      	</tr>			      		  
						</tbody>
					</table>
						<div class="row">
							<div class="col-6">
							<div class="line">訂購人資訊</div>
								<ul>
									<li>訂購人姓名:&emsp;${sessionScope.userSession.memNo}
									<li>訂購人信箱:&emsp;${sessionScope.userSession.memEmail}
									<li>訂購人手機:&emsp;${sessionScope.userSession.memPhone}
									<li>訂購人地址:&emsp;${sessionScope.userSession.memAddr}
								</ul>
							</div>
							<div class="col-6" >
							<div class="line">收件人資訊</div>
								<ul>
									<li>收件人姓名:&emsp;${ordmVO.ordName}
									<li>收件人信箱:&emsp;${ordmVO.ordEmail}
									<li>收件人手機:&emsp;${ordmVO.ordPhone}
									<li>收件人地址:&emsp;${ordmVO.ordAddr}
								</ul>
							</div>
						</div>	
		
<!-- 			      		<table class="table table-2"> -->
<!-- 						  <thead> -->
<!-- 						    <tr> -->
<!-- 						      <th scope="col">#</th> -->
<!-- 						      <th scope="col">商品圖片</th> -->
<!-- 						      <th scope="col">商品名稱</th> -->
<!-- 						      <th scope="col">數量</th> -->
<!-- 						      <th scope="col">小計</th> -->
<!-- 						    </tr> -->
<!-- 						  </thead> -->
<!-- 						  <tbody> -->
<%-- 						  <c:set var="i" value="0" /> --%>
<%-- 			      		  <c:forEach var="orddVO" items="${orddSvc.all}">			      				      		 --%>
<%-- 			      		  <c:if test="${orddVO.ordNo == ordmVO.ordNo}"> --%>
<%-- 			      		  	<c:set var="i" value="${i+1}" /> --%>
<!-- 						    <tr> -->
<%-- 						      <th scope="row">${i}</th> --%>
<%-- 						      <td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${orddVO.proNo}"alt='沒有圖片' width="50" height="40"></td> --%>
<%-- 						      <td>${proSvc.getOneProduct(orddVO.proNo).proName}</td> --%>
<%-- 						      <td>${orddVO.ordDetAmt}</td> --%>
<%-- 						      <td>${orddVO.ordDetPrice}</td> --%>
<!-- 						    </tr> -->
<%-- 						   </c:if>						    --%>
<%-- 			      		   </c:forEach>			      		   --%>
<!-- 						  </tbody> -->
<!-- 						</table> -->
			      	
			    </div>
			  </div>
			</div>			
		</td>
	</tr>
	</c:if>
	</c:forEach>
	</table>
	
	</div>


<%@include file="/front-end/tempFile/footer"%>
<!-- Page Content END -->
<%-- <%@include file="/front-end/tempFile/footer" %> --%>
<%-- <%@include file="/front-end/tempFile/tempJs" %> --%>
</body>
<script>
$(document).ready(function(){
	$(".ordStatus").parent().each(function(){
		if($.trim($(this).find(".ordStatus").text())!="未出貨"){
			$(this).find(".cancel").attr("disabled", true);
		}
	});
});
$(".cancel").click(function(){
	var ordDate = new Date($(this).parent().parent().find(".ordDate").text());
	var today = new Date();
	var difference = new Date(today.getTime()-ordDate.getTime()).getDate();
	Swal.fire({
		  title: '確定取消訂單嗎?',
		  icon: 'warning',
		  showDenyButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '確定取消!',
	      denyButtonText: '不了,謝謝',
	      
		}).then((result) => {
		  if (result.isConfirmed) {
			 
			 if(difference<4){ 			   
			    Swal.fire(
			      '成功取消!',
			      '',
			      'success'
			    )
			    $.ajax({
					url:"<%=request.getContextPath()%>/ordermaster/ordermaster.do",
					type:"POST",
					data:{
						action:"cancel",
						ordNo:$(this).parent().parent().find(".ordNo").text(),					
						memNo:${sessionScope.userSession.memNo},
						ordStatus:"3",
						ordAmt:$(this).parent().parent().find(".ordAmt").text(),
						index:$(this).parent().parent().index()-1
					},
					datatype:"text",
					success:function(index){
						$(".ordStatus").eq(index).text("訂單取消");
						$(".cancel").eq(index).attr("disabled", true);
					}
				});
		   }else{
			   Swal.fire(
						'已訂購超過三天不能取消!',
					    '',
					    'error'
					   )
				  	 } 
	 
		  }
		});
});




</script>
</html>