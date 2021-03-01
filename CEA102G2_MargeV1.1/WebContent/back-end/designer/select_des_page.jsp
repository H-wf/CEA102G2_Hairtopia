<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Designer:Bac-end</title>
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
<body bgcolor='lightblue'>
	<table id="table-1">
		<tr><td><h3>Designer:Bac-end</h3><h4>( MVC )</h4></td></tr>
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
		<li><a href='listAllDesigner.jsp'>List</a> all Lecs. <br> <br></li>
		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/designer/designer.do">
				<b>輸入設計師編號:</b> <input type="text" name="desNo"> <input
					type="hidden" name="action" value="getOne_For_Display_Back"> <input
					type="submit" value="送出">
			</FORM>
		</li>

		<jsp:useBean id="desSvc" scope="page"
			class="com.designer.model.DesignerService" />


		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/designer/designer.do">
				<b>選擇設計師編號:</b> <select size="1" name="desNo">
					<c:forEach var="desVO" items="${desSvc.all}">
						<option value="${desVO.desNo}">${desVO.desNo}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display_Back">
				<input type="submit" value="送出">
			</FORM>
		</li>

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/designer/designer.do">
				<b>選擇設計師姓名:</b> <select size="1" name="desNo">
					<c:forEach var="desVO" items="${desSvc.all}">
						<option value="${desVO.desNo}">${desVO.desName}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display_Back">
				<input type="submit" value="送出">
			</FORM>
		</li>
	</ul>

	
</body>
</html>