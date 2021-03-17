<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.product.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
 	.right{
/* 		text-align:center; */
/* 		height:120vh; */
/* 		top:60vh; */
 		padding-left:20vh;
 	}
	.cart{
        right:15px;
        bottom:78.5%;
        position:fixed;
        z-index: 2;
    }
	@media (max-width: 992px){
		.cart{
			bottom:70%;
		}
		.right{
			padding-left:45px;
			padding-right:30px;
		}
	}
    .cart-btn {
        background: rgba(255, 255, 255, 0.3); 
        border-radius: 4em;			
        border: 0px;
        cursor: pointer;
    }

    .cart-btn:focus {
        outline: none;
    }

    .cart img {
        height: 2em;
    }
    .cart span{
		background:#D9BF77;
		color:black;
 		position:absolute; 
		width: 25px;
		height: 25px;
		border-radius:50%;
		display: flex;
		justify-content: center;
		align-items: center;
		right:-9px;
		top:10px;
	}
	.protable{
		margin-top:0;
		margin-bottom:15%;
		width:70%;
		font-size:100%;	
	}

	.protable td{
		padding:1%;
	}
	.protable th{
		width:40%;
	}

/* 	.slick-prev:before, .slick-next:before{ */
/* 		color:#BDB58C; */
/* 		margin: 0; */
/*   		padding: 0; */
/* 	} */
/*  	.slick-next{  */
/*  		z-index: 2;  */
/* 	} */

/* 	.wrap:focus{ */
/* 		outline:0; */
/* 	} */
/* 	.slick-slide:focus{ */
/* 		outline:0; */
/* 	} */

/* 	.left{	   */
/* 	    padding: 0; */
/* 	    height:70%; */
/* 	} */
/* 	.parent{ */
/*  	 	width: 100%; */
/*  		margin: 0 auto; */
/*   		position:relative; */
/* 	} */
/* 	.parent img{ */
/* 		position:absolute; */
/*  		max-width: 100%;  */
/*  		height:auto; */
/* 		top:50%; */
/* 		left:50%; */
/* 		transform:translate(-50%,-50%); */
/* 		object-fit:cover; */
/* 	} */
/* 	.button{ */
/* 	    margin: 0; */
/* 	  	padding: 0; */
/* 	 	background: none; */
/* 	  	border: none; */
/* 	  	border-radius: 0; */
/* 	  	outline: none; */
/* 	  	-webkit-appearance: none; */
/* 	  	-moz-appearance: none; */
/* 	  	appearance: none; */
/* 	} */
/* 	.slide-arrow{ */
/* 	  	position: absolute; */
/* 	  	top: 50%; */
/* 	  	margin-top: -15px; */
/* 	} */
/* 	.prev-arrow{ */
/* 	  	left: -40px; */
/* 	  	width: 0; */
/* 	  	height: 0; */
/* 	  	border-left: 0 solid transparent; */
/* 	  	border-right: 15px solid #113463; */
/* 	  	border-top: 10px solid transparent; */
/* 	  	border-bottom: 10px solid transparent; */
/* 	} */
/* 	.next-arrow{ */
/* 	  	right: -40px; */
/* 	  	width: 0; */
/* 	  	height: 0; */
/* 	  	border-right: 0 solid transparent; */
/* 	  	border-left: 15px solid #113463; */
/* 	  	border-top: 10px solid transparent; */
/* 	  	border-bottom: 10px solid transparent; */
/* 	} */
	.add{
		color:#D9BF77;
		background-color:white;
	}
 	.btn-secondary{
 		margin-top:5px; 
 		width:50%; 
		background-color:white;
		border-color:#D9BF77; 
		color:#D9BF77; 
 	} 
	.btn-secondary:hover{
		background-color:#D9BF77;
		color:white;
		border-color:#D9BF77; 
	}
	.btn-secondary:not(:disabled):not(.disabled):active, 
	.btn-secondary:not(:disabled):not(.disabled).active, 
	.show > .btn-secondary.dropdown-toggle{
		background-color:#D9BF77;
		color:white;
		border-color:#D9BF77; 
	}
	.quantity{
		width:30%;
		height:21px;
		vertical-align:center;
	}
	.btn-danger{
		padding:0px 5px;
		background-color:white;
		border-color:#D9BF77; 
		color:#D9BF77; 
	}
	.btn-danger:hover{
		background-color:#D9BF77;
		color:white;
		border-color:#D9BF77; 
	}
	.btn-danger:not(:disabled):not(.disabled):active{
		background-color:#D9BF77;
		color:white;
		border-color:#D9BF77;
	}
	.bag_div{
		width:20%;
		display:none;
	}
	.cart:hover .bag_div{
		background:rgba(189, 181, 140, 0.8);
		color:white;
	  	right:15px;
        position:fixed;
       	z-index: 2;
       	display:block;
	}
	.bag_div:hover{
		background:rgba(189, 181, 140, 0.8);
		color:white;
	  	right:15px;
        position:fixed;
       	z-index: 2;
       	display:block;
	}
	.picture{
		display:inline-block;
 		padding-top:3px;
		padding-left:2px; 
		margin:0;
		vertical-align:text-top;
	}
	.name{
		display:inline-block;
		font-size:5px;
 		padding:0;
		vertical-align:text-top;
	}
	.checkout{			
		vertical-align:text-top;
		text-align:center;
	}
	.checkout a{
		color:white;
	}
 	.minus{ 
 		color:#D9BF77;
 	}
 	.plus{
 		color:#D9BF77;
 	}
 	.carousel {
            position: relative;
        }

        .carousel-control-next,
        .carousel-control-prev {
            position: absolute;
            color: white;
            background-color: #BDB58C;
            width: 25px;
            height: 25px;
            border-radius: 50%;
            top: 50%;
            transform: translateY(-50%);
        }

        .carousel-control-next {
            right: -12%;
        }	
        .carousel-control-prev {
            left: -12%;
        }
 	@media (max-width: 768px){
 		.carousel-control-next {
             right:0%;
         }
         .carousel-control-prev { 
             left: 0%; 
         } 
 	} 
        .carousel-indicators {
            position: absolute;
            bottom: -20%;
        }

        .carousel-indicators .active {
            background-color: grey;
        }

        .carousel-indicators li {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: rgba(101, 101, 101, .5);
        }
		.carousel-inner{
			height:70vh;
		}
        .d-block {
        	height:70vh;
            object-fit: cover;
        }
	@media (max-width: 768px){
        .d-block {
        	padding-left:30px;
        	padding-right:30px;
        }
	}
</style>
</head>
<body>
<%@include file="/front-end/tempFile/navBar" %>
<!-- Begin Page Content -->
<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" />
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" />
<a href="<%=request.getContextPath()%>/front-end/product/EShop2.jsp">回商城</a>
<div class="container-fluid" style="margin-bottom:30px;">
	 <div class="cart">
        <button class="cart-btn">
            <img src="<%=request.getContextPath()%>/dist/images/cart.jpg">
            <c:if test="${not empty sessionScope.shoppingcart}">
            	<span class="sum">${sessionScope.sum}</span>
            </c:if>
        </button>
        <div class="bag_div">
            <c:forEach var="productVO" items="${sessionScope.shoppingcart}">
            	<div class="col-3 picture"><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' width="40" height="50"></div>
            	<div class="col-8 name">${productVO.proName}<br>Qty:<i>${productVO.quantity}</i></div>
            </c:forEach>
            <hr color="white" style="margin-bottom:0;">
            <div class="checkout"><a href="<%=request.getContextPath()%>/product/product.do?action=CHECKOUT">CHECKOUT</a></div>
    	</div>   
    </div>
	<div class="row">
		<div class="col-md-1 col-lg-1"></div>
		<div class="col-12 col-md-5 col-lg-5">
<!-- 			<div class="left"> -->
<!-- 			<div class="parent"> -->
<!-- 				<div class="images"> -->
<%-- 					<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' class="proPic" /> --%>
<!-- 				</div> -->
			
<!-- 				<div class="images"> -->
<%-- 					<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proPic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' class="proPic"/> --%>
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			</div> -->
			<div id="carouselExampleIndicators" class="carousel slide">
                <ol class="carousel-indicators">
                    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active dot"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="1" class="dot"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img class="d-block w-100" src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片'>
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proPic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片'>
                    </div>
                </div>
                <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z" />
                    </svg>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z" />
                    </svg>
                    <span class="sr-only">Next</span>
                </a>
            </div>
		</div>
		<div class="col-12 col-md-5 col-lg-5 right">
			<small class="text-muted">${ptypeSvc.getOnePtype(productVO.ptypeNo).ptypeName}&nbsp;${brandSvc.getOneBrand(productVO.braNo).braName}</small>
			<p class="h4">${productVO.proName}</p>
			<blockquote class="blockquote">
			  <p class="mb-0">NT$${productVO.proPrice}</p>
			  <footer class="blockquote-footer">商品描述<br><cite title="Source Title">${productVO.proDesc}</cite></footer>
			</blockquote>
			<div style="margin-bottom:16px;">
			<span class="align-baseline">數量</span>
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash minus" viewBox="0 0 16 16">
		  			<path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
				</svg>
				<input type="text" min="1" step="1" value="1" class="quantity" style="width:10%;">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus plus" viewBox="0 0 16 16">
		  			<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
				</svg>
			</div>
<!-- 			<table class="protable"  align="center"> -->
<!-- 			<tr> -->
<%-- 				<td>${ptypeSvc.getOnePtype(productVO.ptypeNo).ptypeName}&nbsp;${brandSvc.getOneBrand(productVO.braNo).braName}</td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td> -->
<%-- 				<h3>${productVO.proName}</h3> --%>
<!-- 				</td>				 -->
<!-- 			</tr>		 -->

<!-- 			<tr> -->
<!-- 				<td><h4>NT$${productVO.proPrice}</h4></td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<%-- 				<td><h5 style="text-decoration: underline;">商品描述</h5><h5>${productVO.proDesc}</h5></td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td> -->
<!-- 					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash minus" viewBox="0 0 16 16"> -->
<!-- 	  					<path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/> -->
<!-- 					</svg> -->
<!-- 			        <input type="text" min="1" step="1" value="1" class="quantity" style="width:10%;"> -->
<!-- 					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus plus" viewBox="0 0 16 16"> -->
<!-- 	  					<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/> -->
<!-- 					</svg> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td> -->
					<a href="##" class="btn btn-secondary btn-lg" role="button" aria-disabled="true">ADD TO　BAG</a>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			</table> -->
		</div>
		
	</div>
</div>
<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>

<script type="text/javascript" src="<%=request.getContextPath()%>/dist/slick/slick.min.js"></script>
<script>

//數量減少
$(".minus").click(function(){
	if($(".quantity").val()>1){
		$(".quantity").val(parseInt($(".quantity").val())-1);
	}	
});
//數量增加
$(".plus").click(function(){
	$(".quantity").val(parseInt($(".quantity").val())+1);
});
// 加入購物車
$(".btn-secondary").click(function(){	
	$.ajax({
		url:"<%=request.getContextPath()%>/product/product.do",
		type:"POST",
		data:{
			action:"ADD",
			proNo:${productVO.proNo},
			quantity:$(".quantity").val()
		},
		dataType : "json",
		success:function(data){
			$(".picture").remove();
			$(".name").remove();
			var sum=0;
			for (let i = 0; i < data.length; i++) {
				console.log(data);
				var str = ("<div class='col-3 picture'>"
						+"<img src="+"${pageContext.request.contextPath}"+"/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id="+data[i].proNo+" alt='沒有圖片' width='40' height='50'>"
						+"</div>"
						+"<div class='col-8 name'>"+data[i].proName+"<br>Qty:<i>"+data[i].quantity+"</i></div>");				
				sum+=data[i].quantity;
				$(".bag_div").prepend(str);
				
			}
			console.log(sum);
			$(".sum").remove();
			$(".cart-btn").append("<span class='sum'>"+sum+"</span>")
// 			$(".sum").empty();
// 			$(".sum").append(sum);
// 			$("span.sum").css({"background":"#D9BF77","color":"black","position":"absolute","width": "25px","height":"25px","border-radius":"50%","display":"flex","justify-content":"center","align-items":"center","right":"-9px","top":"10px"});
			$(".bag_div").css({"background":"rgba(189, 181, 140, 0.8)","color":"white","right":"15px","position":"fixed","z-index":"2","display":"block"});
			$(function () {
			    var timeout=setTimeout(function () {
			        $(".bag_div").hide();
			    }, 800);
			});
 			$(".cart").hover(function(){
 				$(".bag_div").css("display","block");
 			},function(){
 				$(".bag_div").css("display","none");
 			});	
		}
	});
	
});

</script>
</body>
</html>