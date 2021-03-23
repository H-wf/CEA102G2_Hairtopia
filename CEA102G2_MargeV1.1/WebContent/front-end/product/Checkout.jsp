<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.product.model.*,com.member.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1">
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
<style>
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
.step2::after {
	position: absolute;
	content: "";
	top: -210px;
	left: 4.3em;
	z-index: -1; /* 讓線條置於圓圈後 */
	border-left: 1px solid #BDB58C;
	padding-left: 20px;
}
.step3::after {
	position: absolute;
	content: "";
	top: -595px;
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
	table th, table td{
		border-color:#D8CF9E !important;
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
			<div class="col-md-3 col-lg-3 " style="padding-top:12px;">
				<ul class="horizontalProgress">
					<li class="step1 step">Step1</li>
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
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:set var="total" value="0"/>
						<c:forEach var="productVO" items="${sessionScope.shoppingcart}"
							varStatus="i">
						<c:set var="total" value="${total+(productVO.proPrice)*(productVO.quantity)}"/>
							<tr class="content">
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
								<td><button type="button" class="btn btn-primary btn-sm delete">刪除</button></td>
								<input type="hidden" class="del" value="${i.index}">
								<input type="hidden" class="proNo" value="${productVO.proNo}">
							</tr>
						</c:forEach>
						<tr>
							<th scope="row"></th>
							<td colspan="5">TOTAL</td>
							<td style="text-align:right;">NT$</td>
							<td class="total">${total}</td>
							<td></td>
						</tr>
						<tr>
							<td scope="col" colspan="9">
								
								
								<input type="submit" class="btn btn-primary go2 section2" value="NEXT→" style="float: right;">
								
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<hr class="section2-1" style="border-top:none;">
	<div class="container-fluid">
		<div class="row" style="display:none;">
			<div class="col-md-3 col-lg-3" style="padding-top: 12px;">
				<ul class="horizontalProgress">
					<li class="step2 step">Step2</li>
				</ul>
			</div>
			<div class="col-12 col-md-8 col-lg-8" style="padding: 0;">
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
						<form class="order" action="<%=request.getContextPath()%>/ordermaster/ordermaster.do" method="POST">					
						<tr>
							<td width="120">姓名</td>
							<td><input type="text" class="name" name="ordName"></td>
						</tr>
						<tr>
							<td width="120">信箱</td>
							<td><input type="email" class="mail" name="ordEmail"></td>
						</tr>
						<tr>
							<td width="120">手機</td>
							<td><input type="tel" class="phone" name="ordPhone"></td>
						</tr>
						<tr>
							<td width="120">地址</td>
							<td><div id="twzipcode"></div>
								<input type="text" style="width: 412px;" class="address" name="ordAddr"></td>
						</tr>
						<input type="hidden" name="memNo" value="${sessionScope.memVO.memNo}">				 
						<input type="hidden" name="ordAmt" class="ordAmt" value="${sessionScope.ordAmt}">
						<input type="hidden" name="action" value="PAY">
						</form>
						<tr>
							<td scope="col" colspan="2" style="padding-right:0;">
								<input type="submit" class="btn btn-primary go3 section3" value="NEXT→" style="float: right;">								
							</td>
						</tr>
					</tbody>
					
				</table>
				
			</div>
		</div>
	</div>
	<hr class="section3-1" style="border-top:none;">
	<div class="container-fluid">
		<div class="row" style="display:none;">
			<div class="col-md-3 col-lg-3" style="padding-top: 12px;">
				<ul class="horizontalProgress">
					<li class="step3 step">Step3</li>
				</ul>
			</div>			
			<div class="col-12 col-md-8 col-lg-8 demo-container" style="padding: 0;">
			
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
				      <input required type="tel" class="form-control" id="inputEmail3" placeholder="Card number" name="number">
				    </div>
				  </div>
				  <div class="form-group row">
				    <label for="inputPassword3" class="col-sm-2 col-form-label">姓名</label>
				    <div class="col-sm-10 a">
				      <input required type="text" class="form-control" id="inputPassword3" placeholder="Full name" name="name">
				    </div>
				  </div>
				  <div class="form-group row">
				    <label for="inputPassword3" class="col-sm-2 col-form-label">到期日</label>
				    <div class="col-sm-10 a">
				      <input required type="tel" class="form-control" id="inputPassword3" placeholder="MM/YY" name="expiry">
				    </div>
				  </div>
				  <div class="form-group row">
				    <label for="inputPassword3" class="col-sm-2 col-form-label">CVC</label>
				    <div class="col-sm-10 a">
				      <input required type="number" class="form-control" id="inputPassword3" placeholder="CVC" name="cvc">
				    </div>
				  </div>
				</form>
			 </div>
			 <input type="submit" class="btn btn-primary alert" value="送出" style="float: right;">			 
			</div>
		</div>
	</div>
	<!-- Page Content END -->
<%-- 	<%@include file="/front-end/tempFile/footer"%> --%>
	<%@include file="/front-end/tempFile/tempJs"%>
<!-- 	<script -->
<!-- 		src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script> -->
	<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
	<script src="<%=request.getContextPath()%>/resource/card-master/dist/jquery.card.js"></script>
	
<script>	
//點-數量減少
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
//點+數量增加
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
//當數量改變,更改購物車數量、金額
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
				  $(".total").html(total);
				  $(".ordAmt").attr("value", total);
		}
	});
}
$(".delete").click(function(){
	var index = $(this).parent().parent("tr").find(".del").val()
	var subtotal = $(this).parent().parent("tr").find(".subtotal").text();
	$.ajax({
		url:"<%=request.getContextPath()%>/product/product.do",
		type : "POST",
		data : {
			action : "DELETE",
			del : index,
		},
		success : function(data){
			$(".content").eq(index).remove();
			$(".total").html(parseInt($(".total").text())-subtotal);
			if(parseInt(data)==0){
				window.location = "<%=request.getContextPath()%>/front-end/product/EShop2.jsp";
			}
		}
	});
});
//帶入3+2郵遞區號
$(document).ready(function() {	 
	$("#twzipcode").twzipcode({
	    onDistrictSelect: function() {
			var country = $("select[name='county']").val();  // 取縣市的值
			var district = $("select[name='district']").val();  // 取鄉鎮市區的值
			var zipcode = $("input[name='zipcode']").val();  // 取郵遞區號的值
			$(".address").val(zipcode+country+district);
		}
	});
	$("select").attr("class", "custom-select mr-2 custom-select-sm");
	$("select").attr("style", "width:100px;height:28px");
});
//step1到step2的線
$(document).ready(function() {
	var h = $("table:first-child").height()+10 
	$("head").append("<style>.step2::after{ height:" + h + "}</style>");
});
//step2到step3的線
$(document).ready(function() {
	var h = $("table:first-child").height()+410
	$("head").append("<style>.step3::after{ height:" + h + "}</style>");
});
//點選next出現且滑動到下一個part
$(".go2").click(function(){
	$(".section2-1+div div:first-of-type").show();
	$("html,body").animate({scrollTop:$(".section2").offset().top},800);
});
$(".go3").click(function(){
	$(".section3-1+div div:first-of-type").show();
	$("html,body").animate({scrollTop:$(".section3").offset().top},800);
});
//點選同上將訂購人資料帶入收件人資料
$(".form-check-input").click(function() {
	$(".name").val("${sessionScope.memVO.memName}");
	$(".mail").val("${sessionScope.memVO.memEmail}");
	$(".phone").val("${sessionScope.memVO.memPhone}");
	$(".address").val("${sessionScope.memVO.memAddr}");
});


//信用卡
$('#form11').card({ 			
	container : '.card-wrapper',
});
//按送出後alert付款,按確認後,3秒後送出表單	ordermaster的servlet,action=PAY		
$(".alert").click(function(){
	//姓名信箱手機地址沒填則不能送出表單,且顯示警告字串在未填的欄位後
	if($(".name").val().trim()==""||$(".mail").val().trim()==""||$(".phone").val().trim()==""||$(".address").val().trim()==""){
		$(".name").next().remove();
		$(".mail").next().remove();
		$(".phone").next().remove();
		$(".address").next().remove();
		if($(".name").val().trim()==""){			
			$(".name").after("<span style='color:red'> *姓名不得為空</span>");
		}
		if($(".mail").val().trim()==""){			
			$(".mail").after("<span style='color:red'> *信箱不得為空</span>");
		}
		if($(".phone").val().trim()==""){			
			$(".phone").after("<span style='color:red'> *手機不得為空</span>");
		}
		if($(".address").val().trim()==""){			
			$(".address").after("<span style='color:red'> *地址不得為空</span>");
		}
	}else if($(".form-control").val().trim()==""){
		$("input[name='number']").next().remove();
		$("input[name='name']").next().remove();
		$("input[name='expiry']").next().remove();
		$("input[name='cvc']").next().remove();
		if($("input[name='number']").val().trim()==""){
			$("input[name='number']").after("<span style='color:red'> *請填寫</span>");
		}
		if($("input[name='name']").val().trim()==""){
			$("input[name='name']").after("<span style='color:red'> *請填寫</span>");
		}
		if($("input[name='expiry']").val().trim()==""){
			$("input[name='expiry']").after("<span style='color:red'> *請填寫</span>");
		}
		if($("input[name='cvc']").val().trim()==""){
			$("input[name='cvc']").after("<span style='color:red'> *請填寫</span>");
		}
	}else{
		Swal.fire({
			title: '確定付款?',
			showDenyButton: true,
			confirmButtonText: '確認',
			denyButtonText: '請讓我三思',
		}).then((result) => {
			if (result.isConfirmed) {
				Swal.fire('Saved!', '', 'success');
				setTimeout(function(){ $(".order").submit();}, 2000);
			}			  
		})
	}	
});	
</script>
</body>
</html>