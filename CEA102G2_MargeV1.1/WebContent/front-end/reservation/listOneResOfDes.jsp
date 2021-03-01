<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.reservation.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  ResVO resVO = (ResVO) request.getAttribute("resVO"); //ResServlet.java(Concroller), 存入req的serviceVO物件
%>

<html>
<head>
<title>預約資料 - listOneResOfDes.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<h3>服務資料 - ListOneResOfMem.jsp</h3>
	<jsp:useBean id="designerSvc" scope="page" class="com.designer.model.DesignerService" />
	<jsp:useBean id="serviceSvc" scope="page" class="com.service.model.ServiceService" />
<table class="table table-striped">
	<tr><th>預約編號</th><td>${resVO.resNo}</td></tr>
	<tr><th>會員編號</th><td>${resVO.memNo}</td></tr>
	<tr><th>服務項目</th>
		<td><c:forEach var="serviceVO" items="${serviceSvc.all}">
				<c:if test="${serviceVO.serNo==resVO.serNo}">
	            	${serviceVO.serNo}-${serviceVO.serName}
            	</c:if>
			</c:forEach>
		</td></tr>
	<tr><th>設計師</th>
		<td><c:forEach var="designerVO" items="${designerSvc.all}">
					<c:if test="${designerVO.desNo==resVO.desNo}">
	            	${designerVO.desNo}-${designerVO.desName}
            		</c:if>
			</c:forEach>
		</td></tr>
	<tr><th>預約產生日</th>
		<td><fmt:formatDate value="${resVO.resProDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
		</td></tr>	
	<tr><th>預約時間</th>
		<td><fmt:formatDate value="${resVO.resDate}" pattern="yyyy-MM-dd"/>
				<c:set var="serTime" value="${resVO.resTime}"/>
				<fmt:formatNumber type="number" value="${((resTime*30 -(resTime*30%60)))/60}"  var="hour"/>
				${hour}:${(serTime*30 %60 == 0)? "00" :"30" }
		</td></tr>
	<tr><th>預約評價</th><td>${resVO.resCom}</td></tr>
	<tr><th>預約驗證碼</th>
		<td>
		<c:choose>
				<c:when test="${resVO.resStatus == 0}">
				預約待確認
				</c:when>
				<c:when test="${resVO.resStatus == 1}">
				請輸入驗證碼
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do"
	 			 name="form1">
				<input type="TEXT" name="resCode" size="5"/>
				<input type="submit" value="送出">
			    <input type="hidden" name="resNo"  value="${resVO.resNo}">
			    <input type="hidden" name="action"	value="typeResCode">
				</FORM>
				</c:when>
				<c:when test="${resVO.resStatus == 2}">
				已到店認證
				</c:when>
				<c:when test="${resVO.resStatus == 3}">
				服務完成
				</c:when>
				<c:when test="${resVO.resStatus == 4}">
				無法提供服務
				</c:when>
				<c:when test="${resVO.resStatus == 5}">
				會員取消
				</c:when>
				<c:otherwise>
				會員未到
				</c:otherwise>
			</c:choose>
		</td>
		</tr>
	<tr><th>預約金額</th><td>${resVO.resPrice}</td></tr>
	<tr><th>修改</th><td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="serNo"  value="${resVO.serNo}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td></tr>
	<tr><th>刪除</th><td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="resNo"  value="${resVO.serNo}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td></tr>
			
</table>
</body>
</html>