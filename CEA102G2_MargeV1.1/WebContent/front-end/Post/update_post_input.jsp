<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.post.model.*"%>

<%
	PostVO postVO = (PostVO) request.getAttribute("postVO");
%>
<html>
<head>

<script src="<%=request.getContextPath()%>/resource/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
	window.onload=function () {

		CKEDITOR.replace('postCon');
		
	}
	
</script>
<meta charset="UTF-8">
<title>貼文資料修改 - update_post_input.jsp</title>
</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>貼文資料修改 - update_post_input.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/front-end/Post/select_post_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料修改:</h3>


	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/post/post.do" name="form1" enctype="multipart/form-data">
		<table>
			<tr>
				<td>貼文編號:</td>
<!-- 				<td><input type="text" name="postNo"></td> -->
				<td>${postVO.postNo}</td>

			</tr>
			
			<tr>
					<td>設計師編號:</td>
<!-- 					<td><input type="text" name="desNo"></td> -->
			</tr>
			<tr>
				<td>貼文照片1</td>
				<td><input type="file" name="upfile1" id="myFile"></td>
			</tr>
			<tr>
				<td>貼文照片2</td>
				<td><input type="file" name="upfile2" id="myFile"></td>
			</tr>
			<tr>
				<td>貼文照片3</td>
				<td><input type="file" name="upfile3" id="myFile"></td>
			</tr>
			<tr>
				<td>是否隱藏</td>
				<td><input type="radio" name="postStatus" 
					value="0" /> 是
					<input type="radio" name="postStatus" 
					value="1"  checked/> 否
				</td>
			</tr>
			
			<tr>
				<td>是否置頂</td>
				<td><input type="radio" name="postPror" 
					value="true" /> 是
					<input type="radio" name="postPror" 
					value="false"  checked/> 否
				</td>
			</tr>	
			<tr>
				<td>貼文編輯</td>
				<td><textarea id='postCon' row="10" cols="48" name="postCon"
						size="45" >${postVO.postCon}</textarea>
				</td>
	

		</table>
	
	
	<br> <input type="hidden" name="action" value="update"> 
			<input type="hidden" name="postNo" value="${postVO.postNo}"> 
			<input type="hidden" name="desNo" value="${postVO.desNo}"> 
	
			<input type="submit" value="送出修改" onclick="processData()">
		
	</form>


</body>

 <script>
 function processData() {
		// getting data
		var data = CKEDITOR.instances.postCon.getData()
		form.submit();
	}
 
 </script>
</html>