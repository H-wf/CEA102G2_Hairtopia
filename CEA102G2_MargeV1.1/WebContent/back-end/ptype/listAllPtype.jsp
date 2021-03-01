<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ptype.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	PtypeService ptypeSvc = new PtypeService();
	List<PtypeVO> list = ptypeSvc.getAll();
	pageContext.setAttribute("list", list);
%>



<!DOCTYPE html>
<html>
<head>
<style type="text/css">
img {
	width: 150px;
}
</style>
<meta charset="UTF-8">
<title>所有商品類別資料 - listAllPtype.jsp</title>
</head>
<body>
	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有品牌資料 - listAllPtype.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/ptype/select_page.jsp">回首頁</a>
				</h4>
			</td>
		</tr>
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


	<table>
		<tr>
			<th>商品類別編號</th>
			<th>商品類別名稱</th>


		</tr>
		<%
			for (PtypeVO ptypeVO : list) {
				
		%>

		<tr>
			<td><%=ptypeVO.getPtypeNo()%></td>
			<td><%=ptypeVO.getPtypeName()%></td>

			<td>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/ptype/ptype.do"
					style="margin-bottom: 0px;">
					<input type="submit" value="修改"> <input type="hidden"
						name="ptypeNo" value="<%=ptypeVO.getPtypeNo()%>"> <input
						type="hidden" name="action" value="getOne_For_Update">
				</FORM>
			</td>
			<td>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/ptype/ptype.do"
					style="margin-bottom: 0px;">
					<input type="submit" value="刪除"> <input type="hidden"
						name="ptypeNo" value="<%=ptypeVO.getPtypeNo()%>"> <input
						type="hidden" name="action" value="delete">
				</FORM>
			</td>
		</tr>
		<%
			}
		%>


	</table>


</body>
</html>