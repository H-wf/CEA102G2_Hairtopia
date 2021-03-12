<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
 		.clean{
 			clear:float;
 		}
		.cart {
			
            margin-right: 0;
            text-align: right;
        }

        .cart-btn {
            background-color: #FFFFFF;
            border: 0px;
            cursor: pointer;
        }

        .cart-btn:focus {
            outline: none;
        }

        .cart img {
            height: 2em;
        }

        .carousel-inner { 
            height: 80vh;
        }

        .carousel-inner .carousel-item img {
        	height: 80vh;
        	object-fit: cover;
        }
        .btn-danger.focus, .btn-danger:focus{
			box-shadow: 0 0 0 0 !important;
		}
		.btn-danger:not(:disabled):not(.disabled).active, .btn-danger:not(:disabled):not(.disabled):active, .show>.btn-danger.dropdown-toggle{
 			color: grey;
			background-color: #FFFFFF;
			border-color: #FFFFFF;
		}
        .dropcontainer{
        	text-align: center;
        }
        .btn-group{
        	display: inline-block;
        	
        }     
      	.btn-danger{
     		color: grey;
        	background-color: #FFFFFF;
        	border-color: #FFFFFF;
        	padding-bottom: 0;
        	position: relative;       	
      	}

      	.dropdown-menu{
      		margin: 0 auto;
      	}
        .btn-danger:hover{
        	cursor: default !important;
 			color: grey;
			background-color: #FFFFFF;
			border-color: #FFFFFF;
			text-decoration:underline;
		}
		.btn-danger:focus + div.dropdown-menu{
			display: none;
		}
		.btn-danger:hover + div.dropdown-menu{
			display: block;
		}		
		div.dropdown-menu:hover{
			display: block;
		}
		.dropdown-item:focus{
/*  		background-color: grey; */
			background-color:#BDB58C;
		}
		.procontainer{
			width: 80%;
			margin-top: 10px;
		}		
		.products{
			padding:5px;
 			height:250px; /*???*/ 
			padding-bottom: 50px;
  			position: relative;
		}
		.mask {
		    position: absolute;
		    top: 5px;
		    left: 5px;
		    width:calc(100% - 10px);
		    height:calc(100% - 55px);
  			border-radius: .35rem; 
		    background: rgba(101, 101, 101, 0.6);
		    color: #FFFFFF;
		    opacity: 0;		   
		    display: flex;
  			justify-content: center;
  			align-items: center; 
		}
		.mask span{
 			display: block; 
		}
		.products:hover .mask{
			opacity: 1;
			
		}
		.products:hover{
			cursor: pointer;
		}

		.products img{
			width: 100%;
			height: 100%;
			object-fit: cover;
			border-radius: .35rem;
		}
		.products p{
			text-align: center;
		}
		.searchcontainer{
			width: 80%;
		}
		.label-primary{
			margin: 0px 0px 4px 0.1px;
			display: inline-block;
/*  		background-color: #5B5B5B; */
			background-color:#BDB58C;
			color: #fff;
			border-radius: .25em;
			padding: 4px 6px 2px 4px;
			font-size: 75%;
			position: relative;
			
		}
		.label-primary a{
			cursor: pointer;
		}
		.label-primary a img{
			position: relative;
    		top: -2px;
    		height: 6px;
		}
		.searchcontainer{
			margin-top: 15px;
			margin-bottom: 15px;
		}
		.searchbar{
			display: inline-block;
			float: right;
		}
		.form-control{
			height:36px !important;
			font-size:16px;
		}
		.form-control:focus{
			border-color: #D8CF9E;
			box-shadow: 0 0 0 0.1rem rgb(216 207 157 / 25%) !important;
		}
		.btn-outline-success{
			color: #D8CF9E;
			border-color: #D8CF9E;
		}
		.btn-outline-success:hover{
			background-color:#D8CF9E;
			border-color: #D8CF9E;
		}
		.btn-outline-success.focus, .btn-outline-success:focus {
			box-shadow: 0 0 0 0 !important;
		}
		.btn-outline-success:not(:disabled):not(.disabled).active, .btn-outline-success:not(:disabled):not(.disabled):active, .show>.btn-outline-success.dropdown-toggle{
			border-color: #D8CF9E;
			background-color:#D8CF9E;
		}
    </style>
</head>
<body>
<%@include file="/front-end/tempFile/navBar" %>
<div class="clean"></div>
<div class="container-fluid">
	<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService"/>
	<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService"/>
	<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService"/>
	<!-- cart -->
    <div class="cart">
        <button class="cart-btn">
            <img src="<%=request.getContextPath()%>/dist/images/cart.png">
        </button>
    </div>
    <!-- cart End-->
    <!-- carousel -->
    <div id="carouselPics" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#carouselPics" data-slide-to="0" class="active"></li>
            <li data-target="#carouselPics" data-slide-to="1"></li>
            <li data-target="#carouselPics" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img class="d-block w-100" src="https://picsum.photos/1200/800?random=1">
            </div>
            <div class="carousel-item">
                <img class="d-block w-100 " src="https://picsum.photos/1200/800?random=2">
            </div>
            <div class="carousel-item">
                <img class="d-block w-100 " src="https://picsum.photos/1200/800?random=3">
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselPics" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only"></span>
        </a>
        <a class="carousel-control-next" href="#carouselPics" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only"></span>
        </a>
    </div>
    <!-- carousel End -->
    <!-- dropdown -->
    <div class="container dropcontainer">
        <div class="btn-group">
            <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                	品牌
            </button>
            <div class="dropdown-menu brand">
            	<c:forEach var="brandVO" items="${brandSvc.all}" >
	                <a class="dropdown-item" href="##" value="${brandVO.braNo}">${brandVO.braName}</a>
                </c:forEach> 
            </div>
        </div>
        <div class="btn-group">
            <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                	類別
            </button>
            <div class="dropdown-menu ptype">
            	<c:forEach var="ptypeVO" items="${ptypeSvc.all}" >
	                <a class="dropdown-item" href="##" value="${ptypeVO.ptypeNo}">${ptypeVO.ptypeName}</a>
                </c:forEach>
            </div>
        </div>
        <div class="btn-group">
            <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
               	 金額
            </button>
            <div class="dropdown-menu price">
                <a class="dropdown-item" href="##">100</a>
                <a class="dropdown-item" href="##">100~500</a>
                <a class="dropdown-item" href="##">500以上</a>
            </div>
        </div>
    </div>
    <!-- dropdown End-->
    <!-- searchBar -->
    <div class="container searchcontainer">
        <div class="row">
            <div class="col-12 limit">
                篩選條件:&nbsp;
                <div class="searchbar">
                    <span class="form-inline">
                        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                    </span>
                </div>
            </div>
        </div>
    </div>
    <!-- searchBar End -->
    <!-- display products-->
    <div class="container procontainer">
        <div class="row">
        	<c:forEach var="productVO" items="${productSvc.all}"> 
	            <div class="col-12 col-sm-6 col-md-3 products">
	                <img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${productVO.proNo}">
	                <a href="<%=request.getContextPath()%>/product/product.do?action=getOne_For_Display&from=front-end&proNo=${productVO.proNo}">
	                <span class="mask">
                    	${ptypeSvc.getOnePtype(productVO.ptypeNo).ptypeName}<br>
                    	${brandSvc.getOneBrand(productVO.braNo).braName}<br>
                    	${productVO.proName}<br>
                    	$${productVO.proPrice}
                    	<input class="proNo" type="hidden" value="${productVO.proNo}" />
                    	<input class="ptypeName" type="hidden" value="${ptypeSvc.getOnePtype(productVO.ptypeNo).ptypeName}" />
	            		<input class="braName" type="hidden" value="${brandSvc.getOneBrand(productVO.braNo).braName}" />
	            		<input class="proName" type="hidden" value="${productVO.proName}" />
	            		<input class="proPrice" type="hidden" value="${productVO.proPrice}" />
               		</span>
               		</a>
	                <p>${productVO.proName}</p>
	            </div>
            </c:forEach> 
        </div>
    </div>
    <!-- display products End-->
   
</div>
    <input class="PageContext" type="hidden" value="<%=request.getContextPath()%>" />
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
	<script>

		var myKey = [];
		var myValue = [];
        $(document).on("click", ".label-primary a",  function(){
        	var index = $(this).parent(".label-primary").index();
        	myKey.splice(index,1);
        	myValue.splice(index,1);
        	filter();
            $(this).parent(".label-primary").remove();
            
        });
        
       
        $(document).on("click", ".btn-outline-success", function() {
            if ($(".form-control").val() !== "") {
                var text = "<lable class='label-primary search'>" + $(".form-control").val() + "&nbsp;<a><img src='"+$(".PageContext").val()+"/dist/images/x.png'></a></lable>";
                $(".searchbar").before("\n" + text);
                myKey.push("search");
                myValue.push($(".form-control").val());
                filter();
            }
       		
        });
        $(".brand").on("click", ".dropdown-item", function() {
            var text = "<lable class='label-primary'>" + $(this).text() + "&nbsp;<a><img src='"+$(".PageContext").val()+"/dist/images/x.png'></a></lable>";
            var str = $(this).text();
			var i = myKey.indexOf("brand")
			if(i==-1){
				myKey.push("brand");
             	myValue.push(str);
                $(".searchbar").before("\n" + text);
			}else{		
				myKey.splice(i,1,"brand");
        		myValue.splice(i,1,str);      		
        		$(".label-primary").eq(i).html($(this).text() + "&nbsp;<a><img src='"+$(".PageContext").val()+"/dist/images/x.png'></a>");        		
			}
          	filter();
				
        }); 
        $(".ptype").on("click", ".dropdown-item", function() {
        	var text = "<lable class='label-primary'>" + $(this).text() + "&nbsp;<a><img src='"+$(".PageContext").val()+"/dist/images/x.png'></a></lable>";
            var str = $(this).text();
			var i = myKey.indexOf("ptype")
			if(i==-1){
				myKey.push("ptype");
             	myValue.push(str);
                $(".searchbar").before("\n" + text);
			}else{		
				myKey.splice(i,1,"ptype");
        		myValue.splice(i,1,str);      		
        		$(".label-primary").eq(i).html($(this).text() + "&nbsp;<a><img src='"+$(".PageContext").val()+"/dist/images/x.png'></a>");        		
			}
           	filter();
           		
        });
        $(".price").on("click", ".dropdown-item", function() {
            var text = "<lable class='label-primary fromprice'>" + $(this).text() + "&nbsp;<a><img src='"+$(".PageContext").val()+"/dist/images/x.png'></a></lable>";
            $(".searchbar").before("\n" + text);
            
        });
        

        function filter(){
        	if(myKey.length==0){
        		$(".products").each(function(){        			
       				$(this).css("display","inline-block");       				
       			});       				
        	}
        	for(let i=0;i<myKey.length;i++){

	        	if(myKey[i]=="brand"){
	        		$(".products").each(function(){
	        			if($(this).find(".braName").val()!=myValue[i]){
	       					$(this).css("display","none");
	       				}else{
	       					$(this).css("display","inline-block");
	       				}
	       			});       				
	        	}        		
	        	if(myKey[i]=="ptype"){
	       			$(".products").each(function(){
	       				if($(this).find(".ptypeName").val()!=myValue[i]){
	       					$(this).css("display","none");
	       				}else{
	       					$(this).css("display","inline-block");
	       				}
	       			});       				
	       		}
	        	if(myKey[i]=="search"){
	        		console.log(myValue[i]);
	       			$(".products").each(function(){
	       				var ptypName =$(this).find(".ptypeName").val();
	       				var braName =$(this).find(".braName").val();
	       				var proName =$(this).find(".proName").val();
	       				var proPrice = $(this).find(".proPrice").val();        			
	       				if(myValue[i]!=ptypName&&braName&&proName&&proPrice){
	       					$(this).css("display","none");
	       				}else{
	       					$(this).css("display","inline-block");
	       				}
        			});       				
	        	}
        	}
       	
       }
        
    </script>
    <script>
    	
   		
   		

    </script>
</body>
</html>