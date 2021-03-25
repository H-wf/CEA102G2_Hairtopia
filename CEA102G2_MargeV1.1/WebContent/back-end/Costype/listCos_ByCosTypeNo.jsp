<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.cos.model.*"%>

<jsp:useBean id="listCos_ByCosTypeNo" scope="request" type="java.util.Set<CosVO>" />
<jsp:useBean id="costypeSvc" scope="page" class="com.coutype.model.CostypeService" />


<html>
<head><title>�C�X�t���Y�ҵ{�s�����ҵ{�M�� - listCos_ByCosTypeNo.jsp</title>

<style>
  table#table-2 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-2 h4 {
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

<table id="table-2">
	<tr><td>
		 <h3>�C�X�t���Y�ҵ{�s�����ҵ{�M�� - listCos_ByCosTypeNo.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/Cos/select_cos_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">�^��x�D��</a></h4>	</td></tr>
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

<table style="width: 100%">
	<tr>
		<th>�ҵ{�s��</th>
		<th>���v�s��</th>
		<th>�ҵ{���O�s��</th>
		<th>�W�Ұ_</th>
		<th>�W�Ҩ�</th>
		<th>�ҵ{����</th>
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
		<th>�ק�</th>
		<th>�R��</th>
	</tr>
	
	<c:forEach var="cosVO" items="${listCos_ByCosTypeNo}" >
		<tr ${(cosVO.cosNo==param.cosNo) ? 'bgcolor=#CCCCFF':''}><!--�N�ק諸���@���[�J����-->
			<td>${cosVO.lecNo}</td>
			<td>${cosVO.cosTypeNo}</td>
			<td><c:forEach var="costypeVO" items="${costypeSvc.all}">
                    <c:if test="${cosVO.cosTypeNo==costypeVO.cosTypeNo}">
	                    ${costypeVO.cosTypeNo}�i<font color=orange>${costypeVO.cosTypeName}</font> - ${costypeVO.cosTypeIntro}�j
                    </c:if>
                </c:forEach>
			</td>
			<td><fmt:formatDate value="${cosVO.cosFrom}" type="both"/></td>
			<td><fmt:formatDate value="${cosVO.cosTo}" type="both"/></td>
			<td>${cosVO.cosIntro}</td>
			<td>${cosVO.cosAdd}</td>
			<td>${cosVO.cosCount}</td>
			<td>${cosVO.cosRate}</td>
			<td>${cosVO.cosStatus}</td>
			<td>${cosVO.cosMinCount}</td>
			<td>${cosVO.cosMaxCount}</td>
			<td>${cosVO.cosPrice}</td>
			<td><fmt:formatDate value="${cosVO.cosApplyFrom}" type="both"/></td>
			<td><fmt:formatDate value="${cosVO.cosApplyTo}" type="both"/></td>
			<td>${cosVO.cosName}</td>			
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" style="margin-bottom: 0px;">
			    <input type="submit" value="�ק�"> 
			    <input type="hidden" name="cosNo"      value="${cosVO.cosNo}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller--><!-- �ثe�|���Ψ�  -->
			    <input type="hidden" name="action"	   value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" style="margin-bottom: 0px;">
			    <input type="submit" value="�R��">
			    <input type="hidden" name="cosNo"      value="${cosVO.cosNo}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			    <input type="hidden" name="action"     value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

<br>�����������|:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>