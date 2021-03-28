<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="lecSvc" scope="page"
	class="com.lecturer.model.LecturerService" />
<jsp:useBean id="costypeSvc" scope="page"
	class="com.coutype.model.CostypeService" />

<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>課程資料新增</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resource/datetimepicker/jquery.datetimepicker.css" />
</head>
<style>
* {
	font-size: 16px;
}

.h5 {
	text-align: center;
}
.fa-image{
	color:white !important;
}
.pic:hover .fa-image{
	color:#D8CF9E !important;
}
</style>
<body>
	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/cos/cos.do"
		name="form1" enctype="multipart/form-data">
		<c:if test="${not empty errorMsgs}">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
		<p class="lead mb-0">課程名稱:</p>
		<input type="TEXT" name="cosName" size="45" value="" />
		<p class="lead mb-0">講師:</p>
		<select size="1" name="lecNo">
			<c:forEach var="LecturerVO" items="${lecSvc.all}">
				<option value="${LecturerVO.getLecNo()}">${LecturerVO.getLecName()}
			</c:forEach>
		</select>
		<p class="lead mb-0">課程類別:</p>
		<select size="1" name="cosTypeNo">
			<c:forEach var="costypeVO" items="${costypeSvc.all}">
				<option value="${costypeVO.getCosTypeNo()}">${costypeVO.getCosTypeName()}
			</c:forEach>
		</select>
		<p class="lead mb-0">開訓日:</p>
		<input name="cosFrom" id="f_date1" type="text" autocomplete="off">
		<p class="lead mb-0">結訓日:</p>
		<input name="cosTo" id="f_date2" type="text" autocomplete="off">
		<p class="lead mb-0">課程介紹:</p>
		<textarea required class="mb-3 mt-0" name="cosIntro" cols="30"
			rows="10" placeholder="請輸入課程介紹"></textarea>
		<p class="lead mb-0">課程圖片:</p>
		<div id="preview"></div>
		<input required class="mb-3 mt-0" type="file" name="cosPic"
			id="myFile">
		<p class="lead mb-0">課程地址:</p>
		<div id="twzipcode"></div>
		<input type="TEXT" id="cosAdd" name="cosAdd" size="45"
			value="${cosVO.cosAdd}" />
		<p class="lead mb-0">報名人數下限:</p>
		<input type="number" name="cosMinCount" size="45" min="1" value="" />	
		<p class="lead mb-0">報名人數上限:</p>
		<input type="number" name="cosMaxCount" size="45" min="61" value="" />
		
		<p class="lead mb-0">課程價格:</p>
		<input type="number" name="cosPrice" size="45" min="1" value="" />
		<p class="lead mb-0">報名開始日:</p>
		<input name="cosApplyFrom" id="f_date3" type="text" autocomplete="off">
		<p class="lead mb-0">報名截止日:</p>
		<input name="cosApplyTo" id="f_date4" type="text" autocomplete="off">
		<p class="lead mb-0">課程狀態:</p>
		<label><input type="radio" name="cosStatus"
			value="${cosVO.cosStatus}" checked />上架</label> <label><input
			type="radio" name="cosStatus" value="${cosVO.cosStatus}" />下架</label>

		<div class="modal-footer">
			<input name="action" value="insert" type="hidden">
			<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			<input type="submit" class="btn btn-primary" value="新增">
		</div>
	</form>
	<script
		src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/resource/datetimepicker/jquery.js"></script>
	<script
		src="<%=request.getContextPath()%>/resource/datetimepicker/jquery.datetimepicker.full.js"></script>
	
	
	<script
		src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>

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

		$("#twzipcode").twzipcode({
			onDistrictSelect : function() {
				var country = $("select[name='county']").val(); // 取縣市的值
				var district = $("select[name='district']").val(); // 取鄉鎮市區的值
				var zipcode = $("input[name='zipcode']").val(); // 取郵遞區號的值
				$("#cosAdd").val(zipcode + country + district);

			},
		})
		

$.datetimepicker.setLocale('zh');

$(function() {
	$('#f_date1').datetimepicker(
			{
				format : 'Y-m-d H:i:s',
				value : '',
				minDate : '${empty cosVO.cosFrom?"-1969-12-31":cosVO.cosFrom}',
				
				onShow : function() {
					this.setOptions({
						maxDate : $('#f_date2').val() ? $('#f_date2')
								.val() : false
					})
				},
				timepicker : true,
				step : 60
			});

	$('#f_date2').datetimepicker(
			{
				format : 'Y-m-d H:i:s',
				value : '',
				onShow : function() {
					this.setOptions({
						minDate : $('#f_date1').val() ? $('#f_date1')
								.val() : false
					})
				},
				timepicker : true,
				step : 60
			});
});

$(function() {
	$('#f_date3').datetimepicker(
			{
				format : 'Y-m-d H:i:s',
				value : '',
				minDate : '',
				onShow : function() {
					this.setOptions({
						maxDate : $('#f_date1').val() ? $('#f_date1')
								.val() : false
					})
				},
				timepicker : true,
				step : 60
			});

	$('#f_date4').datetimepicker(
			{
				format : 'Y-m-d H:i:s',
				value : '',
				maxDate : '',
				onShow : function() {
					this.setOptions({
						maxDate : $('#f_date1').val() ? $('#f_date1')
								.val() : false,
						minDate : $('#f_date3').val() ? $('#f_date3')
										.val() : false
					})
				},
				timepicker : true,
				step : 60
			});
});

$("#twzipcode").twzipcode({
	onDistrictSelect: function() {
		var country = $("select[name='county']").val();  // 取縣市的值
		var district = $("select[name='district']").val();  // 取鄉鎮市區的值
		var zipcode = $("input[name='zipcode']").val();  // 取郵遞區號的值
		$("#cosAdd").val(zipcode+country+district);
	},
})
</script>

</body>
</html>