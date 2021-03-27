<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ptype.model.*"%>

<% PtypeVO ptypeVO = (PtypeVO) request.getAttribute("ptypeVO");%>

<html>
<head>
<meta charset="UTF-8">
<title>商品類別資料修改</title>
</head>
<body>
<form METHOD="POST" ACTION="<%=request.getContextPath()%>/ptype/ptype.do" name="form1" enctype="multipart/form-data"> 
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<p class="lead mb-0"><label>商品類別編號:<i>${ptypeVO.ptypeNo}</i></label></p>
	<p class="lead mb-0"><label for="ptypeName">商品類別名稱:</label></p>
	<input required class="form-control form-control-sm mb-3" style="width:200px;" id="ptypeName" type="TEXT" name="ptypeName" size="45" value="${ptypeVO.ptypeName}" />
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		<input type="submit" class="btn btn-primary" value="修改">
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="ptypeNo" value="${ptypeVO.ptypeNo}">
	</div>
</form>
<!-- 	<table id="table-1"> -->
<!-- 		<tr> -->
<!-- 			<td> -->
<!-- 				<h3>商品類別資料修改 - update_ptype_input.jsp</h3> -->
<!-- 				<h4> -->
<%-- 					<a href="<%=request.getContextPath()%>/back-end/ptype/select_page.jsp">回首頁</a> --%>
<!-- 				</h4> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 	</table> -->

<!-- 	<h3>資料修改:</h3> -->


 	<%-- 錯誤表列 --%>
<%-- 	<c:if test="${not empty errorMsgs}"> --%>
<!-- 		<font style="color: red">請修正以下錯誤:</font> -->
<!-- 		<ul> -->
<%-- 			<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 				<li style="color: red">${message}</li> --%>
<%-- 			</c:forEach> --%>
<!-- 		</ul> -->
<%-- 	</c:if> --%>

<%-- 	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/ptype/ptype.do" name="form1" enctype="multipart/form-data"> --%>
<!-- 		<table> -->
<!-- 			<tr> -->
<!-- 				<td>商品類別編號:<font color=red><b>*</b></font></td> -->
<%-- 				<td><%=ptypeVO.getPtypeNo()%></td> --%>
<%-- 				<td>${param.ptypeNo}</td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>商品類別名稱:</td> -->
<!-- 				<td> -->
<!-- 				<input type="TEXT" name="ptypeName" size="45" -->
<%-- 					value="<%=ptypeVO.getPtypeName()%>" /> --%>
<!-- 				<input type="TEXT" name="ptypeName" size="45" -->
<%-- 					value="${ptypeSvc.getOnePtype(param.ptypeNo).ptypeName}" /> --%>
<!-- 				</td> -->
<!-- 			</tr> -->



<!-- 		</table> -->
	
	
<!-- 	<br> <input type="hidden" name="action" value="update">  -->
<%-- 		 <input type="hidden" name="ptypeNo" value="<%=ptypeVO.getPtypeNo()%>"> --%>
<!-- 		 <input type="submit" value="送出修改"> -->
		
<!-- 	</form> -->

</body>
</html>