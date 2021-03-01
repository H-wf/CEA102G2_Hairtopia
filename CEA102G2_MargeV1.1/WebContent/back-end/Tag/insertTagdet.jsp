<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>新增標籤明細　Insert TagDet</title>
</head>
<body>
<a href='listAllTagdet.jsp'>List</a>
	<form method="post" action="/CEA102G2/tagdet/tagdet.do">
		<h2>標籤編號</h2>
		<input type="text" name="tagNo"><br>
		<h2>貼文編號</h2>
		<input type="text" name="postNo"><br>
		<input type="hidden" name="action" value="insert">
		<input type="submit" value="送出">
	</form>
</body>
</html>