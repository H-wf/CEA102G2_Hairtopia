<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.designer.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	DesignerVO designerVO = (DesignerVO) request.getAttribute("designerVO"); //DesignerServlet.java(Concroller), 存入req的designerVO物件
%>
<%
	String weekArray[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
	pageContext.setAttribute("weekArray", weekArray);
%>

<html>
<head>
<title>設計師資料for Back-end - listOneDesigner Back-end.jsp</title>
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
		<div class="row">
			<div class="col-12">
			
				<div class="card mb-3" style="max-width: 540px;">
					<div class="row no-gutters">
						<div class="col-md-4">
							<img src="..." alt="...">
						</div>
						<div class="col-md-8">
							<div class="card-body">
								<h5 class="card-title">Card title</h5>
								<p class="card-text">This is a wider card with supporting
									text below as a natural lead-in to additional content. This
									content is a little bit longer.</p>
								<p class="card-text">
									<small class="text-muted">Last updated 3 mins ago</small>
								</p>
							</div>
						</div>
					</div>
				</div>


			</div>

			<div class="col-6">
			<table>
				<tr>
					<th>設計師編號</th>
					<td>${designerVO.desNo}</td>
				</tr>
				<tr>
					<th>設計師姓名</th>
					<td>${designerVO.desName}</td>
				</tr>
				<tr>
					<th>會員編號</th>
					<td>${designerVO.memNo}</td>
				</tr>
				<jsp:useBean id="salonSvc" scope="page"
					class="com.salon.model.SalonService" />
				<tr>
					<th>服務沙龍</th>
					<td><c:forEach var="salonVO" items="${salonSvc.all}">
							<c:if test="${designerVO.salNo==salonVO.salNo}">
	                    ${salonVO.salNo}-${salonVO.salName}
                    </c:if>
						</c:forEach></td>
				</tr>
				<tr>
					<th>設計師名稱</th>
					<td>${designerVO.desName}</td>
				</tr>
				<tr>
					<th>設計師簡介</th>
					<td>${designerVO.desInfor}</td>
				</tr>
				<tr>
					<th>方案到期日</th>
					<td>${designerVO.desEndDate}</td>
				</tr>
				<tr>

					<th>審核狀態</th>
					<c:if test="${designerVO.desStatus == 0}">
						<td>未驗證</td>
					</c:if>
					<c:if test="${designerVO.desStatus == 1}">
						<td>已驗證</td>
					</c:if>
					<c:if test="${designerVO.desStatus == 2}">
						<td>停權</td>
					</c:if>

				</tr>
				<tr>
					<th>班表</th>
					<td><table>
							<c:forEach var="myData" begin="0" end="27" step="4">
								<c:set var="i" value="${myData/4}" />
								<c:set var="desSchedule" value="${designerVO.desSchedule}" />

								<fmt:parseNumber var="start"
									value="${desSchedule.substring(myData,myData+2)}"
									integerOnly="true" />
								<c:set var="startHour" value="${((start*30 -(start*30%60)))/60}" />
								<tr>
									<td>${weekArray[i]}</td>
									<td><fmt:formatNumber value="${startHour}" type="number"
											maxFractionDigits="0" />: ${(start*30 %60 == 0)? "00" :"30"}</td>

									<td>to</td>
									<fmt:parseNumber var="end"
										value="${desSchedule.substring(myData+2,myData+4)}"
										integerOnly="true" />
									<c:set var="endHour" value="${((end*30 -(end*30%60)))/60}" />

									<td><fmt:formatNumber value="${endHour}" type="number"
											maxFractionDigits="0" />: ${(end*30 %60 == 0)? "00" :"30"}</td>
								</tr>

							</c:forEach>
						</table></td>
				</tr>
				<tr>
					<th>設計師照片</th>
					<td><img
						src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}"
						alt='沒有圖片' /></td>
				</tr>
				<tr>
					<th>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/designer/designer.do"
							style="margin-bottom: 0px;">
							<input type="submit" value="修改"> <input type="hidden"
								name="desNo" value="${designerVO.desNo}"> <input
								type="hidden" name="action" value="getOne_For_Update_Status">
						</FORM>
					</th>

					<th>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/designer/designer.do"
							style="margin-bottom: 0px;">
							<input type="submit" value="刪除(for test)"> <input
								type="hidden" name="desNo" value="${designerVO.desNo}">
							<input type="hidden" name="action" value="delete">
						</FORM>
					</th>
				</tr>

			</table>
			</div>
		</div>
	</div>

</body>
</html>