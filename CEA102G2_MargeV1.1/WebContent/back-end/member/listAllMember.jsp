<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	MemService memSvc = new MemService();
	List<MemVO> list = memSvc.getAll();
	pageContext.setAttribute("list", list);
%>


<html>
<head>
<title>會員資料</title>
<%@include file="/back-end/tempFile/head"%>
<link
	href="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
</head>
</head>
<body id="page-top">
	<%@include file="/back-end/tempFile/navBar_sideBar"%>
	
	<div class="container-fluid">
		<p class="mb-4">
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
		</p>
		
		<div class="card shadow mb-4">
		
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>編號</th>
								<th>姓名</th>
								<th>性別</th>
								<th>信箱</th>
								<th>密碼</th>
								<th>狀態</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th>編號</th>
								<th>姓名</th>
								<th>性別</th>
								<th>信箱</th>
								<th>密碼</th>
								<th>狀態</th>
							</tr>
						</tfoot>
						<jsp:useBean id="salonSvc" scope="page" class="com.salon.model.SalonService" />
						<tbody>	
							<c:forEach var="memVO" items="${list}">
								<tr>
									<td>${memVO.memNo}</td>
									<td>${memVO.memName}</td>
									<td>${(memVO.memGender == null)?"": (memVO.memGender == 1) ? "男" : "女"}</td>
									<td>${memVO.memEmail}</td>
									<td>${memVO.memPswd}</td>
					
<%-- 									<td><fmt:formatDate value="${memVO.memEndDate}" pattern="yyyy-MM-dd" /></td>  --%>
									<td>
										<select  onchange="updateSatus(event, '${memVO.memEmail}')">
											<option value="null" ${memVO.memStatus == 0 ? "selected": ""}>未驗證</option>
											<option value="normal" ${memVO.memStatus == 1 ? "selected": ""}>正常</option>
											<option value="suspension" ${memVO.memStatus == 2 ? "selected": ""}>停權</option>
										</select>
									</td>
								</tr>
						</c:forEach>
						</tbody>
					</table>
					
				</div>
			</div>
		</div>
	</div>
	
	<%-- 錯誤表列 --%>
	

<!-- 	<table> -->
<!-- 		<tr> -->
<!-- 			<th>會員編號</th> -->
<!-- 			<th>會員姓名</th> -->
<!-- 			<th>性別</th> -->
<!-- 			<th>自介</th> -->
<!-- 			<th>信箱</th> -->
<!-- 			<th>密碼</th> -->
<!-- 			<th>電話</th> -->
<!-- 			<th>地址</th> -->
<!-- 			<th>錢包餘額</th> -->
<!-- 			<th>狀態</th> -->
<!-- 			<th>停權到期日</th> -->
<!-- 			<th>啟用碼</th> -->
<!-- 			<th>大頭照</th> -->
<!-- 			<th>修改</th> -->
<!-- 			<th>刪除</th> -->
			
<!-- 		</tr> -->
<%-- 		<%@ include file="/resource/pages/page1.file"%> --%>
<%-- 		<c:forEach var="memVO" items="${list}" begin="<%=pageIndex%>" --%>
<%-- 			end="<%=pageIndex+rowsPerPage-1%>"> --%>

<!-- 			<tr> -->
<%-- 				<td>${memVO.memNo}</td> --%>
<%-- 				<td>${memVO.memName}</td> --%>
<%-- 				<td>${(memVO.memGender == 0	)?"": (memVO.memGender == 1) ? "男" : "女"}</td> --%>
<%-- 				<td>${memVO.memInform}</td> --%>
<%-- 				<td>${memVO.memEmail}</td> --%>
<%-- 				<td>${memVO.memPswd}</td> --%>
<%-- 				<td>${memVO.memPhone}</td> --%>
<%-- 				<td>${memVO.memAddr}</td> --%>
<%-- 				<td>${memVO.memBal}</td> --%>
<%-- 				<td>${(memVO.memStatus == 0	)? "未驗證": (memVO.memStatus == 1) ? "正常" : "停權"}</td> --%>
<%-- 				<td><fmt:formatDate value="${memVO.memEndDate}" pattern="yyyy-MM-dd" /></td>  --%>
<%-- 				<td>${memVO.memCode}</td> --%>
<%-- 				<td><img class="headshot" src="<%=request.getContextPath()%>/showImges.do?tableName=member&picColumn=memPic&pkColumn=memNo&memNo=${memVO.memNo}"></td> --%>
<!-- 				<td> -->
<!-- 					<FORM METHOD="post" -->
<%-- 						ACTION="<%=request.getContextPath()%>/member/mem.do" --%>
<!-- 						style="margin-bottom: 0px;"> -->
<!-- 						<input type="submit" value="修改">  -->
<%-- 						<input type="hidden" name="memNo" value="${memVO.memNo}"> --%>
<%-- 						<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> <!--送出本網頁的路徑給Controller--> --%>
<%-- 						<input type="hidden" name="whichPage" value="<%=whichPage%>"> <!--送出當前是第幾頁給Controller--> --%>
<!-- 						<input type="hidden" name="action" value="getOne_For_Update"> -->
						 
<!-- 					</FORM> -->
<!-- 				</td> -->
<!-- 				<td> -->
<!-- 					<FORM METHOD="post" -->
<%-- 						ACTION="<%=request.getContextPath()%>/member/mem.do" --%>
<!-- 						style="margin-bottom: 0px;"> -->
<!-- 						<input type="submit" value="刪除"> <input type="hidden" -->
<%-- 							name="memNo" value="${memVO.memNo}">  --%>
<!-- 						<input type="hidden" name="requestURL" -->
<%-- 							value="<%=request.getServletPath()%>"> <!--送出本網頁的路徑給Controller--> --%>
<%-- 						<input type="hidden" name="whichPage" value="<%=whichPage%>"> <!--送出當前是第幾頁給Controller--> --%>
<!-- 						<input type="hidden" name="action" value="delete"> -->
<!-- 					</FORM> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<%-- 		</c:forEach> --%>
<!-- 	</table> -->
	<%@include file="/back-end/tempFile/footer"%>
	<%@include file="/back-end/tempFile/srcJs"%>
	<script>
		function updateSatus(event, memEmail){
// 			console.log(event.target.value);
			let selectVal = event.target.value;
			let memStatus = (selectVal === "normal") ? 1 :(selectVal === "suspension") ? 2 : 0;
			
			$.ajax({
				url:"<%=request.getContextPath()%>/member/mem.do",
				type:"POST",
				data:{
					action: "test",
					memEmail: memEmail,
					memStatus: memStatus
					},
				success:function(data){
					console.log(data);
				}
			});
		}
	</script>

</body>
</html>