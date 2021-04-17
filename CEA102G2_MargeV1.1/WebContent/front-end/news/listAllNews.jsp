<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.news.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	NewsService newsSvc = new NewsService();
	List<NewsVO> list = newsSvc.getAll();
	pageContext.setAttribute("list", list);
%>


<html>
<head>
<title>所有新聞資料 - listAllNews.jsp</title>

<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>

<style>
table {
	width: 100%;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>

</head>
<body bgcolor='white'>

	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有新聞資料 - listAllNews.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/front-end/news/select_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<%-- 錯誤表列 --%>
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
			<th>新聞編號</th>
			<th>日期</th>
			<th>新聞標題</th>
			<th>新聞內容</th>
			<th>修改</th>
			<th>刪除</th>
		</tr>
		<%@ include file="/resource/pages/page1.file"%>
		<c:forEach var="newsVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<td>${newsVO.newsNo}</td>
				<td><fmt:formatDate value="${newsVO.newsTime}"
						pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>${newsVO.newsTitle}</td>
				<td>${newsVO.newsCon}</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/news/news.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改"> 
						<input type="hidden" name="newsNo" value="${newsVO.newsNo}">
						<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> <!--送出本網頁的路徑給Controller-->
						<input type="hidden" name="whichPage" value="<%=whichPage%>"> <!--送出當前是第幾頁給Controller-->
						<input type="hidden" name="action" value="getOne_For_Update">
						 
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/news/news.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="newsNo" value="${newsVO.newsNo}"> 
						<input type="hidden" name="requestURL"
							value="<%=request.getServletPath()%>"> <!--送出本網頁的路徑給Controller-->
						<input type="hidden" name="whichPage" value="<%=whichPage%>"> <!--送出當前是第幾頁給Controller-->
						<input type="hidden" name="action" value="delete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/pages/page2.file"%>

</body>
</html>