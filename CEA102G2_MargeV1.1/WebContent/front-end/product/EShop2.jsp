<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <title>Hairtopia</title>
 <meta charset="utf-8">
<%@include file="/front-end/tempFile/head" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/product/EShop2.css"> 
</head>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<div class="container-fluid" style="padding-left:0;padding-right:0;">
	<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService"/>
	<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService"/>
	<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService"/>
	<!-- cart -->
    <div class="cart">
        <button class="cart-btn">
        	<svg style="color:#D8CF9E;" xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-bag" viewBox="0 0 16 16">
        		<path d="M8 1a2.5 2.5 0 0 1 2.5 2.5V4h-5v-.5A2.5 2.5 0 0 1 8 1zm3.5 3v-.5a3.5 3.5 0 1 0-7 0V4H1v10a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V4h-3.5zM2 5h12v9a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V5z" />
    		</svg>
<%--             <img src="<%=request.getContextPath()%>/dist/images/cart.jpg"> --%>
            <c:if test="${not empty sessionScope.shoppingbag}">
            	<span class="sum">${sessionScope.sum}</span>
            </c:if>            
        </button>
        <div class="bag_div">
            <c:forEach var="productVO" items="${sessionScope.shoppingbag}">           	
            	<div class="col-3 picture"><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${productVO.proNo}" alt='沒有圖片' width="40" height="50"></div>
            	<div class="col-8 name">${productVO.proName}<br>Qty:<i>${productVO.quantity}</i></div>            	
            </c:forEach>
            <hr color="white" style="margin-bottom:0;">
            <div class="checkout"><a href="<%=request.getContextPath()%>/product/product.do?action=CHECKOUT">CHECKOUT</a></div>
    	</div>        
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
                <img class="d-block w-100" src="<%=request.getContextPath()%>/dist/images/shop1.jpg">
            </div>
            <div class="carousel-item">
                <img class="d-block w-100 " src="<%=request.getContextPath()%>/dist/images/shop4.jpg">
            </div>
            <div class="carousel-item">
                <img class="d-block w-100 " src="<%=request.getContextPath()%>/dist/images/shop3.jpg">
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
                <a class="dropdown-item" href="##">100以下</a>
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
        		<c:if test="${productVO.proStatus==true}"> 
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
	            </c:if>
            </c:forEach> 
        </div>
    </div>
    <!-- display products End-->
   
</div>
    <input class="PageContext" type="hidden" value="<%=request.getContextPath()%>" />
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
	<script>
		$(document).ready(function(){
			if(${empty sessionScope.shoppingbag}){
				$(".checkout a").attr("href","##");
			}
		})
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
			var i = myKey.indexOf("brand")
			if(i==-1){
				myKey.push("brand");
				myValue.push($(this).text());
                $(".searchbar").before("\n" + text);
			}else{		
				myKey.splice(i,1,"brand");
				myValue.splice(i,1,$(this).text());
        		$(".label-primary").eq(i).html($(this).text() + "&nbsp;<a><img src='"+$(".PageContext").val()+"/dist/images/x.png'></a>");        		
			}
          	filter();
        }); 
        $(".ptype").on("click", ".dropdown-item", function() {
        	var text = "<lable class='label-primary'>" + $(this).text() + "&nbsp;<a><img src='"+$(".PageContext").val()+"/dist/images/x.png'></a></lable>";
			var i = myKey.indexOf("ptype")
			if(i==-1){
				myKey.push("ptype");
				myValue.push($(this).text());
                $(".searchbar").before("\n" + text);
			}else{		
				myKey.splice(i,1,"ptype");  
				myValue.splice(i,1,$(this).text())
        		$(".label-primary").eq(i).html($(this).text() + "&nbsp;<a><img src='"+$(".PageContext").val()+"/dist/images/x.png'></a>");        		
			}
           	filter();
        });
        $(".price").on("click", ".dropdown-item", function() {
            var text = "<lable class='label-primary'>" + $(this).text() + "&nbsp;<a><img src='"+$(".PageContext").val()+"/dist/images/x.png'></a></lable>";
            var i = myKey.indexOf("price")
			if(i==-1){
				myKey.push("price");
				myValue.push($(this).text());
                $(".searchbar").before("\n" + text);
			}else{		
				myKey.splice(i,1,"price");  
				myValue.splice(i,1,$(this).text())
        		$(".label-primary").eq(i).html($(this).text() + "&nbsp;<a><img src='"+$(".PageContext").val()+"/dist/images/x.png'></a>");        		
			}
           	filter();            
        });
        

        function filter(){       	
        	$(".products").each(function(){        			
       			$(this).show();       				
       		});       				            	
        	for(let i=0;i<myKey.length;i++){        		       		
	        	if(myKey[i]=="brand"){
	        		$(".products").each(function(){
	        			if($(this).find(".braName").val()!=myValue[i]){
	       					$(this).hide();
	       				}
	       			});       				
	        	}        		
	        	if(myKey[i]=="ptype"){
	       			$(".products").each(function(){
	       				if($(this).find(".ptypeName").val()!=myValue[i]){
	       					$(this).hide();
	       				}
	       			});       				
	       		}
	        	if(myKey[i]=="price"){
	        		if(myValue[i]=="100以下"){
	        			$(".products").each(function(){
		       				if(parseInt($(this).find(".proPrice").val())>100){
		       					$(this).hide();
		       				}
		       			}); 
	        		}
	        		if(myValue[i]=="100~500"){
	        			$(".products").each(function(){
		       				if(parseInt($(this).find(".proPrice").val())<100||parseInt($(this).find(".proPrice").val())>500){
		       					$(this).hide();
		       				}
		       			}); 
	        		}
	        		if(myValue[i]=="500以上"){
	        			$(".products").each(function(){
		       				if(parseInt($(this).find(".proPrice").val())<500){
		       					$(this).hide();
		       				}
		       			}); 
	        		}
	        	}
	        	if(myKey[i]=="search"){
	       			$(".products").each(function(){
	       				var ptypeName =$(this).find(".ptypeName").val();	       				
	       				var braName =$(this).find(".braName").val();
	       				var proName =$(this).find(".proName").val();
	       				var proPrice = $(this).find(".proPrice").val();
	       				var re = new RegExp(myValue[i], "g" );
	       				if(re.exec(ptypeName)==null&&re.exec(braName)==null&&re.exec(proName)==null&&re.exec(proPrice)==null){
	       					$(this).hide();
	       				}
        			});       				
	        	}
        	}      	
      }
    </script>

</body>
</html>