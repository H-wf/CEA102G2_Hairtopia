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

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>貼文資料新增 - insertPost_Page.jsp</title>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>貼文資料新增 - insertPost_Page.jsp</h3>
			</td>
			<td>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/Post/select_post_page.jsp">
						<img
						src="<%=request.getContextPath()%>/resource/images/tomcat.png"
						width="100" height="100" border="0">回首頁
					</a>
				</h4>
			</td>
		</tr>
	</table>
	<h3>資料新增:</h3>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/post/post.do"
		name="form" enctype="multipart/form-data">
		<table>
			<tr>
				<td>設計師編號:</td>
				<td><input type="TEXT" name="desNo" size="48" 
					value="<%=(postVO == null) ? "" : postVO.getDesNo()%>" /></td>
			</tr>
			<tr>
				<td>貼文照片1</td>
				<td><input type="file" name="upfile1" id="myFile1"></td>
			</tr>
			<tr>
				<td>貼文照片2</td>
				<td><input type="file" name="upfile2" id="myFile2"></td>
			</tr>
			<tr>
				<td>貼文照片3</td>
				<td><input type="file" name="upfile3" id="myFile3"></td>
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
			</tr>
		</table>
		<br> <input name="action" value="insert" type="hidden"> <input
			type="button" value="新增" onclick="processData()">

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