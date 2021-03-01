<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.cos.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:useBean id="listCos_ByCompositeQuery" scope="request" type="java.util.List<CosVO>" /> 
<jsp:useBean id="costypeSvc" scope="page" class="com.coutype.model.CostypeService" />


<html>
<head><title>複合查詢 - listCos_ByCompositeQuery.jsp</title>

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
☆萬用複合查詢  - 可由客戶端 select_page.jsp 隨意增減任何想查詢的欄位<br>
☆此頁作為複合查詢時之結果練習，<font color=red>已增加分頁、送出修改、刪除之功能</font></h4>
<table id="table-1">
	<tr><td>
		 <h3>所有課程明細資料 - listAllCos.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/Cos/select_cos_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>


<table>
	<tr>
		<th>課程編號</th>
		<th>課程名稱</th>
		<th>課程類別</th>
		<th>開課日期</th>
		<th>報名日期</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
<%@ include file="page1_ByCompositeQuery.file" %>	
	<c:forEach var="cosVO" items="${listCos_ByCompositeQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr align='center' valign='middle' ${(cosVO.cosNo==param.cosNo) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色而已-->
			<td>${cosVO.cosNo}</td>
			<td>${cosVO.cosName}</td>	
			<td><c:forEach var="costypeVO" items="${costypeSvc.all}">
                    <c:if test="${cosVO.cosTypeNo==costypeVO.cosTypeNo}">
	                    ${costypeVO.cosTypeNo}【${costypeVO.cosTypeName} - ${costypeVO.cosTypeIntro}】
                    </c:if>
                </c:forEach>
			</td>
			<td><fmt:formatDate value="${cosVO.cosFrom}" pattern="yyyy-MM-dd HH:mm:ss.SSSZ"/></td>
			<td><fmt:formatDate value="${cosVO.cosApplyFrom}" pattern="yyyy-MM-dd HH:mm:ss.SSSZ"/></td>
						
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改"> 
			     <input type="hidden" name="cosNo"      value="${cosVO.cosNo}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"	    value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="cosNo"      value="${cosVO.cosNo}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"     value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2_ByCompositeQuery.file" %>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>