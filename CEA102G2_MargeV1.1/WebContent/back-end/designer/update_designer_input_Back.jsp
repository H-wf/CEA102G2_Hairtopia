<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.designer.model.*"%>

<%
	DesignerVO designerVO = (DesignerVO) request.getAttribute("designerVO");
	//DesignerServlet.java (Concroller) 存入req的designerVO物件 (包括幫忙取出的designerVO, 也包括輸入資料錯誤時的designerVO物件)

	String weekArray[] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
	pageContext.setAttribute("weekArray", weekArray);
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>服務資料修改 - update_designer_input.jsp</title>
<meta charset="utf-8">
<%@include file="/back-end/tempFile/head"%>
<link
	href="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">

</head>
<body id="page-top">
	<%@include file="/back-end/tempFile/navBar_sideBar"%>
	<!-- Begin Page Content -->
	<div class="container-fluid">
		<jsp:useBean id="salonSvc" scope="page"
			class="com.salon.model.SalonService" />
		<div class="row">

			<div class="col-12">
				<h3>服務資料修改:</h3>

				<%-- 錯誤表列 --%>
				<c:if test="${not empty errorMsgs}">
					<font style="color: red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>


				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/designer/designer.do"
					name="form1">
					<div class="card shadow mb-4">
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">

									<!-- 怎麼捕捉新增服務的設計師 -->

									<tr>
										<th>沙龍:</th>
										<td>${salonSvc.getOneSalon(designerVO.salNo).salName}</td>
									</tr>
									<tr>
										<th>設計師:</th>
										<td>${designerVO.desName}</td>
									</tr>
									<tr>
										<th>設計師照片:</th>
										<td><img width="150px"
											src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}"
											alt='沒有圖片' /></td>
									</tr>

									<tr>
										<th>設計師狀態</th>
										<td><div class="custom-control custom-switch">
												<input type="checkbox" class="custom-control-input"
													name="desStatus" id="customSwitch1" checked><label
													class="custom-control-label" for="customSwitch1">審核狀態</label>

											</div></td>
									</tr>
								


									<tr>
										<th>營業時間</th>
										<td>
											<table>

												<tr>

													<td style="border: 0px"><table
															class="table table-borderless">
															<c:forEach var="myData" begin="0" end="27" step="4">
																<c:set var="i" value="${myData/4}" />
																<c:set var="desSchedule"
																	value="${designerVO.desSchedule}" />

																<fmt:parseNumber var="start"
																	value="${desSchedule.substring(myData,myData+2)}"
																	integerOnly="true" />
																<c:set var="startHour"
																	value="${((start*30 -(start*30%60)))/60}" />
																<tr>
																	<td>${weekArray[i]}</td>
																	<td><fmt:formatNumber value="${startHour}"
																			type="number" maxFractionDigits="0" />: ${(start*30 %60 == 0)? "00" :"30"}</td>

																	<td>to</td>
																	<fmt:parseNumber var="end"
																		value="${desSchedule.substring(myData+2,myData+4)}"
																		integerOnly="true" />
																	<c:set var="endHour"
																		value="${((end*30 -(end*30%60)))/60}" />

																	<td><fmt:formatNumber value="${endHour}"
																			type="number" maxFractionDigits="0" />: ${(end*30 %60 == 0)? "00" :"30"}</td>
																</tr>
															</c:forEach>


														</table></td>
												</tr>



											</table>
										</td>
									</tr>
									<tr>


									

									</tr>


								</table>
								
									<input type="hidden" name="action"
											value="Update_Status"> <input type="hidden"
											name="desNo" value="${designerVO.desNo}"> <input
											id="saveButton" type="submit" value="送出修改"
											class="btn btn-primary">
							</div>
						</div>
					</div>

					<br>
				</FORM>

			</div>
		</div>
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
	$('#saveButton').on('click', function() {

		var $collectedIsVisible = '';

		if ($('#customSwitch1').is(':checked')) {

			$collectedIsVisible = $('#customSwitch1').attr('value', '1');
		} else {
			$collectedIsVisible = $('#customSwitch1').attr('value', '0');
		}
		console.log($('#customSwitch1').val())
	})
</script>
</html>