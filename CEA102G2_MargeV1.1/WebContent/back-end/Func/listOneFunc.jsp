<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.func.model.*"%>
<%@ page import="java.util.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	FuncVO funcVO = (FuncVO) request.getAttribute("funcVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>
<html>
<head>
<style>
img {
	width: 150px;
}
</style>

<title>講師資料 - listOneFunc.jsp</title>
</head>
<body bgcolor='white'>

	
	<table id="table-1">
		<tr>
			<td>
				<h3>功能資料 - ListOneFunc.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Func/select_func_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>功能編號</th>
			<th>功能名稱</th>
			
			
				
		</tr>
		<tr> 
			<td>${funcVO.funcNo}</td>
			<td>${funcVO.funcName}</td>
		
		</tr>


	</table>

</body>
</html>