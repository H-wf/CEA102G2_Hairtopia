<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.schedule.model.*"%>


<%
  ScheduleVO empVO = (ScheduleVO) request.getAttribute("schVO");
%>


<!DOCTYPE html>
<html>
<head>

<title>設計師班表上傳 - check_DailySchedule.jsp</title>
</head>

<body bgcolor='white'>

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
		<td><input type="text" name="desNo" size="20" />
		</td>
		</tr>
		<tr>
		<td>班表日期:</td>
		<td><input name="schDate" id="f_date1" type="text"></td>
	</tr>
		<c:forEach var="myData" begin="0" end="47">
		<tr><th><fmt:formatNumber type="number" value="${((myData*30 -(myData*30%60)))/60}"  var="num"/>
				${num}:${(myData*30 %60 == 0)? "00" :"30" }
			<td><input  class="test" type="radio" name="isOnDuty${myData}" value="1" checked>free
                <input  class="test" type="radio" name="isOnDuty${myData}" value="2">busy<br>
			
			</td>	 
		</tr>
		</c:forEach>
		
	</table>
	<input name="action" value="insert" type="hidden" >
		<input type="submit" value="新增" class="login_btn">
		<input id ="schStatus" name="schStatus" type="hidden" value="1">
	</form>	
	
		


</body>

<%--  <%   --%>

<%-- %> --%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resource/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/resource/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/resource/datetimepicker/jquery.datetimepicker.full.js"></script>
<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>
<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: 'dark',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%="schDate"%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        }); </script>
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