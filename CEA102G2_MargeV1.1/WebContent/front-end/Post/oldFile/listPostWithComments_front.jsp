<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.post.model.*"%>
<%@ page import="java.util.*"%>
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
<title>List Comment Of A Post Front</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Prata&display=swap">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/animate.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/owl.carousel.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/magnific-popup.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/aos.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/jquery.timepicker.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/tagify/tagify.css">
    <script src="<%=request.getContextPath()%>/dist/js/jquery-3.2.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/jquery-migrate-3.0.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/jquery.easing.1.3.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/jquery.waypoints.min.js"></script><!-- << -->
	<script src="<%=request.getContextPath()%>/dist/js/jquery.stellar.min.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/jquery.magnific-popup.min.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/jquery.animateNumber.min.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/jquery.timepicker.min.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/bootstrap-datepicker.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/popper.min.js"></script>
</head>
<style>
	.comTime{
        margin-left: 80%;
    }
    .comCon{
    	color:black;
    }
</style>
<body>
<table id="table-1">
		<tr><td><h3>Hairtopia Post-Comment: Front-end</h3><h4>( MVC )</h4></td></tr>
	</table>
	<table>
		<tr>
			<th>設計師編號</th>
			<th>貼文內容</th>
			<th>上傳時間</th>
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
		<input type="hidden" name="action" value="insert_Front">
		<input type="submit" value="送出">
		</form>
		</td>			
		</tr>
	</table>
	
<table>
	<tr>
		<th>會員編號</th>
		<th>留言內容</th>
		<th>留言時間</th>
	</tr>
	<c:forEach var="commentVo" items="${list}">
	<c:if test= '${commentVo.comStatus != false}'>
		<tr ${(commentVo.comNo==param.comNo) ? 'bgcolor=#CCCCFF':''}>
			
				<td>${commentVo.memNo}</td>
				<td>${commentVo.comCon}</td>
				<td>${commentVo.comTime}</td>
				
				<td>
				<FORM method="post" action="<%=request.getContextPath()%>/comment/comment.do">
			     <input type="text" name="comCon" value="${commentVo.comCon}">
			     <input type="submit" value="修改">
			     <input type="hidden" name="postNo" value= "${postVO.postNo}">
			     <input type="hidden" name="comNo" value= "${commentVo.comNo}">
			     <input type="hidden" name="action"	value="update_Comment_Front"></FORM>
				</td>
				
				<td>
				<FORM method="post" action="<%=request.getContextPath()%>/comment/comment.do">
			     <input type="submit" value="${commentVo.comStatus eq true?"刪除":""}">
			     <input type="hidden" name="postNo" value= "${postVO.postNo}">
			     <input type="hidden" name="comNo" value= "${commentVo.comNo}">
			     <input type="hidden" name="comStatus" value= "${commentVo.comStatus eq true?"false":"true"}"">
			     <input type="hidden" name="action"	value="delete_Comment_Front"></FORM>
				</td>
				
		</tr>
	</c:if>
	</c:forEach>
</table>

<div class="card mb-3">
        <div class="row g-0">
            <div class="col-md-6">
                <img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}" class="card-img" />
            </div>
            <div class="col-md-6">
                <div class="card-body">
	                <div class="card-title">
	                	<h2>${postVO.desNo}</h2>
	                    <h5 class="m-0">${postVO.postCon}</h5>
	                    <small class="text-muted"><fmt:formatDate value="${postVO.postTime}" pattern="yyyy-MM-dd HH:mm:ss" /></small>
	                </div>
                    <p class="card-text">
                        <ul class="list-group list-group-flush">
	                        <c:forEach var="commentVo" items="${list}">
								<c:if test= '${commentVo.comStatus != false}'>
	                        
	                            <li class="list-group-item comCon">${commentVo.comCon}<p class="card-text"><small class="text-muted comTime">${commentVo.comTime}</small></p>
	                            </li>
<!--  有會員之後要判斷出刪除、修改按鈕 -->
	                         	</c:if>
	                         </c:forEach>
                        </ul>
                    </p>
                    <form method="post" action="<%=request.getContextPath()%>/comment/comment.do">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="輸入留言" name="comCon">
						<input type="hidden" name="postNo" value="${postVO.postNo}">
						<input type="hidden" name="memNo" value="1">
						<input type="hidden" name="action" value="insert">
                        <button class="btn btn-outline-secondary" type="submit">留言</button>
                    </div>
						</form>
                </div>
            </div>
        </div>
    </div>
</body>
	<script src="<%=request.getContextPath()%>/dist/js/aos.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/owl.carousel.min.js"></script><!-- << -->
	<script src="<%=request.getContextPath()%>/dist/js/scrollax.min.js"></script>
	<script src="<%=request.getContextPath()%>/dist/js/main.js"></script>
	<script src="<%=request.getContextPath()%>/dist/tagify/jQuery.tagify.min.js"></script>
</html>