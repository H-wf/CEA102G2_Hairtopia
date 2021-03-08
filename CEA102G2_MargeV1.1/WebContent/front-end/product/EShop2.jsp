<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Hairtopia EShop</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<style>
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
			background-color: grey;
		}
		.procontainer{
			width: 80%;
			margin-top: 10px;
		}		
		.products{
			padding:5px;
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
			background-color: #5B5B5B;
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
		.form-control:focus{
			border-color: #5B5B5B;
			box-shadow: 0 0 0 0.2rem rgb(92 92 92 / 25%) !important;
		}
		.btn-outline-success{
			color: #5B5B5B;
			border-color: #5B5B5B;
		}
		.btn-outline-success:hover{
			background-color: #5B5B5B;
			border-color: #5B5B5B;
		}
		.btn-outline-success.focus, .btn-outline-success:focus {
			box-shadow: 0 0 0 0 !important;
		}
		.btn-outline-success:not(:disabled):not(.disabled).active, .btn-outline-success:not(:disabled):not(.disabled):active, .show>.btn-outline-success.dropdown-toggle{
			    border-color: #5B5B5B;
			    background-color: #5B5B5B;
		}
    </style>
</head>
<body>
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
            <div class="dropdown-menu">
            	<c:forEach var="brandVO" items="${brandSvc.all}" >
	                <a class="dropdown-item" href="##" value="${brandVO.braNo}">${brandVO.braName}</a>
                </c:forEach> 
            </div>
        </div>
        <div class="btn-group">
            <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                	類別
            </button>
            <div class="dropdown-menu">
            	<c:forEach var="ptypeVO" items="${ptypeSvc.all}" >
	                <a class="dropdown-item" href="##" value="${ptypeVO.ptypeNo}">${ptypeVO.ptypeName}</a>
                </c:forEach>
            </div>
        </div>
        <div class="btn-group">
            <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
               	 金額
            </button>
            <div class="dropdown-menu">
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
            <div class="col-12">
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
	                <span class="mask">
                    	${ptypeSvc.getOnePtype(productVO.ptypeNo).ptypeName}<br>
                    	${brandSvc.getOneBrand(productVO.braNo).braName}<br>
                    	${productVO.proName}<br>
                    	$${productVO.proPrice}
                    	<input class="ptypeName" type="hidden" value="${ptypeSvc.getOnePtype(productVO.ptypeNo).ptypeName}" />
	            		<input class="braName" type="hidden" value="${brandSvc.getOneBrand(productVO.braNo).braName}" />
	            		<input class="proName" type="hidden" value="${productVO.proName}" />
	            		<input class="proPrice" type="hidden" value="${productVO.proPrice}" />
               		</span>
	                <p>${productVO.proName}</p>
	            </div>
            </c:forEach> 
        </div>
    </div>
    <!-- display products End-->
    <input class="PageContext" type="hidden" value="<%=request.getContextPath()%>" />
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script>
        $(document).on("click", ".label-primary a", function() {
            $(this).parent(".label-primary").remove();
        });
        $(document).on("click", ".btn-outline-success", function() {
            if ($(".form-control").val() !== "") {
                var text = "<lable class='label-primary'>" + $(".form-control").val() + "&nbsp;<a><img src='"+$(".PageContext").val()+"/dist/images/x.png'></a></lable>";
                console.log(text);
                $(".searchbar").before("\n" + text);
            }
            select();
        });
        $(document).on("click", ".dropdown-item", function() {
            var text = "<lable class='label-primary'>" + $(this).text() + "&nbsp;<a><img src='"+$(".PageContext").val()+"/dist/images/x.png'></a></lable>";
            $(".searchbar").before("\n" + text);
            select();
        });

    </script>
    <script>

    function select(){
    	var label = $(".label-primary:last").text()
    	console.log(label);
    	$(".mask:first").remove();
	    for(i=0;i<$(".ptypeName").length;i++){
	    	var ptypeName = $(".ptypeName").eq(i).val()
	    	console.log(ptypeName);
	    	if(true){
	    		console.log("hi");
	    		console.log("true");
	    		$(".mask").remove();
	 			i++;
	    	}
	    }
    }

    </script>
</body>
</html>