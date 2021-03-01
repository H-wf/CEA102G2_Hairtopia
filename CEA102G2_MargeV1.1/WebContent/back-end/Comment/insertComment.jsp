<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Comment</title>
</head>
<body>
<a href='listAllCommetn.jsp'>List</a>
	<form method="post" action="/CEA102G2/comment/comment.do">
		<h2>貼文編號</h2>
		<input type="text" name="postNo"><br>
		<h2>留言會員編號</h2>
		<input type="text" name="memNo"><br>
		<h2>留言內容</h2>
		<input type="text" name="comCon"><br>
		<input type="hidden" name="action" value="insert">
		<input type="submit" value="送出">
	</form>
</body>
</html>