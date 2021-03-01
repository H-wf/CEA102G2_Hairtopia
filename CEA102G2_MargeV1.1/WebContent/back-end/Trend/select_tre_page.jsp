<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<title>Trend :Home</title>
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
		<tr><td><h3>Hairtopia Trend: Home</h3><h4>( MVC )</h4></td></tr>
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
		<li><a href='listAll_tre.jsp'>List</a> all Staffs. <br> <br></li>
		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/trend/trend.do">
				<b>輸入風格誌編號:</b> <input type="text" name="treNo"> <input
					type="hidden" name="action" value="getOne_For_Display"> <input
					type="submit" value="送出">
			</FORM>
		</li>

		<jsp:useBean id="treSvc" scope="page"
			class="com.trend.model.TrendService" />


		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/trend/trend.do">
				<b>選擇風格誌編號:</b> <select size="1" name="treNo">
					<c:forEach var="treVO" items="${treSvc.all}">
						<option value="${treVO.treNo}">${treVO.treNo}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/trend/trend.do">
				<b>選擇風格誌標題:</b> <select size="1" name="treNo">
					<c:forEach var="treVO" items="${treSvc.all}">
						<option value="${treVO.treNo}">${treVO.treTitle}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>
	</ul>

	<h3>風格誌管理</h3>

	<ul>
		<li><a href='addTre.jsp'>Add</a> a new Staff.</li>
	</ul>
	
	
	
	

</body>
</html>