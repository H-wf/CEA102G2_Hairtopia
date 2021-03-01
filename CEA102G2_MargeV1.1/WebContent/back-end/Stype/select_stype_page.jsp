<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<title>Stype :Home</title>
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
<body>



	<table id="table-1">
		<tr><td><h3>Hairtopia Stype: Home</h3><h4>( MVC )</h4></td></tr>
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
		<li><a href='listAll_stype.jsp'>List</a> all Sertypes. <br> <br></li>
		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/stype/stype.do">
				<b>輸入功能編號:</b> <input type="text" name="stypeNo"> <input
					type="hidden" name="action" value="getOne_For_Display"> <input
					type="submit" value="送出">
			</FORM>
		</li>

		<jsp:useBean id="stypeSvc" scope="page"
			class="com.sertype.model.StypeService" />


		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/stype/stype.do">
				<b>選擇功能編號:</b> <select size="1" name="stypeNo">
					<c:forEach var="stypeVO" items="${stypeSvc.all}">
						<option value="${stypeVO.stypeNo}">${stypeVO.stypeNo}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/stype/stype.do">
				<b>選擇功能編號:</b> <select size="1" name="stypeNo">
					<c:forEach var="stypeVO" items="${stypeSvc.all}">
						<option value="${stypeVO.stypeNo}">${stypeVO.stypeName}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>
	</ul>

	<h3>功能管理</h3>

	<ul>
		<li><a href='addStype.jsp'>Add</a> a new Stype.</li>
	</ul>
	
	
	
	

</body>
</html>