<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.brand.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	BrandService braSvc = new BrandService();
	List<BrandVO> list = braSvc.getAll();
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
<title>所有品牌資料 - listAllBrand.jsp</title>
</head>
<body>
	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有品牌資料 - listAllBrand.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/brand/select_page.jsp">回首頁</a>
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
			<th>品牌編號</th>
			<th>品牌名稱</th>
			<th>品牌logo</th>
			<th>品牌介紹</th>

		</tr>
		<%
			for (BrandVO brandVO : list) {
				
		%>

		<tr>
			<td><%=brandVO.getBraNo()%></td>
			<td><%=brandVO.getBraName()%></td>
			<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=brand&column=braLogo&idname=braNo&id=<%=brandVO.getBraNo()%>" alt='沒有圖片' /></td>
			<td><%=brandVO.getBraIntro()%></td>
			<td>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/brand/brand.do"
					style="margin-bottom: 0px;">
					<input type="submit" value="修改"> <input type="hidden"
						name="braNo" value="<%=brandVO.getBraNo()%>"> <input
						type="hidden" name="action" value="getOne_For_Update">
				</FORM>
			</td>
			<td>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/brand/brand.do"
					style="margin-bottom: 0px;">
					<input type="submit" value="刪除"> <input type="hidden"
						name="braNo" value="<%=brandVO.getBraNo()%>"> <input
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