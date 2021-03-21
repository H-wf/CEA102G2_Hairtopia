<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.member.model.*,com.ordermaster.model.*, java.util.*"%>

<jsp:useBean id="orddSvc" scope="page" class="com.orderdetail.model.OrderDetailService" />
<jsp:useBean id="proSvc" scope="page" class="com.product.model.ProductService" />
<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" />
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" />
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
	z-index:100;
}
.paper{
	border:0.1px solid #969592;
	box-shadow: 12px 12px 7px rgba(150, 149, 146, 0.6);
}
.line{
	border-bottom:solid #BDB58C;
	font-size:22px;
	color:#333333;
}
</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid px-0">
	<div class="row">
		<div class="col-2"></div>
		<div class="col-12 col-md-8 col-lg-8 paper my-5">
			<div class="line">訂單資訊</div>
			<div class="row">
				<div class="col-6">
					<ul>
						<li>訂單編號:&emsp;${ordermasterVO.ordNo}
						<li>訂單狀態:&emsp;
							<c:choose>
								<c:when test="${ordermasterVO.ordStatus == 0}">
								未出貨
								</c:when>
								<c:when test="${ordermasterVO.ordStatus == 1}">
								已出貨
								</c:when>
								<c:when test="${ordermasterVO.ordStatus == 2}">
								已結案
								</c:when>
								<c:when test="${ordermasterVO.ordStatus == 3}">
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
						<li>訂購日期:&emsp;<fmt:formatDate pattern="yyyy-MM-dd" value="${ordermasterVO.ordDate}" />
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
			      	<c:if test="${orddVO.ordNo == ordermasterVO.ordNo}">
			      	<c:set var="i" value="${i+1}" />
					<tr>
						<th scope="row">${i}</th>
						<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${orddVO.proNo}"alt='沒有圖片' width="50" height="40"></td>
						<td>${proSvc.getOneProduct(orddVO.proNo).proName}</td>
						<td>${ptypeSvc.getOnePtype(proSvc.getOneProduct(orddVO.proNo).ptypeNo).ptypeName}</td>
						<td>${brandSvc.getOneBrand(proSvc.getOneProduct(orddVO.proNo).braNo).braName}</td>
						<td>${proSvc.getOneProduct(orddVO.proNo).proPrice}</td>
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
						<td>NT$${ordermasterVO.ordAmt}</td>
					</tr>					      		  
				</tbody>
			</table>
				<div class="row">
					<div class="col-6">
					<div class="line">訂購人資訊</div>
						<ul>
							<li>訂購人姓名:&emsp;${sessionScope.memVO.memName}
							<li>訂購人信箱:&emsp;${sessionScope.memVO.memEmail}
							<li>訂購人手機:&emsp;${sessionScope.memVO.memPhone}
							<li>訂購人地址:&emsp;${sessionScope.memVO.memAddr}
						</ul>
					</div>
					<div class="col-6" >
					<div class="line">收件人資訊</div>
						<ul>
							<li>收件人姓名:&emsp;${ordermasterVO.ordName}
							<li>收件人信箱:&emsp;${ordermasterVO.ordEmail}
							<li>收件人手機:&emsp;${ordermasterVO.ordPhone}
							<li>收件人地址:&emsp;${ordermasterVO.ordAddr}
						</ul>
					</div>
				</div>	
		</div>
	</div>


</div>
<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>

</html>