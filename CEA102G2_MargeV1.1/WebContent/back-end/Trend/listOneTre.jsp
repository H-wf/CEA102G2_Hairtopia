<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.trend.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	TrendVO treVO = (TrendVO) request.getAttribute("treVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>
<html>
<head>
<style>
img {
	width: 150px;
}
</style>

<title>風格誌資料 - listOneTre.jsp</title>
</head>
<body bgcolor='white'>

	
	<table id="table-1">
		<tr>
			<td>
				<h3>風格誌資料 - listOneTre.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Trend/select_tre_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images//back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>風格誌編號</th><td>${treVO.treNo}</td>
		</tr>	
		<tr><th>風格誌標題</th><td>${treVO.treTitle}</td>
		</tr>
		<tr>
			<th>上傳時間</th><td><fmt:formatDate value="${treVO.treTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>		
		</tr>
		<tr><th>風格誌內文</th><td style="max-width: 250px;">${treVO.treCon}</td>
		</tr>
		
	


	</table>

</body>
</html>