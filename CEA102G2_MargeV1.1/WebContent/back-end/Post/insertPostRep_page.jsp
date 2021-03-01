<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert PostRep</title>
</head>
<body>
<a href='listAllPostRep.jsp'>List</a>
	<form method="post" action="/CEA102G2/postrep/postrep.do">
		<h2>貼文編號</h2>
		<input type="text" name="postNo"><br>
		<h2>檢舉方會員編號</h2>
		<input type="text" name="memNo"><br>
		<h2>檢舉內容</h2>
		<input type="text" name="postRepCon"><br>
		<input type="hidden" name="action" value="insert">
		<input type="submit" value="送出">
	</form>
</body>
</html>