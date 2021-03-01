<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<title>Func :Home</title>
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
		<tr><td><h3>Hairtopia Func: Home</h3><h4>( MVC )</h4></td></tr>
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
		<li><a href='listAll_func.jsp'>List</a> all Functions. <br> <br></li>
		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/func/func.do">
				<b>輸入功能編號:</b> <input type="text" name="funcNo"> <input
					type="hidden" name="action" value="getOne_For_Display"> <input
					type="submit" value="送出">
			</FORM>
		</li>

		<jsp:useBean id="funcSvc" scope="page"
			class="com.func.model.FuncService" />


		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/func/func.do">
				<b>選擇功能編號:</b> <select size="1" name="funcNo">
					<c:forEach var="funcVO" items="${funcSvc.all}">
						<option value="${funcVO.funcNo}">${funcVO.funcNo}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/func/func.do">
				<b>選擇功能編號:</b> <select size="1" name="funcNo">
					<c:forEach var="funcVO" items="${funcSvc.all}">
						<option value="${funcVO.funcNo}">${funcVO.funcName}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>
	</ul>

	<h3>功能管理</h3>

	<ul>
		<li><a href='addFunc.jsp'>Add</a> a new Func.</li>
	</ul>
	
	
	
	

</body>
</html>