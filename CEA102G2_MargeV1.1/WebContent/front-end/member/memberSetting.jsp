<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.member.model.*"%>


<jsp:useBean id="memSvc" scope="page"
	class="com.member.model.MemService" />

<%
	MemVO memVO = memSvc.getOneMem(1);
	request.setAttribute("memVO", memVO);
%>

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
<title>會員設定</title>
<meta charset="utf-8">
<%@include file="/front-end/tempFile/head"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/dist/css/memberSetting.css">
</head>
<style>
.ftco-navbar-light .navbar-nav>.nav-item .dropdown-menu .dropdown-item {
	font-weight: bold;
}
</style>

<body>
	<%@include file="/front-end/tempFile/navBar"%>

	<!-- <hr class="nar"> -->

	<!-- Begin Page Content -->
	<div class="container-fluid">
		<div class="container light-style flex-grow-1 container-p-y">

			<div class="card overflow-hidden">
				<div class="row no-gutters row-bordered row-border-light">
					<div class="col-md-3 pt-0">
						<div class="list-group list-group-flush account-settings-links">
							<a class="list-group-item list-group-item-action active"
								data-toggle="list" href="#account-general">一般</a> <a
								class="list-group-item list-group-item-action"
								data-toggle="list" href="#account-change-password">更改密碼</a> <a
								class="list-group-item list-group-item-action"
								data-toggle="list" href="#account-info">資訊</a>
						</div>
					</div>
					<div class="col-md-9">
						<div class="tab-content">
								<div class="tab-pane fade active show" id="account-general">
	
									<div class="card-body media align-items-center">
										<div class="img-block">
											<img id="output"
												src="<%=request.getContextPath()%>/showImges.do?tableName=member&picColumn=memPic&pkColumn=memNo&memNo=${memVO.memNo}"
												alt="" class="d-block ui-w-80">
										</div>
										<div class="media-body ml-4">
											<label class="btn btn-outline-primary"> 上傳照片 
												<input name="memPic" type="file" class="account-settings-fileinput" onchange="loadFile(event)" accept="image/*">
											</label> &nbsp;
											<div class="text-light small mt-1">JPG, GIF or PNG</div>
										</div>
									</div>
									<hr class="border-light m-0">
	
									<div class="card-body">
										<div class="form-group">
											<label class="form-label">姓名</label> 
											<input name="memName" type="text" class="form-control" value="${memVO.memName}">
										</div>
										<div class="form-group">
											<label class="form-label">Email</label> 
											<input name="memEmail" type="text" class="form-control mb-1" value="${memVO.memEmail}">
										</div>
									</div>
	
								</div>
								<div class="tab-pane fade" id="account-change-password">
									<div class="card-body pb-2">
	
										<div class="form-group">
											<label class="form-label">現在密碼</label> 
											<input name="" type="password" class="form-control">
										</div>
	
										<div class="form-group">
											<label class="form-label">新密碼</label> 
											<input type="password" class="form-control">
										</div>
	
										<div class="form-group">
											<label class="form-label">再次輸入密碼</label> 
											<input type="password" class="form-control">
										</div>
	
									</div>
								</div>
								<div class="tab-pane fade" id="account-info">
									<div class="card-body pb-2">
	
										<div class="form-group">
											<label class="form-label">關於我</label>
											<textarea class="form-control" rows="5" form="settingForm">
	                  							${memVO.memInform}
	                  						</textarea>
										</div>
									</div>
									<hr class="border-light m-0">
									<div class="card-body pb-2">
	
										<div class="form-group">
											<label class="form-label">性別</label> 
											<select size="1" name="memNo" class="form-control">
												<option value="null" ${memVO.memGender == 0 ? "selected": ""}>請選擇
	
												
												<option value="male" ${memVO.memGender == 1 ? "selected": ""}>男
	
												
												<option value="female"
													${memVO.memGender == 2 ? "selected": ""}>女
											</select>
										</div>
										<div class="form-group">
											<label class="form-label">電話</label> <input type="text"
												class="form-control" value="${memVO.memPhone}">
										</div>
										<div class="form-group">
											<label class="form-label">地址</label> <input type="text"
												class="form-control" value="${memVO.memAddr}">
										</div>
									</div>
								</div>
							</div>
						</div>
						
					</div>
				</div>


				<div class="text-right mt-3">
					<button id="post" type="button" class="btn btn-primary">儲存變更</button>
					&nbsp;
				</div>
				<div id="demo"></div>
			</div>
		</div>
		<!-- Page Content END -->
		<%@include file="/front-end/tempFile/footer"%>
		<%@include file="/front-end/tempFile/tempJs"%>

		<script>
		//預覽圖片
		var loadFile = function(event) {
			var output = document.getElementById('output');
			output.src = URL.createObjectURL(event.target.files[0]);
			output.onload = function() {
				URL.revokeObjectURL(output.src) // free memory
			}
		};
		
		$("#post").click(function(){
			let memPic = $()
			$.ajax({
					url:"<%=request.getContextPath()%>/member/mem.do",
					type : "POST",
					data : {
						action : "test",
						city : "Taiwan"
					},
					success : function(data) {
						$("#demo").html(data);
					}
				})
			});
		</script>
</body>
</html>