<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.service.model.*"%>
<%@ page import="com.designer.model.*"%>

<jsp:useBean id="stypeSvc" scope="page" class="com.sertype.model.StypeService" />
<%
  ServiceVO serviceVO = (ServiceVO) request.getAttribute("serviceVO"); 
  DesignerVO designerVO = (DesignerVO) request.getAttribute("designerVO"); 
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>服務資料修改 - update_service_input.jsp</title>

</head>
<body>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/service/service.do" name="form1">

	<div class="form-group">
	服務類別:
	<select name="stypeNo" class="custom-select">
	<c:forEach var="stypeVO" items="${stypeSvc.all}">
	  	<option value="${stypeVO.stypeNo}" ${(stypeVO.stypeNo==serviceVO.stypeNo)?'selected':''}>${stypeVO.stypeName}</option>
	</c:forEach>
	</select>
	</div>
	<div class="form-group">
	  	服務名稱:
	<input type="TEXT" name="serName" class="form-control"
		value="<%= (serviceVO==null)? "" : serviceVO.getSerName()%>" />
	</div>
	<div class="form-group">
		服務金額:
	<input type="TEXT" name="serPrice" class="form-control"
		value="<%= (serviceVO==null)? "" : serviceVO.getSerPrice()%>" />
	</div>
	<div class="form-group">
		服務時長:
	<select name="serTime" class="custom-select">
	<c:forEach var="serTime" begin="1" end="10">
	<fmt:formatNumber type="number" value="${((serTime*30 -(serTime*30%60)))/60}"  var="hour"/>
	<option value="${serTime}" ${(serviceVO.serTime==serTime)? 'selected':'' } >
	<c:if test="${hour>0}">${hour}小時</c:if>
		${(serTime*30 %60 == 0)? "" :"30分" }
	</c:forEach>
	</select>
	</div>
	<div class="form-group">
		服務描述:
		<textarea name="serDesc" class="form-control"><%= (serviceVO==null)? "" : serviceVO.getSerDesc()%></textarea><br>
	</div>
		<input type="hidden" name="desNo" value="${serviceVO.desNo}">
		<input type="hidden" name="serNo" value="${serviceVO.serNo}">
		<input type="hidden" name="action" value="update">
		<input type="submit" value="修改完成" class="btn btn-primary">
	  			
	 </FORM>
</body>


        

</html>