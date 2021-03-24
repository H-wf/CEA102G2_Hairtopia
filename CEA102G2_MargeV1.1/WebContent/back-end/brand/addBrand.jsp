<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.brand.model.*"%>


<html lang="en">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>商品品牌資料新增</title>
</head>
<style>
*{
	font-size:16px;
}
.h5{
	text-align:center;
}
</style>
<body>
	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/brand/brand.do" name="form1" enctype="multipart/form-data">
		<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
		</c:if>
		<p class="lead mb-0">商品類別名稱:</p>
		<input required class="mb-3 mt-0" type="TEXT" name="braName" size="20" placeholder="請輸入品牌名稱" value="" />
		<p class="lead mb-0">商品類別Logo:</p>
		<input required class="mb-3 mt-0" type="file" name="braLogo" id="myFile">
		<p class="lead mb-0">商品類別介紹:</p>
		<textarea required class="mb-3 mt-0" name="braIntro" cols="30" rows="10" placeholder="請輸入品牌介紹"></textarea>
		<div class="modal-footer">
			<input name="action" value="insert" type="hidden" >
			<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			<input type="submit" class="btn btn-primary" value="新增">
		</div>
	</form>
                
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery/jquery.min.js"></script>
</body>
</html>