<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.cospost.model.*"%>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
  CospostVO cospostVO = (CospostVO) request.getAttribute("cospostVO"); //CosPostServlet.java(Concroller), �s�Jreq��cospostVO����
%>

<html>
<head>
<title>�ҵ{���i��� - listOneCosPost.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
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

<style>
  table {
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>���u��� - listOneCosPost.jsp</h3>
		 <h4><a href="<%= request.getContextPath()%>/back-end/Cospost/select_cospost_page.jsp"><img src="<%= request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>���i�s��</th>
		<th>�ҵ{�s��</th>
		<th>���i���e</th>
		<th>���i�ɶ�</th>
	</tr>
	<tr>
		<td><%=cospostVO.getCosPubNo()%></td>
		<td><%=cospostVO.getCosNo()%></td>
		<td><%=cospostVO.getCosPubCon()%></td>
		<td><%=cospostVO.getCosPubTime()%></td>
	</tr>
</table>

</body>
</html>