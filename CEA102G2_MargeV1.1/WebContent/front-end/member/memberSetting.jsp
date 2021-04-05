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
					
					<form method="POST" action="<%=request.getContextPath()%>/member/mem.do" name="settingForm" id="settingForm" enctype="multipart/form-data">
						<div class="tab-content">
								<div class="tab-pane fade active show" id="account-general">
	
									<div class="card-body media align-items-center">
										<div class="img-block">
											<img id="output"
												src="<%=request.getContextPath()%>/showImges.do?tableName=member&picColumn=memPic&pkColumn=memNo&memNo=${userSession.memNo}"
												alt="" class="d-block ui-w-80">
										</div>
										<div class="media-body ml-4">
											<label class="btn btn-outline-primary"> 上傳照片 
												<input id="uploadSettingPhoto" name="memPic" type="file" class="account-settings-fileinput" onchange="loadFile(event)" accept="image/*">
											</label> &nbsp;
											<div class="text-light small mt-1">JPG, GIF or PNG</div>
										</div>
									</div>
									<hr class="border-light m-0">
	
									<div class="card-body">
										<div class="form-group">
											<label class="form-label">顯示名稱</label> 
											<input id="memName" name="memName" type="text" class="form-control" value="${userSession.memName}">
											<span id="memNameMessage" style="color:red">${errorMsgs.memName}
											${errorMsgs.exception}</span>
										</div>
										<div class="form-group">
											<label class="form-label">電子信箱</label> 
											<input id="memEmail" name="memEmail" type="text"  class="form-control mb-1" value="${userSession.memEmail}">
											<span id="memEmailMessage" style="color:red">${errorMsgs.memEmail}</span> 
										</div>
									</div>
	
								</div>
								<div class="tab-pane fade" id="account-change-password">
									<div class="card-body pb-2">
	
										<div class="form-group">
											<label class="form-label">現在密碼</label> 
											<input id="memPswd" name="memPswd" type="password" class="form-control">
											<span id="memNameMessage" style="color:red">${errorMsgs.memPswd}</span> 
										</div>
	
										<div class="form-group">
											<label class="form-label">新密碼</label> 
											<input id="newMemPswd" name="newMemPswd" type="password" class="form-control">
											<span id="newMemPswdMessage" style="color:red">${errorMsgs.newMemPswd}</span> 
										</div>
	
										<div class="form-group">
											<label class="form-label">再次輸入密碼</label> 
											<input id="comfirmPswd" name="comfirmPswd" type="password" class="form-control">
										</div>
	
									</div>
								</div>
								<div class="tab-pane fade" id="account-info">
									<div class="card-body pb-2">
	
										<div class="form-group">
											<label class="form-label">關於我</label>
											<textarea id="memInform" name="memInform"class="form-control" rows="5" form="settingForm">${userSession.memInform}</textarea>
										</div>
									</div>
									<hr class="border-light m-0">
									<div class="card-body pb-2">
	
										<div class="form-group">
											<label class="form-label">性別</label> 
											<select  id="memGender" size="1" name="memGender" class="form-control">
												<option value="null" ${userSession.memGender == 0 ? "selected": ""}>請選擇</option>
												<option value="male" ${userSession.memGender == 1 ? "selected": ""}>男</option>
												<option value="female" ${userSession.memGender == 2 ? "selected": ""}>女</option>
											</select>
											<span id="memGenderMessage" style="color:red">${errorMsgs.memGender}</span> 
										</div>
										<div class="form-group">
											<label class="form-label">電話</label> 
											<input id="memPhone" name="memPhone" type="text" class="form-control" value="${userSession.memPhone}">
										</div>
										<div class="form-group">
											<label class="form-label">地址</label> 
											<input id="memAddr" name="memAddr" type="text" class="form-control" value="${userSession.memAddr}">
										</div>
									</div>
								</div>
							</div>
							
							<div class="text-right mt-3">
								<button id="settingBtn" type="submit" class="btn btn-primary">儲存變更</button>
								&nbsp;
							</div>
							<input type="hidden" name="action" value="updateSetting"> 
							<input type="hidden" name="memNo" value="${userSession.memNo}"> 
							<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
					</form>
						
						</div>
						
					</div>
				</div>


				
				<div id="demo"></div>
			</div>
		</div>
		<!-- Page Content END -->
		<%@include file="/front-end/tempFile/footer"%>
		<%@include file="/front-end/tempFile/tempJs"%>
		<script src="http://jqueryvalidation.org/files/dist/jquery.validate.min.js"></script>
		<script src="http://jqueryvalidation.org/files/dist/additional-methods.min.js"></script>

		<script>
		//預覽圖片
		function loadFile(event) {
				var output = document.getElementById("output");
				output.src = URL.createObjectURL(event.target.files[0]);
				output.onload = function() {
					URL.revokeObjectURL(output.src) // free memory
				}
			};

		$(function(){
			
			
			if(${SettingSuccess eq true}){
				Swal.fire({
		        	  text: '修改已儲存',
		        	  icon: 'success',
		        	  confirmButtonText: '關閉',
		        	  timer: 1500
		        	});
			}
			if(${SettingSuccess eq false}){
				Swal.fire({
		        	  text: '輸入錯誤',
		        	  icon: 'error',
		        	  confirmButtonText: '關閉',
		        	  timer: 1500
		        	});
			}
		});

		
// 		$("#settingBtn").click(function(){
			
// 			var formData = new FormData();
//             formData.append("memPic",$('#uploadSettingPhoto')[0].files[0]);
//             formData.append("action", "test");
// //             formData.append("memEmail", $('#memEmail').val());
// 	        console.log($('#uploadSettingPhoto')[0].files[0]);
            
// 			$.ajax({
<%-- 					url:"<%=request.getContextPath()%>/member/mem.do", --%>
// 					type : "POST",
// 					contentType: "application/json",
// 					data : formData ,
// 					processData: false ,
//                     contentType: false ,
//                     mimeType: "multipart/form-data",
// 					success : function(data) {
// 						console.log(data);
// 					}
// 				})
// 			});
		</script>
		<script>
		
		
		$(function(){		
			jQuery.validator.setDefaults({
				debug: false,
				success: "valid"
			});
			
			jQuery.extend(jQuery.validator.messages, {
				required: "必填欄位",
				remote: "請修正該欄位",
				email: "請輸入正確格式的電子郵件",
				url: "請輸入合法的網址",
				date: "請輸入合法的日期",
				dateISO: "請輸入合法的日期 (ISO).",
				number: "請輸入合法的數字",
				digits: "只能輸入整數",
				creditcard: "請輸入合法的信用卡號",
				equalTo: "請再次輸入相同的值",
				accept: "請輸入擁有合法字尾名的字串",
				maxlength: jQuery.validator.format("請輸入一個 長度最多是 {0} 的字串"),
				minlength: jQuery.validator.format("請輸入一個 長度最少是 {0} 的字串"),
				rangelength: jQuery.validator.format("請輸入 一個長度介於 {0} 和 {1} 之間的字串"),
				range: jQuery.validator.format("請輸入一個介於 {0} 和 {1} 之間的值"),
				max: jQuery.validator.format("請輸入一個最大為{0} 的值"),
				min: jQuery.validator.format("請輸入一個最小為{0} 的值")
				});
			
			
			$( "#settingForm" ).validate({
				errorClass: "errorMessage",
				errorElement: "span",
				rules: {
// 					newMemPswd: "required",
					comfirmPswd: {
				    	equalTo: "#newMemPswd"
				    }
				  }
				
			});
		});
			
		</script>
</body>
</html>