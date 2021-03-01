<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.service.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    ServiceService serviceSvc = new ServiceService();
    ServiceVO serviceVO = (ServiceVO)request.getAttribute("serviceVO");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>設計師服務資料 - listAllSerByDesNo.jsp</title>
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
	
	<h2>設計師名稱</h2>
	<jsp:useBean id="designerSvc" scope="page" class="com.designer.model.DesignerService" />
	 ${designerSvc.getOneDesByDesNo(param.desNo).desName}
	<table>
		<tr>
			
			<th>服務編號</th>
			<th>服務類別</th>
			<th>服務名稱</th>
			<th>服務金額</th>
			<th>服務時長</th>
			<th>服務描述</th>
			<th>服務狀態</th>
			<th>修改</th>
			<th>刪除</th>
		</tr>
	
	<jsp:useBean id="stypeSvc" scope="page" class="com.sertype.model.StypeService" />

		<c:forEach var="serviceVO" items="${list}">
			<tr>
			
				<td>${serviceVO.serNo}</td>
				<td>
					<c:forEach var="stypeVO" items="${stypeSvc.all}">
                    <c:if test="${serviceVO.stypeNo==stypeVO.stypeNo}">
	                    ${stypeVO.stypeNo}-${stypeVO.stypeName}
                    </c:if>
        			</c:forEach>
				</td>
				<td>${serviceVO.serName}</td>
				<td>${serviceVO.serPrice}</td>
				<td>
					<c:set var="serTime" value="${serviceVO.serTime}"/>
					<fmt:formatNumber type="number" value="${((serTime*30 -(serTime*30%60)))/60}"  var="hour"/>
					<c:if test="${hour>0}">${hour}小時</c:if>${(serTime*30 %60 == 0)? "" :"30分" }
				</td>
				<td>${serviceVO.serDesc}</td>
				<td>
				服務上下架待寫
				</td>
				<td>
				 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/service/service.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改"> 
			     <input type="hidden" name="serNo"      value="${serviceVO.serNo}">
			     <input type="hidden" name="action"	    value="getOne_For_Update"></FORM>
				</td>
				<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/service/service.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="serNo"      value="${serviceVO.serNo}">
			     <input type="hidden" name="desNo"      value="${serviceVO.desNo}">
			     <input type="hidden" name="action"     value="delete"></FORM>
			</td>
				
			
			</tr>
		</c:forEach>
	</table>
</body>
</html>