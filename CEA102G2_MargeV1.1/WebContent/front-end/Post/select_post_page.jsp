<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Post :Home</title>
<style>
table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
	border: 3px ridge Gray;
	height: 80px;
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
</head>
<body bgcolor='white'>
	<table id="table-1">
		<tr><td><h3>Hairtopia Post: Home</h3><h4>( MVC )</h4></td></tr>
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


	<ul>
		<li>
		<Form METHOD="post" ACTION="<%=request.getContextPath()%>/post/post.do">
		<b>List post by DesNo:</b>
		<input type="text" name="desNo">
		<input type="hidden" name="action" value="getOne_For_DisplayByDesNo"> 
		<input type="submit" value="送出">
		
		</Form><br>
		</li>
		
		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post/post.do">
				<b>輸入貼文編號:</b> <input type="text" name="postNo"> <input
					type="hidden" name="action" value="getOne_For_Display"> <input
					type="submit" value="送出">
			</FORM><br>
		</li>
		

		<jsp:useBean id="postSvc" scope="page"	class="com.post.model.PostService" />
		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post/post.do">
				<b>選擇貼文編號:</b> <select size="1" name="postNo">
					<c:forEach var="postVO" items="${postSvc.all}">
						<option value="${postVO.postNo}">${postVO.postNo}
					</c:forEach>
				</select> 
				<input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>
	</ul>

	<h3>貼文管理</h3>

	<ul>
		<li><a href='insertPost_Page.jsp'>Add</a> a new Post.</li>
	</ul>

</body>
</html>