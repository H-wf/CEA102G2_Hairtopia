<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.reservation.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>
	<jsp:useBean id="designerSvc" scope="page" class="com.designer.model.DesignerService" />
	<jsp:useBean id="serviceSvc" scope="page" class="com.service.model.ServiceService" />
	<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService" />
<%
  ResVO resVO = (ResVO) request.getAttribute("resVO"); //ResServlet.java(Concroller), 存入req的serviceVO物件
%>

<html>
<head>
<title>預約資料 - listOneResOfDes.jsp</title>
</head>
<body>
<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

<table class="table table-striped">
	<tr><th>預約編號</th><td>${resVO.resNo}</td></tr>
	<tr><th>預約會員</th><td>${memSvc.getOneMemName(resVO.memNo)}</td></tr>
	<tr><th>服務項目</th>
		<td><c:forEach var="serviceVO" items="${serviceSvc.all}">
				<c:if test="${serviceVO.serNo==resVO.serNo}">
	            	${serviceVO.serName}
            	</c:if>
			</c:forEach>
		</td></tr>
	
	<tr><th>下訂時間</th>
		<td><fmt:formatDate value="${resVO.resProDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
		</td></tr>	
	<tr><th>預約時間</th>
		<td>
			<c:forEach var="serviceVO" items="${serviceSvc.all}">
				<c:if test="${serviceVO.serNo==resVO.serNo}">
	            	<c:set var="serPeriod" value="${serviceVO.serTime}"/>
            	</c:if>
			</c:forEach>
			<fmt:formatDate value="${resVO.resDate}" pattern="yyyy-MM-dd"/>
				<c:set var="startTime" value="${resVO.resTime}"/>
				<c:set var="endTime" value="${startTime+serPeriod}"/>
				<fmt:formatNumber type="number" value="${((startTime*30 -(startTime*30%60)))/60}"  var="shour"/>
				<fmt:formatNumber type="number" value="${((endTime*30 -(endTime*30%60)))/60}"  var="ehour"/>
				${shour}:${(startTime*30 %60 == 0)? "00" :"30" }~${ehour}:${(endTime*30 %60 == 0)? "00" :"30" }
		</td></tr>
	<tr><th>預約評價</th>
		<td><c:if test="${resVO.resCom != 0}">
			<c:forEach var="star" begin="1" end="5">
				<c:choose>
					<c:when test="${resVO.resCom>=star}"	>
						&#x2605;
					</c:when>
					<c:otherwise>
						&#x2606;
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</c:if></td></tr>
	<tr><th>驗證碼</th>
		<td>
		<c:choose>
				<c:when test="${resVO.resStatus == 0}">
					預約待確認
				</c:when>
				<c:when test="${resVO.resStatus == 1}">
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" style="margin-bottom: 0px;">
			    		<input type="text" name="resCode"  placeholder="輸入驗證碼" size="5">
			    		<input type="submit" value="驗證">
			    		<input type="hidden" name="resNo"  value="${resVO.resNo}">
			    		<input type="hidden" name="action" value="resCodeVerify"></FORM>
				</c:when>
				<c:when test="${resVO.resStatus == 2}">
				已到店認證
				</c:when>
				<c:when test="${resVO.resStatus == 3}">
				服務已完成
				</c:when>
				<c:when test="${resVO.resStatus == 4}">
				您取消預約
				</c:when>
				<c:when test="${resVO.resStatus == 5}">
				會員已取消
				</c:when>
				<c:otherwise>
				會員未到
				</c:otherwise>
			</c:choose>
		</td>
		</tr>
	<tr><th>預約金額</th><td>${resVO.resPrice}</td></tr>
	
			
</table>
</body>
</html>