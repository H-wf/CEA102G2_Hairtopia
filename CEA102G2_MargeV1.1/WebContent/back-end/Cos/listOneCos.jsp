<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.cos.model.*"%>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
  CosVO cosVO = (CosVO) request.getAttribute("cosVO");
%>

<html>
<head>
<title>�ҵ{��� - listOneCos.jsp</title>

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
		 <h3>���u��� - listOneCos.jsp</h3>
		 <h4><a href="<%= request.getContextPath()%>/back-end/Cos/select_cos_page.jsp"><img src="<%= request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>�ҵ{�s��</th>
		<th>���v�s��</th>
		<th>�ҵ{���O�s��</th>
		<th>�W�Ұ_</th>
		<th>�W�Ҩ�</th>
		<th>�ҵ{����</th>
		<th>�ҵ{�Ϥ�</th>
		<th>�ҵ{�a�}</th>
		<th>���W�`�H��</th>
		<th>�����`����</th>
		<th>�ҵ{���A</th>
		<th>�̧C�H��</th>
		<th>�̰��H��</th>
		<th>�ҵ{����</th>
		<th>���W�}�l��</th>
		<th>���W�I���</th>
		<th>�ҵ{�W��</th>
	</tr>
	
	<tr>
		<td><%=cosVO.getCosNo()%></td>
		<td><%=cosVO.getLecNo()%></td>
		<td><%=cosVO.getCosTypeNo()%></td>
		<td><%=cosVO.getCosFrom()%></td>
		<td><%=cosVO.getCosTo()%></td>
		<td><%=cosVO.getCosIntro()%></td>
			<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=course&column=cosPic&idname=cosNo&id=${cosVO.cosNo}" alt='�S���Ϥ�' /></td>
		<td><%=cosVO.getCosAdd()%></td>
		<td><%=cosVO.getCosCount()%></td>
		<td><%=cosVO.getCosRate()%></td>
		<td><%=cosVO.getCosStatus()%></td>
		<td><%=cosVO.getCosMinCount()%></td>
		<td><%=cosVO.getCosMaxCount()%></td>
		<td><%=cosVO.getCosPrice()%></td>
		<td><%=cosVO.getCosApplyFrom()%></td>
		<td><%=cosVO.getCosApplyTo()%></td>
		<td><%=cosVO.getCosName()%></td>
	</tr>
</table>

</body>
</html>