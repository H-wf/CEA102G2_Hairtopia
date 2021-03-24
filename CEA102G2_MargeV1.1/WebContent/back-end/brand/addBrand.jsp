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
		<div id="preview"></div>
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
<script>
var customFile = document.getElementById("myFile");
var preview = document.getElementById('preview');
customFile.addEventListener('change', function(e) {
	// 取得檔案物件的兩種方式
	// 1. 直接從myFile物件上取得檔案物件 (因為非同步，一樣，多個classname註冊時會有問題)
	// 2. 從event物件中取得他的soure target，也就是myFile物件，再取得檔案物件 
	// 檔案的基本資訊，包括：檔案的名稱、大小與文件型態
	let files = e.target.files;
	// 判斷files物件是否存在
	if (files) {
		// 取出files物件的第一個
		let file = files[0];
		// 判斷file.type的型別是否包含'image'
		if (file.type.indexOf('image') > -1) {
			// new a FileReader
			let reader = new FileReader();
			// 在FileReader物件上註冊load事件 - 載入檔案的意思
			reader.addEventListener('load', function(e) {
				// 取得結果 提示：從e.target.result取得讀取到結果
				let result = e.target.result;
				console.log(result);
				// 新增img元素
				let img = document.createElement('img');
				// 賦予src屬性
				img.setAttribute('src', result);
				img.setAttribute('width', '200');
				img.classList.add("prviewImg");
				// 放到div裡面
				preview.innerHTML = "";
				preview.append(img);
			});
			// 使用FileReader物件上的 readAsDataURL(file) 的方法，傳入要讀取的檔案，並開始進行讀取
			reader.readAsDataURL(file); // *** trigger read file content
		} else {
			// 彈出警告視窗 
			alert('請上傳圖片！');
		}
	}
});
</script>
</body>
</html>