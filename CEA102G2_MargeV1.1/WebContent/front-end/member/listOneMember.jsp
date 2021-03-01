<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.member.model.*"%>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%-- <% --%>
<!--   MemVO memVO = (MemVO) request.getAttribute("memVO"); //EmpServlet.java(Concroller), �s�Jreq��empVO���� -->
<!-- %> -->

<html>
<head>
<title>���u��� - listOneEmp.jsp</title>

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
	width: 100%;
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
.headshot{
	width : 75px;
	height: auto;
}
</style>

</head>
<body bgcolor='white'>

	<h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>���u��� - ListOneEmp.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/member/select_page.jsp"><img
						src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">�^����</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>�|���s��</th>
			<th>�|���m�W</th>
			<th>�ʧO</th>
			<th>�ۤ�</th>
			<th>�H�c</th>
			<th>�K�X</th>
			<th>�q��</th>
			<th>�a�}</th>
			<th>���]�l�B</th>
			<th>���A</th>
			<th>���v�����</th>
			<th>�ҥνX</th>
			<th>�j�Y��</th>
			<th>�ק�</th>
			<th>�R��</th>
		</tr>
		<jsp:useBean id="memVO" scope="request" class="com.member.model.MemVO" />
		<tr>
			<td>${memVO.memNo}</td>
			<td>${memVO.memName}</td>
			<td>${(memVO.memGender == 0	)?"": (memVO.memGender == 1) ? "�k" : "�k"}</td>
			<td>${memVO.memInform}</td>
			<td>${memVO.memEmail}</td>
			<td>${memVO.memPswd}</td>
			<td>${memVO.memPhone}</td>
			<td>${memVO.memAddr}</td>
			<td>${memVO.memBal}</td>
			<td>${(memVO.memStatus == 0	)? "������": (memVO.memStatus == 1) ? "���`" : "���v"}</td>
			<td><fmt:formatDate value="${memVO.memEndDate}" pattern="yyyy-MM-dd" /></td>
			<td>${memVO.memCode}</td>
			<td><img class="headshot"
				src="<%=request.getContextPath()%>/member/showImges.do?memNo=${memVO.memNo}"></td>
		</tr>
	</table>

</body>
</html>