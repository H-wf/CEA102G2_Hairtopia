<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>
<%@ page import="com.comment.model.*"%>

<%
	PostVO postVO = (PostVO) request.getAttribute("postVO"); 
%>
<%
    CommentService commentSvc = new CommentService();
    List<CommentVO> list = commentSvc.getComsByPostNo(postVO.getPostNo());
    pageContext.setAttribute("list",list);
%>
<html>
<head>
<meta charset="UTF-8">
<title>List Comment Of A Post Back</title>
</head>
<body>
<table id="table-1">
		<tr><td><h3>Hairtopia Post-Comment: Back-end</h3><h4>( MVC )</h4></td></tr>
	</table>
	<table>
		<tr>
			<th>設計師編號</th>
			<th>貼文內容</th>
			<th>上傳時間</th>
			<th>貼文狀態</th>
			<th>優先度</th>
			<th>照片1</th>
			<c:if test='${not empty postVO.postPic2}'>
			<th>照片2</th>
			</c:if>
			<c:if test='${not empty postVO.postPic3}'>
			<th>照片3</th>
			</c:if>	
			<th>新增留言</th>
			
		</tr>
		<tr> 
			<td>${postVO.desNo}</td>
			<td>${postVO.postCon}</td>
			<td><fmt:formatDate value="${postVO.postTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td>${postVO.postStatus}</td>
			<td>${postVO.postPror}</td>
			
		<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}" alt='沒有圖片' /></td>
	 	<c:if test='${not empty postVO.postPic2}'>
			<td>
		  		<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic2&idname=postNo&id=${postVO.postNo}" alt='沒有圖片' />
			</td>
		</c:if>
		
		<c:if test='${not empty postVO.postPic3}'>
			<td>
		   		<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic3&idname=postNo&id=${postVO.postNo}" alt='沒有圖片' />
			</td>
		</c:if>
		
			<td>
		<form method="post" action="<%=request.getContextPath()%>/comment/comment.do">
		
		<input type="text" name="comCon">
		<input type="hidden" name="postNo" value="${postVO.postNo}">
		<input type="hidden" name="memNo" value="1">
		<input type="hidden" name="action" value="insert">
		<input type="submit" value="送出">
		</form>
		</td>			
		</tr>
	</table>
	
<table>
	<tr>
		<th>留言編號</th>
		<th>會員編號</th>
		<th>留言內容</th>
		<th>留言時間</th>
		<th>留言狀態</th>
	</tr>
	<c:forEach var="commentVo" items="${list}">

		<tr ${(commentVo.comNo==param.comNo) ? 'bgcolor=#CCCCFF':''}>
			
				<td>${commentVo.comNo}</td>
				<td>${commentVo.memNo}</td>
				<td>${commentVo.comCon}</td>
				<td>${commentVo.comTime}</td>
				<td>${commentVo.comStatus == true?"顯示":"隱藏"}</td>
				
				<td>
				<FORM method="post" action="<%=request.getContextPath()%>/comment/comment.do">
			     <input type="text" name="comCon" value="${commentVo.comCon}">
			     <input type="submit" value="修改">
			     <input type="hidden" name="postNo" value= "${postVO.postNo}">
			     <input type="hidden" name="comNo" value= "${commentVo.comNo}">
			     <input type="hidden" name="action"	value="update_Comment"></FORM>
				</td>
				
				<td>
				<FORM method="post" action="<%=request.getContextPath()%>/comment/comment.do">
			     <input type="submit" value="${commentVo.comStatus eq true?"隱藏":"顯示"}">
			     <input type="hidden" name="postNo" value= "${postVO.postNo}">
			     <input type="hidden" name="comNo" value= "${commentVo.comNo}">
			     <input type="hidden" name="comStatus" value= "${commentVo.comStatus eq true?"false":"true"}"">
			     <input type="hidden" name="action"	value="delete_Comment"></FORM>
				</td>
				
		</tr>

	</c:forEach>
</table>
</body>
</html>