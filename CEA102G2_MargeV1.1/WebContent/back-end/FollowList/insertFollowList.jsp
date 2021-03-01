<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>新增追蹤名單明細　Insert FollowList</title>
</head>
<body>
<a href='listAllFollowList.jsp'>List</a>
	<form method="post" action="/CEA102G2/followlist/followlist.do">
		<h2>會員編號</h2>
		<input type="text" name="memNo"><br>
		<h2>設計師編號</h2>
		<input type="text" name="desNo"><br>
		<input type="hidden" name="action" value="insert">
		<input type="submit" value="送出">
	</form>
</body>
</html>