<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.schedule.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	ScheduleVO schVO = (ScheduleVO) request.getAttribute("schVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>
<html>
<head>
<style>
img {
	width: 150px;
}
</style>

<title>設計師班表資料 - listOneSchdule.jsp</title>
</head>
<body bgcolor='white'>

	
	<table id="table-1">
		<tr>
			<td>
				<h3>設計師班表資料 - listOneSchdule.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/front-end/Schedule/select_schedule_page.jsp">
					<img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table border="1" cellpadding="5" style="border:2px #666 solid;text-align:center;">
		<tr><th colspan="2">設計師編號</th><td>${schVO.desNo}</td> </tr>
		<tr><th colspan="2">班表日期</th><td>${schVO.schDate}</td></tr>
		<tr><th colspan="2">班表資料</th>
			 <td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/schedule/schedule.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改"> 
						<input type="hidden" name="schDate" value="${schVO.schDate}"> 
						<input type="hidden" name="desNo" value="${schVO.desNo}"> 
						<input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
		</tr>
			
		<c:forEach var="myData" begin="0" end="47">
		<tr><th colspan="2"><fmt:formatNumber type="number" value="${((myData*30 -(myData*30%60)))/60}"  var="num"/>
				${num}:${(myData*30 %60 == 0)? "00" :"30" }
			</th>
			<c:set var="status" value="${schVO.schStatus}"/>
			<c:choose>
			<c:when test= '${status.charAt(myData).toString().equals("1")}'>
					<td colspan="2">上班</td>
			 </c:when>
			 <c:when test= '${status.charAt(myData).toString().equals("2")}'>
			 		<td colspan="2">忙碌</td>
			 </c:when>
			 <c:otherwise>
			 		<td colspan="2">未上班</td>
			 </c:otherwise>
			</c:choose>
			   
			
				 
		</tr>
		</c:forEach>
		    

	</table>

</body>
</html>