<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.news.model.*"%>

<%
  NewsVO newsVO = (NewsVO) request.getAttribute("NewsVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>新聞資料新增 - addNews.jsp</title>
<script src="\MVCModelVer002\resource\build\ckeditor.js"></script>

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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>新聞資料新增 - addNews.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/front-end/news/select_page.jsp">
		 <img src="<%=request.getContextPath()%>/resource/images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/news/news.do" name="form1">
<table>

	<tr>
		<td>新聞標題:</td>
		<td><input type="TEXT" name="newsTitle" size="50" 
			 value="<%= (newsVO==null)? "標題想一想" : newsVO.getNewsTitle()%>" /></td>
	</tr>
	<tr>
		<td>新聞內容:</td>
		<td><input type="" name="newsCon" size="50"
			 value="<%= (newsVO==null)? "MANAGER" : newsVO.getNewsCon() %>" /></td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>

<!-- <div id="editor">This is some sample content.</div> -->

</body>

</html>