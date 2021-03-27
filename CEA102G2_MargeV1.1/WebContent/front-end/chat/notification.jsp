<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chat.model.*"%>
<%@ page import="com.member.model.*"%>

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <meta charset="utf-8">
 <script src="<%=request.getContextPath()%>/dist/js/jquery.min.js"></script>
</head>

<style>
body {
	box-sizing: border-box;
}

ol, ul {
	list-style: none;
}

.nav>li>a {
	position: relative;
	display: block;
	padding: 10px 15px;
	text-align: center;
}

article, body, dd, div, dl, dt, fieldset, figure, footer, form, h1, h2,
	h3, h4, h5, h6, header, input, li, ol, p, pre, section, td, textarea,
	th, ul {
	margin: 0;
	padding: 0;
	font-weight: 400;
}

.notification_buble {
	display: block;
	position: absolute;
	top: 80px;
	right: 200px;
	width: 340px;
	max-height: 480px;
	background: #fff;
	overflow: hidden;
	z-index: 200;
}

@media ( max-width : 991.98px) {
	.notification_buble {
		width: 100%;
		right: 0px;
	}
}

.notification_buble.active {
	display: block;
}

a, a:link {
	color: #48adc5;
	text-decoration: none;
	cursor: pointer;
}

.box {
	background: #fff;
	box-shadow: 0 0 3px #ccc;
	box-sizing: border-box;
}

.nav-tabs.nav-justified {
	width: 100%;
	border-bottom: 0;
	padding: 0px;
	display: block;
}

.notification_buble .nav-tabs.nav-justified>li {
	display: table-cell;
	width: 1%;
}

.notification_buble .nav-tabs.nav-justified>li>a {
	margin-bottom: 0;
}

.nav-tabs.nav-justified>li>a, .nav-tabs>li>a {
	border: none;
	border-bottom: 1px solid #ccc;
	color: #666;
	transition: all .2s;
	padding: 12px 13px 8px;
}

.nav-tabs.nav-justified>.active>a, .nav-tabs.nav-justified>.active>a:focus,
	.nav-tabs.nav-justified>.active>a:hover, .nav-tabs>li.active>a,
	.nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover {
	background: 0 0;
	border: none;
	border-bottom: 3px solid #3d3d3d;
	padding: 12px 13px 6px;
	color: #3d3d3d;
	font-weight: 700;
}

.nav-tabs.nav-justified>li>a, .nav-tabs>li>a {
	border: none;
	border-bottom: 1px solid #ccc;
	color: #666;
	transition: all .2s;
	padding: 12px 13px 8px;
}

.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover
	{
	cursor: default;
}

.notification_buble .notification_list, .notification_list {
	overflow: hidden;
}

.notification_buble .notification_list a {
	color: #666;
}

.notification_buble .notification_list_wrap {
	max-height: 360px;
	overflow: auto;
}

.notification_list li {
	border-bottom: 1px solid #ccc;
	transition: .5s all;
	-webkit-transition: all .5s;
	position: relative;
	display: block;
}

.notification_list li figure {
	width: 48px;
	height: 48px;
	overflow: hidden;
	position: absolute;
	left: 6px;
	top: 6px;
}
img.noti_img {
    float: right;
    height: auto;
    max-height: 52px;
    max-width: 54px;
    margin: 0 10px 0 6px;
}

img.cover_fit {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.navbar-nav img.cover_fit, .notification_list img.cover_fit {
    height: 100%;
}

.notification_list .noti_con {
	min-height: 60px;
	margin: 0 0 0 62px;
	padding-top: 4px;
	text-align: left;
}

.notification_list .user_name {
	font-size: 16px;
	padding-top: 2px;
}

.notification_list .msg {
	margin-top: 5px;
	margin-right: 50px;
	overflow: hidden;
}

.notification_list .chat_time {
	position: absolute;
	top: 7px;
	right: 5px;
	font-size: 13px;
	color: #aaa;
}

.none_data {
	padding: 0px;
	text-align: center;
	padding-top: 20px;
	font-size: 18px;
	color: #666;
	min-height: 100px;
}
.notification_more {
    padding: 7px 0 3px;
    text-align: center;
}



</style>
<body>
<!-- Begin Page Content -->
<!--通知欄位 -->

					<div class="notification_buble box">
						<ul class="nav nav-tabs nav-justified">
							<li role="presentation" class="active">
								 <a id="chat">我的訊息</a>
							</li>
							<li role="presentation" class="">
								<a id="aboutme">關於我的</a>
							</li>
							<li role="presentation" class="">
								 <a id="myfollowing">我追蹤的</a>
							</li>
						</ul>

						<div style="display: block;">
							<div class="notification_list_wrap">
								<div class="loader_li list_loader">
									<div class="loader" data-loader="circle"></div>
								</div>
								<ul class="notification_list">
									<li class="clearfix">
										<a class="clearfix">
											<figure>
												<img class="cover_fit" src="">
											</figure>
											<div class="noti_con">
												<div class="user_name"></div>
												<div class="msg" style="padding-bottom: 8px; margin-top: 0px;"></div>
												<div class="chat_time"></div>
												<!-- react-text: 477 -->
												<!-- /react-text -->
											</div>
										</a>
									</li>
									
									<!-- /react-text -->
									<li class="notification_more btn_loader"><a>
											<div class="loader" data-loader="circle"></div> <!-- react-text: 1409 -->載入更多
											<!-- /react-text -->
									</a></li>
								</ul>
							</div>
						</div>

						<div style="display: none;">
							<div class="notification_list_wrap">
								<div class="loader_li list_loader">
									<div class="loader" data-loader="circle"></div>
								</div>
								
								
								<ul class="notification_list">
								
									<li class="clearfix">
										<a class="clearfix">
											<figure>
													<img class="cover_fit" src="">
												
											</figure>
											<div class="noti_con">
												<img class="noti_img" src="https://cdn.style-map.com/post/photo/small/625048.jpg">
												<div class="msg">Rocco  發表了新貼文$</div>
												<div class="post_time">8 天前</div>
											</div>
										</a>
									</li>
								
<!-- 									<div class="none_data">尚無通知</div> -->
									<!-- react-text: 170 -->
									<!-- /react-text -->
								</ul>
							</div>
						</div>
						<div style="display: none;">
							<div class="notification_list_wrap">
								<div class="loader_li list_loader">
									<div class="loader" data-loader="circle"></div>
								</div>
<!-- 								<ul class="notification_list"> -->
<!-- 									<div class="none_data">尚無通知</div> -->
<!-- 									react-text: 358 -->
<!-- 									/react-text -->
<!-- 								</ul> -->
							</div>
						</div>
					</div></li>
				<!--通知欄位end -->
<!-- Page Content END -->
</body>
<script>
$(function() {
	
	$('.bi-bell').click(function() {
		$('.notification_buble').toggleClass('active');
	});
	var list = document.querySelectorAll(".notification_buble > div");
	console.log(list);
	  
	$('#chat').click(function(){
		$('.notification_buble > div:eq(0)').css('display', 'block');
		$('.notification_buble > div:eq(1)').css('display', 'none');
		$('.notification_buble > div:eq(2)').css('display', 'none');
		$(this).parent().addClass("active");
		$(this).parent().next().removeClass("active");
		$(this).parent().next().next().removeClass("active");
	});
	$('#aboutme').click(function(){
		$('.notification_buble > div:eq(0)').css('display', 'none');
		$('.notification_buble > div:eq(1)').css('display', 'block');
		$('.notification_buble > div:eq(2)').css('display', 'none');
		$(this).parent().prev().removeClass("active");
		$(this).parent().addClass("active");
		$(this).parent().next().removeClass("active");
		
	});
	$('#myfollowing').click(function(){
		$('.notification_buble > div:eq(0)').css('display', 'none');
		$('.notification_buble > div:eq(1)').css('display', 'none');
		$('.notification_buble > div:eq(2)').css('display', 'block');
		$(this).parent().prev().removeClass("active");
		$(this).parent().prev().prev().removeClass("active");
		$(this).parent().addClass("active");
	});
});

</script>
</html>