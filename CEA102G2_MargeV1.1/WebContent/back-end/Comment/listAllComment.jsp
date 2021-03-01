<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.comment.model.*"%>
<%
    CommentService commentSvc = new CommentService();
    List<CommentVO> list = commentSvc.getAll();
    pageContext.setAttribute("list",list);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List All Comment</title>
</head>
<body>
<table>
	<tr>
		<th>留言編號</th>
		<th>貼文編號</th>
		<th>會員編號</th>
		<th>留言內容</th>
		<th>留言時間</th>
		<th>留言狀態</th>
	</tr>
	<c:forEach var="commentVo" items="${list}">
		<tr>
			
				<td>${commentVo.comNo}</td>
				<td>${commentVo.postNo}</td>
				<td>${commentVo.memNo}</td>
				<td>${commentVo.comCon}</td>
				<td>${commentVo.comTime}</td>
				<td>${commentVo.comStatus == true?"顯示":"隱藏"}</td>
				
				<td>
				<FORM method="post" action="<%=request.getContextPath()%>/comment/comment.do">
			     <input type="text" name="comCon" value="${commentVo.comCon}">
			     <input type="submit" value="修改">
			     <input type="hidden" name="comNo" value= "${commentVo.comNo}">
			     <input type="hidden" name="action"	value="update_Comment"></FORM>
				</td>
				
				<td>
				<FORM method="post" action="<%=request.getContextPath()%>/comment/comment.do">
			     <input type="submit" value="${commentVo.comStatus eq true?"隱藏":"顯示"}">
			     <input type="hidden" name="comNo" value= "${commentVo.comNo}">
			     <input type="hidden" name="comStatus" value= "${commentVo.comStatus eq true?"false":"true"}"">
			     <input type="hidden" name="action"	value="delete_Comment"></FORM>
				</td>
				
		</tr>
	</c:forEach>
</table>
</body>
</html>