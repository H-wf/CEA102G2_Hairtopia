<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.schedule.model.*"%>


<%
  ScheduleVO schVO = (ScheduleVO) request.getAttribute("schVO");
%>


<!DOCTYPE html>
<html>
<head>

<title>設計師班表上傳 - check_DailySchedule.jsp</title>
</head>
<body>


	<table id="table-1">
		<tr>
			<td>
				<h3>設計師班表上傳 - check_DailySchedule.jsp</h3>
			</td>
			<td>
				<h4>
					<a href="<%=request.getContextPath()%>/front-end/Schedule/select_schedule_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/tomcat.png"
						width="100" height="100" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>
	<h3>班表新增:</h3>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	

	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/schedule/schedule.do" name="form1" enctype="application/x-www-form-urlencoded">
		<table>
		<tr>
		<td>設計師編號:</td>
		<td><input type="text" name="desNo" size="20"  value="${schVO.desNo}" disabled/>
		</td>
		</tr>
		<tr>
		<td>班表日期:</td>
		<td><input name="schDate"  type="text" value="${schVO.schDate}" disabled></td>
	</tr>
		<c:forEach var="myData" begin="0" end="47">
		<tr><th><fmt:formatNumber type="number" value="${((myData*30 -(myData*30%60)))/60}"  var="num"/>
				${num}:${(myData*30 %60 == 0)? "00" :"30" }
		<c:set var="status" value="${schVO.schStatus}"/>
		<c:choose>
				 <c:when test='${status.charAt(myData).toString().equals("1")}'>
			<td><input  class="test" type="radio" name="isOnDuty${myData}" value="1" checked>free
                <input  class="test" type="radio" name="isOnDuty${myData}" value="2">busy<br></td>
				</c:when>
					 <c:when test='${status.charAt(myData).toString().equals("2")}'>
			<td><input  class="test" type="radio" name="isOnDuty${myData}" value="1" >free
                <input  class="test" type="radio" name="isOnDuty${myData}" value="2" checked>busy<br></td>
				</c:when>		
		</c:choose>
		</tr>
		</c:forEach>
		
	</table>
	<input name="action" value="update" type="hidden" >
		<input type="submit" value="修改" class="login_btn">
		<input id ="schStatus" name="schStatus" type="hidden" value="1">
		<input  name="schNo" type="hidden" value="${schVO.schNo}">
		<input  name="desNo" type="hidden" value="${schVO.desNo}">
		<input  name="schDate" type="hidden" value="${schVO.schDate}">
	</form>	
	
		


</body>

<%--  <%   --%>

<%-- %> --%>



<!-- 	這邊使用JS將radio的值串接成字串傳回servlet -->
	<script type="text/javascript">
	var form = document.forms[0]
		let inputBtn = document.getElementsByClassName("test");
		let xx =document.getElementById("schStatus");
		let str ="";
		form.onsubmit = function() {
		for(let i = 0;i <inputBtn.length; i++){
			if(inputBtn[i].checked){
			str += inputBtn[i].value
			}
		}
		if(xx.value != ""){
			xx.value=str
			
			}
		
		}
	
	
	
	</script>
</html>