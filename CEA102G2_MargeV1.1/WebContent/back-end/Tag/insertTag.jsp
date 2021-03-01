<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>新增標籤 Insert Tag </title>
</head>
<body>
<a href='listAllTag.jsp'>List</a>
	<form method="post" action="<%=request.getContextPath()%>/tag/tag.do">
		<h2>標籤名稱</h2>
		<input type="text" name="tagName"><br>
		<input type="hidden" name="action" value="insert">
		<input type="submit" value="送出">
	</form>

</body>
</html>