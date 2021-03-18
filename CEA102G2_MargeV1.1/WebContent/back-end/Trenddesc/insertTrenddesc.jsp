<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>新增風格誌明細　Insert Trenddesc</title>
</head>
<body>
<a href='listAllTrenddesc.jsp'>List</a>
	<form method="post" action="<%=request.getContextPath()%>/trenddesc/trenddesc.do">
		<h2>風格誌編號</h2>
		<input type="text" name="treNo"><br>
		<h2>貼文編號</h2>
		<input type="text" name="postNo"><br>
		<input type="hidden" name="action" value="insert">
		<input type="submit" value="送出">
	</form>
</body>
</html>