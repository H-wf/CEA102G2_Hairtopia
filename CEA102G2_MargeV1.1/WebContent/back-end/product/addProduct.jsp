<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.product.model.*"%>

<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" />
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" />

<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>商品資料新增</title>
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
	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/product/product.do" name="form1" enctype="multipart/form-data">
		<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
		</c:if>
		<p class="lead mb-0">商品類別:</p>
			<select size="1" name="ptypeNo">
				<c:forEach var="ptypeVO" items="${ptypeSvc.all}">
					<option value="${ptypeVO.ptypeNo}">${ptypeVO.ptypeName}
				</c:forEach>
			</select>
		<p class="lead mb-0">商品品牌:</p>
			<select size="1" name="braNo">
				<c:forEach var="brandVO" items="${brandSvc.all}">
					<option value="${brandVO.braNo}">${brandVO.braName}
				</c:forEach>
			</select>
		<p class="lead mb-0">商品名稱:</p>
		<input required class="mb-3 mt-0" type="TEXT" name="proName" size="20" placeholder="請輸入商品名稱" value="" />
		<p class="lead mb-0">上架狀態:</p>
		<label><input type="radio" name="proStatus" value="${prodouctVO.proStatus}" checked/>上架</label>					
		<label><input type="radio" name="proStatus" value="${productVO.proStatus}" />下架</label>	
		<p class="lead mb-0">商品單價:</p>
		<input required class="mb-3 mt-0" type="number" min="0" name="proPrice" size="20" placeholder="請輸入商品金額" value="" />		
		<p class="lead mb-0">商品主圖:</p>
		<div id="preview1"></div>
		<input required class="mb-3 mt-0" type="file" name="proMpic" id="myFile1">
		<p class="lead mb-0">商品副圖:</p>
		<div id="preview2"></div>
		<input required class="mb-3 mt-0" type="file" name="proPic" id="myFile2">
		<p class="lead mb-0">商品描述:</p>
		<textarea required class="mb-3 mt-0" name="proDesc" cols="30" rows="10" placeholder="請輸入商品描述"></textarea>
		<div class="modal-footer">
			<input name="action" value="insert" type="hidden" >
			<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			<input type="submit" class="btn btn-primary" value="新增">
		</div>
	</form>
                
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery/jquery.min.js"></script>
<!-- 	<table id="table-1"> -->
<!-- 		<tr> -->
<!-- 			<td> -->
<!-- 				<h3>商品資料新增 - addProduct.jsp</h3> -->
<!-- 			</td> -->
<!-- 			<td> -->
<!-- 				<h4> -->
<%-- 					<a href="<%=request.getContextPath()%>/back-end/product/select_page.jsp">回首頁</a> --%>
<!-- 				</h4> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 	</table> -->
<!-- 	<h3>資料新增:</h3> -->
 	<%-- 錯誤表列 --%>
<%-- 	<c:if test="${not empty errorMsgs}"> --%>
<!-- 		<font style="color: red">請修正以下錯誤:</font> -->
<!-- 		<ul> -->
<%-- 			<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 				<li style="color: red">${message}</li> --%>
<%-- 			</c:forEach> --%>
<!-- 		</ul> -->
<%-- 	</c:if> --%>

	

<%-- 	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/product/product.do" name="form1" enctype="multipart/form-data"> --%>
<!-- 		<table> -->
<!-- 			<tr> -->
<!-- 				<td>商品類別:</td> -->
<%-- 				 <jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" /> --%>
<!-- 				<td> -->
<!-- 					<select size="1" name="ptypeNo"> -->
<%-- 						<c:forEach var="ptypeVO" items="${ptypeSvc.all}"> --%>
<%-- 							<option value="${ptypeVO.ptypeNo}">${ptypeVO.ptypeName} --%>
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
<!-- 				</td> -->
					
<!-- 			</tr> -->

<!-- 			<tr> -->
<!-- 				<td>品牌名稱</td> -->
<%-- 				<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" /> --%>
<!-- 				<td> -->
<!-- 					<select size="1" name="braNo"> -->
<%-- 						<c:forEach var="brandVO" items="${brandSvc.all}"> --%>
<%-- 							<option value="${brandVO.braNo}">${brandVO.braName} --%>
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>商品名稱</td> -->
<!-- 				<td><input type="TEXT" name="proName" size="45" -->
<%-- 					value="<%= (productVO == null) ? "" : productVO.getProName()%>" /></td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>上架狀態</td> -->
<!-- 				<td> -->
<%-- 					<label><input type="radio" name="proStatus" value="${prodouctVO.proStatus}" checked/>上架</label>					 --%>
<%-- 					<label><input type="radio" name="proStatus" value="${productVO.proStatus}" />下架</label>				 --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>商品單價</td> -->
<!-- 				<td><input type="TEXT" name="proPrice" size="45" -->
<%-- 					value="<%= (productVO == null) ? "" : productVO.getProPrice()%>" /></td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>商品主圖</td> -->
<!-- 				<td><input type="file" name="proMpic" id="myFile"></td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>商品副圖</td> -->
<!-- 				<td><input type="file" name="proPic" id="myFile"></td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>商品描述</td> -->
<%-- 				<td><textarea name="proDesc"><%= (productVO == null) ? "" : productVO.getProDesc()%></textarea></td>					 --%>
<!-- 			</tr> -->
<!-- 		</table> -->
	
	
<!-- 		<br>  -->
<!-- 		<input name="action" value="insert" type="hidden" > -->
<!-- 		<input type="submit" value="新增"> -->
		
<!-- 	</form> -->
<script>
var customFile1 = document.getElementById("myFile1");
var preview1 = document.getElementById('preview1');
customFile1.addEventListener('change', function(e) {
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
				preview1.innerHTML = "";
				preview1.append(img);
			});
			// 使用FileReader物件上的 readAsDataURL(file) 的方法，傳入要讀取的檔案，並開始進行讀取
			reader.readAsDataURL(file); // *** trigger read file content
		} else {
			// 彈出警告視窗 
			alert('請上傳圖片！');
		}
	}
});
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