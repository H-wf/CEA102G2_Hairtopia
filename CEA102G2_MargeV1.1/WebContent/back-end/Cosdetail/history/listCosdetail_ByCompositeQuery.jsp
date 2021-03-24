<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.cos.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head><title>複合查詢 - listCosdetail_ByCompositeQuery.jsp</title>

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

<table id="table-1">
	<tr><td>
		 <h3>所有課程明細資料 - listCosdetail_ByCompositeQuery.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/Cos/select_cos_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>課程編號</th>
		<th>會員編號</th>
		<th>課程評分</th>
		<th>課程價格</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>

	
	<c:forEach var="cosdetVO" items="${listCos_ByCompositeQuery}" >
			<td>${cosdetVO.cosNo}</td>
			<td>${cosdetVO.memNo}</td>
			<td>${cosdetVO.cosComment}</td>
			<td>${cosdetVO.cosDetailPrice}</td>
		</tr>
	</c:forEach>
</table>


<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>
</html>