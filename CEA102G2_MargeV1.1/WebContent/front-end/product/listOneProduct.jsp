<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.product.model.*"%>
<%@ page import="java.util.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>
<%
	ProductVO productVO = (ProductVO) request.getAttribute("productVO"); //ProductServlet.java(Concroller), 存入req的productVO物件
%>

<html>
<head>
<title>商品資料 - listOneProduct.jsp</title>
<meta charset="utf-8">
<%@include file="/front-end/tempFile/head" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/dist/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/dist/slick/slick-theme.css"/>
<style>
	.ftco-navbar-light{
		position:static;
	}
	.proPic{
		text-align:center;
		width:70%;
		display:block;
		margin:10px auto;
	}
	.protable{
		margin-top:10%;
		width:100%;
		font-size:120%;	
	}
	.protable th, .protable td{
		padding:1%;
	}
	.button{
	  margin: 0;
	  padding: 0;
	  background: none;
	  border: none;
	  border-radius: 0;
	  outline: none;
	  -webkit-appearance: none;
	  -moz-appearance: none;
	  appearance: none;
	}
	.slide-arrow{
	  position: absolute;
	  top: 50%;
	  margin-top: -15px;
	}
	.slick-prev:before, .slick-next:before{
		color:#BDB58C;
	}
	.slick-prev{
		left: 40px;
		z-index: 2;
		
	}
	.slick-next{
		right: 40px;
		
	}
	.slick-slide:focus{
		outline:0;
	}
</style>
</head>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">
	<div class="row">
		
		<div class="col-12 col-md-6 col-lg-6 parent">
			
			<div><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' class="proPic" /></div>
			
			<div><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proPic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' class="proPic"/></div>
			
		</div>
		<div class="col-12 col-md-6 col-lg-6">
		<table class="protable">
			<tr>
				<th>商品編號</th>
				<td>${productVO.proNo}</td>
			</tr>
			<tr>
				<th>商品類別編號</th>
				<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" />
				<td>${ptypeSvc.getOnePtype(productVO.ptypeNo).ptypeName}</td>
			</tr>
			<tr>
				<th>品牌編號</th>
				<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" />
				<td>${brandSvc.getOneBrand(productVO.braNo).braName}</td>
			</tr>
			<tr>
				<th>商品名稱</th>
				<td>${productVO.proName}</td>				
			</tr>
			<tr>
				<th>商品單價</th>
				<td>${productVO.proPrice}</td>
			</tr>
			<tr>
				<th>商品描述</th>
				<td>${productVO.proDesc}</td>
			</tr>
			</table>
		</div>
	</div>
</div>
<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>

<script type="text/javascript" src="<%=request.getContextPath()%>/dist/slick/slick.min.js"></script>
<script>
$('.parent').slick({
	  speed: 1000,
	  dots: true,
	  prevArrow: '<button type="button" class="slick-prev">Previous</button>',
	  nextArrow: '<button type="button" class="slick-next">Next</button>',
	  infinite: true,
	  speed: 500,
	  fade: true,
	  cssEase: 'linear'
	  
});
// $(document).ready(function(){
// 	$(".parent:focus").css("outline","0");
// })
</script>
</body>
</html>