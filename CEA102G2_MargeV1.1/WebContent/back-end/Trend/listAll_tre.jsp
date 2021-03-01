<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.trend.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	TrendService treSvc2 = new TrendService();
	List<TrendVO> list = treSvc2.getAll();
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
<style>
.line-limit-length {

overflow: hidden;

text-overflow: ellipsis;

white-space: nowrap; //文字不換行,這樣超出一行的部分被擷取,顯示...

}


</style>
<title>所有風格誌資料 - listAll_tre.jsp</title>
</head>
<body>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有風格誌資料 - listAll_tre.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Trend/select_tre_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>


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
			<th>風格誌編號</th>
			<th>風格誌標題</th>
			<th>風格誌內文</th>
			<th>上傳時間</th>
			

		</tr>
	
		<jsp:useBean id="treSvc" scope="page"
			class="com.trend.model.TrendService" />

		<%@ include file="/resource/pages/page1.file" %> 
		<c:forEach var="treVO" items="${treSvc.all}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">>
			<tr>
				<td>${treVO.treNo}</td>
				<td>${treVO.treTitle}</td>
				<td class="line-limit-length" title="${treVO.treCon}"  style="max-width: 250px;overflow: 
				hidden; text-overflow:ellipsis;white-space: nowrap">
					${treVO.treCon}
				</td> 
				<td><fmt:formatDate value="${treVO.treTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/trend/trend.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改"> <input type="hidden"
							name="treNo" value="${treVO.treNo}"> <input
							type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/trend/trend.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="treNo" value="${treVO.treNo}"> <input
							type="hidden" name="action" value="delete">
					</FORM>
				</td>
			</tr>

		</c:forEach>




	</table>
<%@ include file="/resource/pages/page2.file" %>

</body>
</html>