<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.product.model.*"%>

<%
	ProductVO productVO = (ProductVO) request.getAttribute("productVO");
%>
<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" />
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" />
<html>
<head>
<meta charset="UTF-8">
<title>商品資料修改</title>
</head>
<style>
.fa-image{
	color:white !important;
}
.pic:hover .fa-image{
	color:#D8CF9E !important;
}
</style>
<body>
<form METHOD="POST" ACTION="<%=request.getContextPath()%>/product/product.do" name="form1" enctype="multipart/form-data"> 
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<p class="lead mb-0"><label>商品編號:<i>${productVO.proNo}</i></label></p>
	<p class="lead mb-0"><label for="ptypeNo">商品類別:</label></p>
			<select class="form-control form-control-sm" style="width:100px;" size="1" id="ptypeNo" name="ptypeNo">
				<c:forEach var="ptypeVO" items="${ptypeSvc.all}">
					<option value="${ptypeVO.ptypeNo}"${(productVO.ptypeNo==ptypeVO.ptypeNo)?'selected':'' }>${ptypeVO.ptypeName}
				</c:forEach>
			</select>
	<p class="lead mb-0"><label for="braNo">商品品牌:</label></p>
		<select class="form-control form-control-sm" style="width:100px;" size="1" id="braNo" name="braNo">
			<c:forEach var="brandVO" items="${brandSvc.all}">
				<option value="${brandVO.braNo}" ${(productVO.braNo==brandVO.braNo)?'selected':'' } >${brandVO.braName}
			</c:forEach>
		</select>
	<p class="lead mb-0"><label for="proName">商品名稱:</label></p>
	<input required class="form-control form-control-sm" style="width:200px;" id="proName" type="TEXT" name="proName" size="20" placeholder="請輸入商品名稱" value="${productVO.proName}" />
	<p class="lead mb-0"><label>上架狀態:</label></p>
	<label><input type="radio" name="proStatus" value="true" ${productVO.proStatus==true?'checked':''}/>上架</label>					
	<label><input type="radio" name="proStatus" value="false" ${!productVO.proStatus==true?'checked':''}/>下架</label>	
	<p class="lead mb-0"><label for="proPrice">商品單價:</label></p>
	<input required class="form-control form-control-sm"  style="width:200px;" type="number" min="0" name="proPrice" size="20" placeholder="請輸入商品金額" value="${productVO.proPrice}" />		
	<p class="lead mb-0"><label>商品主圖:</label></p>
	<div id="preview3"></div>
	<label>
	<input style="display:none;" class="mb-3 mt-0" type="file" name="proMpic" id="myFile3">
	<span class="btn btn-primary btn-sm pic"><i class="fas fa-image"></i>上傳圖片</span>
	</label>
	<p class="lead mb-0"><label>商品副圖:</label></p>
	<div id="preview4"></div>
	<label>
	<input style="display:none;" class="mb-3 mt-0" type="file" name="proPic" id="myFile4">
	<span class="btn btn-primary btn-sm pic"><i class="fas fa-image"></i>上傳圖片</span>
	</label>
	<p class="lead mb-0"><label for="proDesc">商品描述:</label></p>
	<textarea required class="form-control mb-3" id="proDesc" name="proDesc" cols="30" rows="10" placeholder="請輸入商品描述">${productVO.proDesc}</textarea>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		<input type="submit" class="btn btn-primary" value="修改">
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="proNo" value="${productVO.proNo}">
	</div>
</form>

<script>
var customFile3 = document.getElementById("myFile3");
var preview3 = document.getElementById('preview3');
customFile3.addEventListener('change', function(e) {
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
				preview3.innerHTML = "";
				preview3.append(img);
			});
			// 使用FileReader物件上的 readAsDataURL(file) 的方法，傳入要讀取的檔案，並開始進行讀取
			reader.readAsDataURL(file); // *** trigger read file content
		} else {
			// 彈出警告視窗 
			alert('請上傳圖片！');
		}
	}
});
var customFile4 = document.getElementById("myFile4");
var preview4 = document.getElementById('preview4');
customFile4.addEventListener('change', function(e) {
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
				preview4.innerHTML = "";
				preview4.append(img);
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