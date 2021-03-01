<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cos.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
    CosService cosSvc = new CosService();
    List<CosVO> list = cosSvc.getAllCosApplyFrom();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>�Ҧ��{�s�ҵ{��� - listAllCosApplyFrom.jsp</title>

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
	width: 800px;
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

<h4>�����m�߱ĥ� EL ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>�Ҧ��{�s�ҵ{��� - listAllCosApplyFrom.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/Cos/select_cos_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

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
	
	<%
			for (CosVO cosVO : list) {
				byte[] cosPic = cosVO.getCosPic();
				Base64.Encoder encoder = Base64.getEncoder();
				String src = "data:image/jpeg;base64,";
				if (cosPic != null){
					src += encoder.encodeToString(cosPic);
					
					
				}else{
					src="/back-end/resource/images/back1.gif";
				}
			}
		%>
	
	<%@ include file="/back-end/pages/page1.file"%> 
	<c:forEach var="cosVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${cosVO.getCosNo()}</td>
			<td>${cosVO.getLecNo()}</td>
			<td>${cosVO.getCosTypeNo()}</td>
			<td><fmt:formatDate value="${cosVO.getCosFrom()}" pattern="yyyy-MM-dd HH:mm:ss.SSSZ"/></td>
			<td><fmt:formatDate value="${cosVO.getCosTo()}" pattern="yyyy-MM-dd HH:mm:ss.SSSZ"/></td>
			<td>${cosVO.getCosIntro()}</td>
			<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=course&column=cosPic&idname=cosNo&id=${cosVO.cosNo}" alt='�S���Ϥ�' /></td>
			<td>${cosVO.getCosAdd()}</td>
			<td>${cosVO.getCosCount()}</td>
			<td>${cosVO.getCosRate()}</td>
			<td>${cosVO.getCosStatus()}</td>
			<td>${cosVO.getCosMinCount()}</td>
			<td>${cosVO.getCosMaxCount()}</td>
			<td>${cosVO.getCosPrice()}</td>
			<td><fmt:formatDate value="${cosVO.getCosApplyFrom()}" pattern="yyyy-MM-dd HH:mm:ss.SSSZ"/></td>
			<td><fmt:formatDate value="${cosVO.getCosApplyTo()}" pattern="yyyy-MM-dd HH:mm:ss.SSSZ"/></td>
			<td>${cosVO.getCosName()}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" style="margin-bottom: 0px;" >
			     <input type="submit" value="���W">
			     <input type="hidden" name="cosNo"  value="${cosVO.getCosNo()}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�R��">
			     <input type="hidden" name="cosNo"  value="${cosVO.getCosNo()}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="/back-end/pages/page2.file" %>

</body>
</html>