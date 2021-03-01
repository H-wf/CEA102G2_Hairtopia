<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.lecturer.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	LecturerService lecSvc2 = new LecturerService();
	List<LecturerVO> list = lecSvc2.getAll();
	pageContext.setAttribute("list", list);
%>



<!DOCTYPE html>
<html>
<head>
<style type="text/css">
img {
	width: 150px;
}
</style>
<meta charset="UTF-8">
<title>所有講師資料 - listAll_lec.jsp</title>
</head>
<body>
	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有講師資料 - listAll_lec.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/Lecturer/select_lec_page.jsp">
						<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁
					</a>
				</h4>
			</td>
		</tr>
	</table>


	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>


	<table>
		<tr>
			<th>講師編號</th>
			<th>講師姓名</th>
			<th>照片</th>
			<th>簡介</th>
			<th>狀態</th>

		</tr>

		<jsp:useBean id="lecSvc" scope="page"
			class="com.lecturer.model.LecturerService" />

		<%@ include file="/resource/pages/page1.file"%>
		<c:forEach var="lecVO" items="${lecSvc.all}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">>
			<tr>
				<td>${lecVO.lecNo}</td>
				<td>${lecVO.lecName}</td>
				<td><img
					src="<%=request.getContextPath()%>/PicFinder?pic=1&table=lecturer&column=lecPic&idname=lecNo&id=${lecVO.lecNo}"
					alt='沒有圖片' /></td>
				<td>${lecVO.lecIntro}</td>
				<td><c:if test="${lecVO.lecStatus == 0}">
				 未聘請
				</c:if> <c:if test="${lecVO.lecStatus == 1}">
				 正常聘請
				</c:if> <c:if test="${lecVO.lecStatus == 9}">
				 不再聘請
				</c:if></td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/lecturer/lecturer.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改"> <input type="hidden"
							name="lecNo" value="${lecVO.lecNo}"> <input type="hidden"
							name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/lecturer/lecturer.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="lecNo" value="${lecVO.lecNo}"> <input type="hidden"
							name="action" value="delete">
					</FORM>
				</td>
			</tr>

		</c:forEach>




	</table>
	<%@ include file="/resource/pages/page2.file"%>

</body>
</html>