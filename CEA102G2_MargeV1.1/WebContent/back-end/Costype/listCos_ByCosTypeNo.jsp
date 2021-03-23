<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.cos.model.*"%>

<jsp:useBean id="listCos_ByCosTypeNo" scope="request" type="java.util.Set<CosVO>" />
<jsp:useBean id="costypeSvc" scope="page" class="com.coutype.model.CostypeService" />


<html>
<head><title>列出含有某課程編號的課程清單 - listCos_ByCosTypeNo.jsp</title>

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
		 <h3>列出含有某課程編號的課程清單 - listCos_ByCosTypeNo.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/Cos/select_cos_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">回後台主頁</a></h4>	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table style="width: 100%">
	<tr>
		<th>課程編號</th>
		<th>講師編號</th>
		<th>課程類別編號</th>
		<th>上課起</th>
		<th>上課迄</th>
		<th>課程介紹</th>
		<th>課程地址</th>
		<th>報名總人數</th>
		<th>評價總分數</th>
		<th>課程狀態</th>
		<th>最低人數</th>
		<th>最高人數</th>
		<th>課程價格</th>
		<th>報名開始日</th>
		<th>報名截止日</th>
		<th>課程名稱</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	
	<c:forEach var="cosVO" items="${listCos_ByCosTypeNo}" >
		<tr ${(cosVO.cosNo==param.cosNo) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色-->
			<td>${cosVO.lecNo}</td>
			<td>${cosVO.cosTypeNo}</td>
			<td><c:forEach var="costypeVO" items="${costypeSvc.all}">
                    <c:if test="${cosVO.cosTypeNo==costypeVO.cosTypeNo}">
	                    ${costypeVO.cosTypeNo}【<font color=orange>${costypeVO.cosTypeName}</font> - ${costypeVO.cosTypeIntro}】
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
			    <input type="submit" value="修改"> 
			    <input type="hidden" name="cosNo"      value="${cosVO.cosNo}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--><!-- 目前尚未用到  -->
			    <input type="hidden" name="action"	   value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" style="margin-bottom: 0px;">
			    <input type="submit" value="刪除">
			    <input type="hidden" name="cosNo"      value="${cosVO.cosNo}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			    <input type="hidden" name="action"     value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>