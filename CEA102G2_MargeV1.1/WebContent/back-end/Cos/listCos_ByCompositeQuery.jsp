<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.cos.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:useBean id="listCos_ByCompositeQuery" scope="request" type="java.util.List<CosVO>" /> 
<jsp:useBean id="costypeSvc" scope="page" class="com.coutype.model.CostypeService" />


<html>
<head><title>�ƦX�d�� - listCos_ByCompositeQuery.jsp</title>

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

<h4>
���U�νƦX�d��  - �i�ѫȤ�� select_page.jsp �H�N�W�����Q�d�ߪ����<br>
�������@���ƦX�d�߮ɤ����G�m�ߡA<font color=red>�w�W�[�����B�e�X�ק�B�R�����\��</font></h4>
<table id="table-1">
	<tr><td>
		 <h3>�Ҧ��ҵ{���Ӹ�� - listAllCos.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/Cos/select_cos_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>


<table>
	<tr>
		<th>�ҵ{�s��</th>
		<th>�ҵ{�W��</th>
		<th>�ҵ{���O</th>
		<th>�}�Ҥ��</th>
		<th>���W���</th>
		<th>�ק�</th>
		<th>�R��</th>
	</tr>
<%@ include file="page1_ByCompositeQuery.file" %>	
	<c:forEach var="cosVO" items="${listCos_ByCompositeQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr align='center' valign='middle' ${(cosVO.cosNo==param.cosNo) ? 'bgcolor=#CCCCFF':''}><!--�N�ק諸���@���[�J����Ӥw-->
			<td>${cosVO.cosNo}</td>
			<td>${cosVO.cosName}</td>	
			<td><c:forEach var="costypeVO" items="${costypeSvc.all}">
                    <c:if test="${cosVO.cosTypeNo==costypeVO.cosTypeNo}">
	                    ${costypeVO.cosTypeNo}�i${costypeVO.cosTypeName} - ${costypeVO.cosTypeIntro}�j
                    </c:if>
                </c:forEach>
			</td>
			<td><fmt:formatDate value="${cosVO.cosFrom}" pattern="yyyy-MM-dd HH:mm:ss.SSSZ"/></td>
			<td><fmt:formatDate value="${cosVO.cosApplyFrom}" pattern="yyyy-MM-dd HH:mm:ss.SSSZ"/></td>
						
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�"> 
			     <input type="hidden" name="cosNo"      value="${cosVO.cosNo}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--�e�X��e�O�ĴX����Controller-->
			     <input type="hidden" name="action"	    value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�R��">
			     <input type="hidden" name="cosNo"      value="${cosVO.cosNo}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--�e�X��e�O�ĴX����Controller-->
			     <input type="hidden" name="action"     value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2_ByCompositeQuery.file" %>

<br>�����������|:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>