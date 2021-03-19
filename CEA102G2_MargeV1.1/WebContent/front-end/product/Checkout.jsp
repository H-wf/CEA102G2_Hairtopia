<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.product.model.*,com.member.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Checkout.jsp</title>
<%@include file="/front-end/tempFile/head"%>
</head>
<style>
.ftco-navbar-light {
	position: static;
}

.minus {
	color: #D9BF77;
}

.plus {
	color: #D9BF77;
}

.quantity {
	width: 25px;
	font-size: 5px;
}

.quantitycontainer {
	width: 12%;
}

.table-striped {
	font-size: 16px;
}

.table-striped th, .table-striped td {
	padding-left: 0;
	padding-right: 0;
}

input {
	background-color: #F8F7F1;
	border-radius: 0.25rem;
	border: solid 0.5px #969592;
}
</style>
<style type="text/css">
@media ( max-width : 768px) {
	.stepword {
		display: none;
	}
	.step {
		display: none
	}
}

/* 列表項目處理 */
.horizontalProgress {
	padding-left: 50px !important;
}

.horizontalProgress li {
	list-style-type: none; /* 移除項目預設樣式 */
}
/* 圓點處理 */
.horizontalProgress li::before {
	display: inline-block; /* 水平區塊 */
	width: 1.5em; /* 區塊大小 */
	height: 1.5em; /* 區塊大小 */
	background-color: rgb(216, 207, 158); /* 區塊顏色 */
	border-radius: 50%; /* 區塊圓角 */
	content: "1";
	color: white;
	font-size: 1em;
	line-height: 1.5em; /* 上下置中 */
	text-align: center; /* 水平置中 */
	margin: 0px 10px 25px 0px;
}

.step1::before {
	content: "1" !important;
}

.step2::before {
	content: "2" !important;
}

.step3::before {
	content: "3" !important;
}
/* 線條處理 */
.step1::after {
	position: absolute;
	content: "";
	top: 105px;
	left: 4.3em;
	z-index: -1; /* 讓線條置於圓圈後 */
	border-left: 1px solid #BDB58C;
	padding-left: 20px;
}
</style>
<style>
	.form-control{
		background-color: #F8F7F1;
		border-radius: 0.25rem;
		border: solid 0.5px #969592;
		height:30px !important;
	}
	.a{
		padding-top:7px;
	}
	#form11{
		font-size:16px;
	}
	.demo-container{
		margin-bottom:15px;
	}
</style>

<body>
	<%@include file="/front-end/tempFile/navBar"%>
	<!-- Begin Page Content -->
	<jsp:useBean id="productSvc" scope="page"
		class="com.product.model.ProductService" />
	<jsp:useBean id="ptypeSvc" scope="page"
		class="com.ptype.model.PtypeService" />
	<jsp:useBean id="brandSvc" scope="page"
		class="com.brand.model.BrandService" />

	<div class="container-fluid" style="margin-top: 30px;">
		<div class="row">
			<div class="col-md-3 col-lg-3 " style="padding-top: 50px;">
				<div style="transform: translateX(16%);" class="stepword">Step</div>
				<ul class="horizontalProgress">
					<li class="step1 step"></li>
				</ul>
			</div>
			<div class="col-12 col-md-8 col-lg-8" style="padding: 0;">
				<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">商品類別</th>
							<th scope="col">品牌名稱</th>
							<th scope="col">商品名稱</th>
							<th scope="col">價格</th>
							<th scope="col">商品圖</th>
							<th scope="col">數量</th>
							<th scope="col">小計</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="productVO" items="${sessionScope.shoppingcart}"
							varStatus="i">
							<tr>
								<th scope="row" style="padding-left: 10px; padding-right: 10px;">${i.index+1}</th>
								<td>${ptypeSvc.getOnePtype(productVO.ptypeNo).ptypeName}</td>
								<td>${brandSvc.getOneBrand(productVO.braNo).braName}</td>
								<td>${productVO.proName}</td>
								<td>${productVO.proPrice}</td>
								<td><img
									src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${productVO.proNo}"
									alt='沒有圖片' width="50" height="40"></td>
								<td class="quantitycontainer"><svg
										xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-dash minus"
										viewBox="0 0 16 16">
	  				  <path
											d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z" />
				  </svg> <input type="text" min="1" step="1" value="${productVO.quantity}"
									class="quantity" preValue="${productVO.quantity}"> <svg
										xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-plus plus"
										viewBox="0 0 16 16">
	  				  <path
											d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z" />
				  </svg></td>
								<td class="subtotal">${(productVO.proPrice)*(productVO.quantity)}</td>
								<input type="hidden" class="proNo" value="${productVO.proNo}">
							</tr>
						</c:forEach>
						<tr>
							<th scope="row"></th>
							<td colspan="6">TOTAL</td>
							<td class="total">NT$${sessionScope.ordAmt}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3 col-lg-3" style="padding-top: 50px;">
				<ul class="horizontalProgress">
					<li class="step2 step"></li>
				</ul>
			</div>
			<div class="col-12 col-md-8 col-lg-8" style="padding: 0;">
				<hr>
				<table class="table">
					<thead>
						<tr>
							<th scope="col" colspan="2">訂購人資料</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="120">姓名</td>
							<td>${sessionScope.memVO.memName}</td>
						</tr>
						<tr>
							<td width="120">信箱</td>
							<td>${sessionScope.memVO.memEmail}</td>
						</tr>
						<tr>
							<td width="120">手機</td>
							<td>${sessionScope.memVO.memPhone}</td>
						</tr>
						<tr>
							<td width="120">地址</td>
							<td>${sessionScope.memVO.memAddr}</td>
						</tr>
					</tbody>
				</table>
				<hr>
				<table class="table">
					<thead>
						<tr>
							<th scope="col" width="120">收件人</th>
							<th><input class="form-check-input" type="checkbox" value=""
								id="defaultCheck1" style="margin-left: 0;">&emsp;同上</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="120">姓名</td>
							<td><input type="text" class="name"></td>
						</tr>
						<tr>
							<td width="120">信箱</td>
							<td><input type="text" class="mail"></td>
						</tr>
						<tr>
							<td width="120">手機</td>
							<td><input type="text" class="phone"></td>
						</tr>
						<tr>
							<td width="120">地址</td>
							<td><div id="twzipcode"></div>
								<input type="text" style="width: 412px;" class="address"></td>
						</tr>
					</tbody>
				</table>
				
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3 col-lg-3" style="padding-top: 50px;">
				<ul class="horizontalProgress">
					<li class="step3 step"></li>
				</ul>
			</div>			
			<div class="col-12 col-md-8 col-lg-8 demo-container" style="padding: 0;">
			<hr>
				<table class="table">
				<thead>
					<tr>
						<th scope="col" colspan="2">填寫付款資訊</th>
					</tr>
				</thead>
				</table>
				<div class="card-wrapper"></div>
				<div class="form-container active">
				<form  id="form11" action="">
				  <div class="form-group row">
				    <label for="inputEmail3" class="col-sm-2 col-form-label">卡號</label>
				    <div class="col-sm-10 a">
				      <input type="tel" class="form-control" id="inputEmail3" placeholder="Card number" name="number">
				    </div>
				  </div>
				  <div class="form-group row">
				    <label for="inputPassword3" class="col-sm-2 col-form-label">姓名</label>
				    <div class="col-sm-10 a">
				      <input type="text" class="form-control" id="inputPassword3" placeholder="Full name" name="name">
				    </div>
				  </div>
				  <div class="form-group row">
				    <label for="inputPassword3" class="col-sm-2 col-form-label">到期日</label>
				    <div class="col-sm-10 a">
				      <input type="tel" class="form-control" id="inputPassword3" placeholder="MM/YY" name="expiry">
				    </div>
				  </div>
				  <div class="form-group row">
				    <label for="inputPassword3" class="col-sm-2 col-form-label">CVC</label>
				    <div class="col-sm-10 a">
				      <input type="number" class="form-control" id="inputPassword3" placeholder="CVC" name="cvc">
				    </div>
				  </div>
				</form>
			 </div>
<%-- 			 <form action="<%=request.getContextPath()%>/ordermaster/ordermaster.do" method="POST"> --%>
<!-- 					<input type="hidden" name="memNo" -->
<%-- 						value="${sessionScope.memVO.memNo}"> <input type="hidden" --%>
<%-- 						name="ordAmt" class="ordAmt" value="${sessionScope.ordAmt}"> --%>
<!-- 					<input type="hidden" name="action" value="PAY"> <input -->
<!-- 						type="submit" class="btn btn-primary" value="送出" -->
<!-- 						style="float: right;"> -->
<!-- 				</form> -->
				
			</div>
			
		</div>
	</div>

	<!-- Page Content END -->
	<%@include file="/front-end/tempFile/footer"%>
	<%@include file="/front-end/tempFile/tempJs"%>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
	<script src="<%=request.getContextPath()%>/resource/card-master/dist/jquery.card.js"></script>
	<script>
	
//數量減少
$(".minus").click(function(){
	var proNo = $(this).parent().parent("tr").find(".proNo").val();
	var beforequantity = $(this).next(".quantity").val();
	var afterquantity;
	if(beforequantity>1){
		afterquantity = parseInt($(this).next(".quantity").val())-1;
		$(this).next(".quantity").val(afterquantity);
		change(proNo,beforequantity,afterquantity);
		$(this).next(".quantity").attr("preValue",afterquantity);
	}	
});
//數量增加
$(".plus").click(function(){
	var proNo = $(this).parent().parent("tr").find(".proNo").val();
	var beforequantity = $(this).prev().val();
	var afterquantity= parseInt($(this).prev().val())+1;
	change(proNo,beforequantity,afterquantity);
	$(this).prev().val(afterquantity);
	$(this).prev().attr("preValue",afterquantity);
});
//用keyin的輸入數量
$(".quantity").blur(function(){
	if($(this).val()>0){
		var proNo = $(this).parent().parent("tr").find(".proNo").val();
		var beforequantity = $(this).attr("preValue");
		var afterquantity = $(this).val();
		change(proNo,beforequantity,afterquantity);
		$(this).attr("preValue",afterquantity);
	}	
});
function change(proNo,beforequantity,afterquantity){
	$.ajax({
		url:"<%=request.getContextPath()%>/product/product.do",
				type : "POST",
				data : {
					action : "ADD",
					proNo : proNo,
					quantity : afterquantity - beforequantity
				},
				dataType : "json",
				success : function(data) {
					var total = 0;
					for (let i = 0; i < data.length; i++) {
						$(".subtotal").eq(i).html(
								data[i].proPrice * data[i].quantity);
						total += data[i].proPrice * data[i].quantity;
					}
					$(".total").html("NT$" + total);
					$(".ordAmt").attr("value", total);
				}
			});

		}
	</script>
	<script>
		//帶入3+2郵遞區號
		$(document).ready(function() {
			$("#twzipcode").twzipcode();
			$("select").attr("class", "custom-select mr-2 custom-select-sm");
			$("select").attr("style", "width:100px;height:28px");
		});
		//進度條的線
		$(document).ready(
				function() {
					var h = $("table:first-child").height()
							+ $("table:nth-child(2)").height() + 350
					$("head").append(
							"<style>.step1::after{ height:" + h + "}</style>");
				});
		$(".form-check-input").click(function() {
			$(".name").val("${sessionScope.memVO.memName}");
			$(".mail").val("${sessionScope.memVO.memEmail}");
			$(".phone").val("${sessionScope.memVO.memPhone}");
			$(".address").val("${sessionScope.memVO.memAddr}");
		});
	</script>
	
	<script>
		$('#form11').card({
			// a selector or DOM element for the container
			// where you want the card to appear
			container : '.card-wrapper', // *required*

		// all of the other options from above
		});
	</script>
</body>
</html>