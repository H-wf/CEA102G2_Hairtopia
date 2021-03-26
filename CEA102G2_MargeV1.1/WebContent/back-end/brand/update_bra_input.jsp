<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.brand.model.*"%>

<%
	BrandVO brandVO = (BrandVO) request.getAttribute("brandVO");
%>

<html>
<head>
<meta charset="UTF-8">
<title>商品品牌資料修改</title>
</head>
<body>
<form METHOD="POST" ACTION="<%=request.getContextPath()%>/brand/brand.do" name="form1" enctype="multipart/form-data"> 
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<p class="lead mb-0"><label>商品品牌編號:<i>${brandVO.braNo}</i></label></p>
	<p class="lead mb-0"><label for="braName">商品品牌名稱:</label></p>
	<input required class="form-control form-control-sm" style="width:200px;" id="braName" type="TEXT" name="braName" size="45" value="${brandVO.braName}" />
	<p class="lead mb-0"><label>商品類別Logo:</label></p>
	<div id="preview2"></div>
	<label>
	<input style="display:none;" class="mb-3 mt-0" type="file" name="braLogo" id="myFile2">
	<span class="btn btn-primary btn-sm pic"><i class="fas fa-image"></i>上傳圖片</span>
	</label>
	<p class="lead mb-0"><label for="braIntro">商品類別介紹:</label></p>
	<textarea required class="form-control mb-3" id="braIntro" name="braIntro" cols="30" rows="10" placeholder="請輸入品牌介紹">${brandVO.braIntro}</textarea>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		<input type="submit" class="btn btn-primary" value="修改">
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="braNo" value="${brandVO.braNo}">
	</div>
</form>
<script>
var customFile2 = document.getElementById("myFile2");
var preview2 = document.getElementById('preview2');
customFile2.addEventListener('change', function(e) {
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
				preview2.innerHTML = "";
				preview2.append(img);
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