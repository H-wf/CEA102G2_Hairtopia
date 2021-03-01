<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.service.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  ServiceVO serviceVO = (ServiceVO) request.getAttribute("serviceVO"); //ServiceServlet.java(Concroller), 存入req的serviceVO物件
%>

<html>
<head>
<title>服務資料 - listOneService.jsp</title>


</head>
<body bgcolor='white'>

<h3>服務資料 - ListOneService.jsp</h3>
<h4><a href="select_service_page.jsp">回首頁</a></h4>


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
	</table>
</body>
</html>