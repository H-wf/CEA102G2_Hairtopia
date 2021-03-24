<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.rule.model.*"%>

<% RuleVO ruleVO = (RuleVO) request.getAttribute("ruleVO");%>


<html>
<head>
<meta charset="UTF-8">
<title>條款資料修改</title>
</head>
<body>
<form METHOD="POST" ACTION="<%=request.getContextPath()%>/rule/rule.do" name="form1" enctype="multipart/form-data"> 
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<p class="lead mb-0">條款編號:<i>${ruleVO.ruleNo}</i></p>
	<p class="lead mb-0">條款名稱:</p>
	<input required class="mb-3 mt-0" type="TEXT" name="ruleName" size="45" value="${ruleVO.ruleName}" />
	<p class="lead mb-0">條款內容:</p>
	<textarea required class="mb-3 mt-0" name="ruleCon" cols="30" rows="10">${ruleVO.ruleCon}</textarea>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		<input type="submit" class="btn btn-primary" value="修改">
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="ruleNo" value="${ruleVO.ruleNo}">
	</div>
</form>
<!-- <table id="table-1"> -->
<!-- 	<tr><td> -->
<!-- 		 <h3>條款資料修改 - update_rule_input.jsp</h3> -->
<!-- 		 <h4><a -->
<%-- 				href="<%=request.getContextPath()%>/back-end/rule/select_rule_page.jsp"><img --%>
<%-- 					src="<%=request.getContextPath()%>/resource/images/back1.gif" --%>
<!-- 					width="100" height="32" border="0">回首頁</a></td> -->
<!-- 	</td></tr> -->
<!-- </table> -->

<!-- <h3>資料修改:</h3> -->

 <%-- 錯誤表列 --%> 
<%-- <c:if test="${not empty errorMsgs}"> --%>
<!-- 	<font style="color:red">請修正以下錯誤:</font> -->
<!-- 	<ul> -->
<%-- 		<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 			<li style="color:red">${message}</li> --%>
<%-- 		</c:forEach> --%>
<!-- 	</ul> -->
<%-- </c:if> --%>

<%-- <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/rule/rule.do" name="form1"> --%>
<!-- <table> -->
<!-- 	<tr> -->
<!-- 		<td>條款編號:<font color=red><b>*</b></font></td> -->
<%-- 		<td>${ruleVO.ruleNo}</td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>條款標題:</td> -->
<%-- 		<td><input type="TEXT" name="ruleName" size="45" value="${ruleVO.ruleName}" /></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>條款內容:</td> -->
<%-- 		<td><input type="TEXT" name="ruleCon" size="45"	value="${ruleVO.ruleCon}" /></td> --%>
<!-- 	</tr> -->
	

<!-- </table> -->
<!-- <br> -->
<!-- <input type="hidden" name="action" value="update"> -->
<%-- <input type="hidden" name="ruleNo"  value="${ruleVO.ruleNo}"> --%>
<%-- <input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用--> --%>
<%-- <input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:istAllEmp.jsp--> --%>
<!-- <input type="submit" value="送出修改"></FORM> -->

</body>

</html>