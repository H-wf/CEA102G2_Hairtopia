<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coudet.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>課程明細資料 - listOneCosdetail2.jsp</title>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>課程明細資料 - listOneCosdetail2.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/Cos/select_cos_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">回後台主頁</a></h4>
	</td></tr>
</table>



<jsp:useBean id="cosSvc" scope="page"
			class="com.cos.model.CosService" />

	<jsp:useBean id="memSvc" scope="page"
			class="com.member.model.MemService" />

<jsp:useBean id="cosdetSvc" scope="page"
			class="com.coudet.model.CosdetService" />

<table style="width: 100%">
	<tr>
		<th>課程名稱</th>
		<th>會員名稱</th>
		<th>課程評價</th>
		<th>報名課程價格</th>
	</tr>
	<c:forEach var="cosdetVO" items="${cosdetVO}">	
		<tr>
		<td>${cosSvc.findByPrimaryKeyCos(cosdetVO.cosNo).cosName}</td>
		<td>${memSvc.getOneMem(cosdetVO.memNo).memName}</td>
		<td>${cosdetVO.cosComment}</td>
		<td>${cosdetVO.cosDetailPrice}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>