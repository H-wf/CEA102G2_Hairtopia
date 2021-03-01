<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lecturer.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	LecturerVO lecVO = (LecturerVO) request.getAttribute("lecVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>
<html>
<head>
<style>
img {
	width: 150px;
}
</style>

<title>講師資料 - listOneLec.jsp</title>
</head>
<body bgcolor='white'>

	
	<table id="table-1">
		<tr>
			<td>
				<h3>講師資料 - listOneLec.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Lecturer/select_lec_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>講師編號</th>
			<th>講師姓名</th>
			<th>講師照片</th>
			<th>講師簡介</th>
			<th>講師狀態</th>
				
		</tr>
		<tr> 
			<td>${lecVO.lecNo}</td>
			<td>${lecVO.lecName}</td>
			<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=lecturer&column=lecPic&idname=lecNo&id=${lecVO.lecNo}" alt='沒有圖片' /></td>
			<td>${lecVO.lecIntro}</td>
			<td><c:if test="${lecVO.lecStatus == 0}">
				 未聘請
				</c:if>
				<c:if test="${lecVO.lecStatus == 1}">
				 正常聘請
				</c:if>
				<c:if test="${lecVO.lecStatus == 9}">
				 不再聘請
				</c:if>
			</td>
		</tr>


	</table>

</body>
</html>