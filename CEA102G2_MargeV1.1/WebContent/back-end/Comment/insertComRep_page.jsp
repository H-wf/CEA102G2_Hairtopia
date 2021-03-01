<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert CommentRep</title>
</head>
<body>
<a href='listAllComRep.jsp'>List</a>
	<form method="post" action="/CEA102G2/comrep/comrep.do">
		<h2>留言編號</h2>
		<input type="text" name="comNo"><br>
		<h2>檢舉方會員編號</h2>
		<input type="text" name="memNo"><br>
		<h2>檢舉內容</h2>
		<input type="text" name="crepCon"><br>
		<input type="hidden" name="action" value="insert">
		<input type="submit" value="送出">
	</form>
</body>
</html>