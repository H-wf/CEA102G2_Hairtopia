<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>

<%-- <% --%>
<!-- 	MemVO memVO = (MemVO) request.getAttribute("memVO"); -->
<!-- %> -->

<jsp:useBean id="memVO" scope="request" class="com.member.model.MemVO" />
<%-- <%= newsVO==null%> -- ${newsVO==null}<br>${newsVO.newsNo}<!-- 100 --> --%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>員工資料新增 - addEmp.jsp</title>
<script src="\MVCModelVer002\resource\build\ckeditor.js"></script>

<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
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

<style>
table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
}

table, th, td {
	border: 0px solid #CCCCFF;
}

th, td {
	padding: 1px;
}

#output {
	width: 100px;
	height: auto;
}
</style>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>新聞資料新增 - addNews.jsp</h3>
			</td>
			<td>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/member/select_page.jsp">
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

	<FORM METHOD="post"
		ACTION="<%=request.getContextPath()%>/member/mem.do" name="form1"
		enctype="multipart/form-data">
		<table>

			<tr>
				<td>會員名稱:</td>
				<td><input type="TEXT" name="memName" size="50"
					value="${memVO.memName}" /></td>
			</tr>
			<tr>
				<td>性別:</td>
				<td><input type="radio" id="male" name="gender" value="male" checked>
					<label for="male"  >Male</label><br> <input type="radio"
					id="female" name="gender" value="female"> <label
					for="female">Female</label></td>
			</tr>

			<tr>
				<td>會員信箱:</td>
				<td><input type="email" name="memEmail" size="50"
					value="${memVO.memEmail}" /></td>
			</tr>
			<tr>
				<td>會員密碼:</td>
				<td><input type="password" name="memPswd" size="50"
					value="${memVO.memPswd}" /></td>
			</tr>


			<tr>
				<td>自介:</td>
				<td><input type="text" name="memInform" size="50"
					value="${memVO.memInform}" /></td>

			</tr>

			<tr>
				<td>行動:</td>
				<td><input type="tel" name="memPhone" size="50" maxlength="10" pattern="09\d{2}\-?\d{3}\-?\d{3}"
					value="${memVO.memPhone}" /></td>

			</tr>
			<tr>
				<td>地址:</td>
				<td><input type="text" name="memAddr" size="50"
					value="${memVO.memAddr}" /></td>

			</tr>

			<tr>
				<td>大頭照:</td>
				<td><input type="file" name="memPic" accept="image/*"
					onchange="loadFile(event)"></td>
			</tr>
			<tr>
				<td></td>
				<td><img id="output" /></td>
				<!-- 給前端預覽用  -->
				<script>
					var loadFile = function(event) {
						var output = document.getElementById('output');
						output.src = URL.createObjectURL(event.target.files[0]);
						output.onload = function() {
							URL.revokeObjectURL(output.src) // free memory
						}
					};
				</script>

			</tr>
			<%-- 	<jsp:useBean id="deptSvc" scope="page" class="com.dept.model.DeptService" /> --%>
			<!-- 	<tr> -->
			<!-- 		<td>部門:<font color=red><b>*</b></font></td> -->
			<!-- 		<td><select size="1" name="deptno"> -->
			<%-- 			<c:forEach var="deptVO" items="${deptSvc.all}"> --%>
			<%-- 				<option value="${deptVO.deptno}" ${(newsVO.deptno==deptVO.deptno)? 'selected':'' } >${deptVO.dname} --%>
			<%-- 			</c:forEach> --%>
			<!-- 		</select></td> -->
			<!-- 	</tr> -->

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>

	<!-- <div id="editor">This is some sample content.</div> -->
</body>
</html>