<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sertype.model.*"%>
<%@ page import="java.util.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	StypeVO stypeVO = (StypeVO) request.getAttribute("stypeVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>
<html>
<head>
<style>
img {
	width: 150px;
}
</style>

<title>講師資料 - listOneStype.jsp</title>
</head>
<body bgcolor='white'>

	
	<table id="table-1">
		<tr>
			<td>
				<h3>功能資料 - ListOneStype.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Stype/select_stype_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>服務類別編號</th>
			<th>服務類別名稱</th>
			
			
				
		</tr>
		<tr> 
			<td>${stypeVO.stypeNo}</td>
			<td>${stypeVO.stypeName}</td>
		
		</tr>


	</table>

</body>
</html>