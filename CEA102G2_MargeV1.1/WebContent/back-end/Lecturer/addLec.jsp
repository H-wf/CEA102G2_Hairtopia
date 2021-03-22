<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.lecturer.model.*"%>

<%
	LecturerVO lecVO = (LecturerVO) request.getAttribute("lecVO");
%>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>講師資料新增 - addLec.jsp</title>
<%@include file="/back-end/tempFile/head"%>
<link
	href="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">

</head>
<body id="page-top">
	<%@include file="/back-end/tempFile/navBar_sideBar"%>
	<div class="container-fluid">

		<h3>資料新增:</h3>
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>

		<form METHOD="POST"
			ACTION="<%=request.getContextPath()%>/lecturer/lecturer.do"
			name="form" enctype="multipart/form-data">
			<div class="card shadow mb-4">

				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<jsp:useBean id="staffSvc" scope="page"
								class="com.staff.model.StaffService" />



							<tr>
								<td>選擇員工:</td>
								<td><select size="1" name="staNo">
										<c:forEach var="lecVO" items="${staffSvc.all}">
											<option value="${lecVO.staNo}">${lecVO.staName}
										</c:forEach>
								</select></td>




							</tr>

							<tr>
								<td>講師名稱:</td>
								<td><input type="TEXT" name="lecName" size="48"
									value="<%=(lecVO == null) ? "" : lecVO.getLecName()%>" /></td>

							</tr>
							<tr>
								<td>講師照片</td>
								<td><input type="file" name="upfile1" id="myFile">
								<div id="preview"></div>
								
								</td>
							</tr>
							<tr>
								<td>講師狀態</td>

								<td><select name="lecStatus">
										<option value="0" ${lecVO.lecStatus==0 ? 'selected' : '' }>未聘請</option>
										<option value="1" ${lecVO.lecStatus==1 ? 'selected' : '' }>正常聘請</option>
										<option value="9" ${lecVO.lecStatus==9 ? 'selected' : '' }>不再聘請</option>

								</select></td>
							</tr>
							<tr>
								<td>講師簡介</td>
								<td><textarea id='lecIntro' row="10" cols="48"
										class="form-control" id="exampleFormControlTextarea1" rows="5"
										name="lecIntro" size="45"><%=(lecVO == null) ? "" : lecVO.getLecIntro()%></textarea>
								</td>
							</tr>
						</table>
						<br> <input name="action" value="insert" type="hidden">
						<input type="submit" value="新增" class="btn btn-primary">
					</div>
				</div>
			</div>

	
		</form>
</div>
		<%@include file="/back-end/tempFile/footer"%>
		<%@include file="/back-end/tempFile/srcJs"%>
		<script
			src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery/jquery.min.js"></script>
		<script
			src="<%=request.getContextPath()%>/dist/backTemp/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
		<!-- Core plugin JavaScript-->
		<script
			src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery-easing/jquery.easing.min.js"></script>
		<!-- Custom scripts for all pages-->
		<script
			src="<%=request.getContextPath()%>/dist/backTemp/js/sb-admin-2.min.js"></script>
		<!-- Page level plugins -->
		<script
			src="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/jquery.dataTables.min.js"></script>
		<script
			src="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.js"></script>
		<!-- Page level custom scripts -->
		<script
			src="<%=request.getContextPath()%>/dist/backTemp/js/demo/datatables-demo.js"></script>
</body>
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


</html>