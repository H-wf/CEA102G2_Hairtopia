<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.reservation.model.*"%>

<%
	ResVO resVO = (ResVO)request.getAttribute("resVO");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>預約新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do"
	  name="form1">
<table>
	<tr>
		<td>會員編號:</td>
<%-- 	之後用session取得會員:<%session.getAttribute(); %> --%>
		<td><input type="TEXT" name="memNo" size="3"
			 value="<%= (resVO==null)? "" : resVO.getMemNo()%>" /></td>
	</tr>
	
	<jsp:useBean id="serviceSvc" scope="page" class="com.service.model.ServiceService" />
	<tr>
		<td>服務項目:</td>
		<td><select size="1" name="serNo">
			<c:forEach var="serviceVO" items="${serviceSvc.all}">
				<option value="${serviceVO.serNo}" ${(resVO.serNo==serviceVO.serNo)? 'selected':'' } >
				${serviceVO.serName}-金額${serviceVO.serPrice}
			</c:forEach>
			</select></td>
	</tr>
	
	<tr>
		<td>預約日期:</td>
		<td><input name="resDate" id="f_date1" type="TEXT" ></td>
	</tr>
<!-- 	之後取得預約日期為星期幾，透過desSchedule取出4位數字切成xx和yy，加入c:if判斷式，只顯示xx和yy間的選項 -->
	<tr>
		<td>預約時間:</td>
		<td>
			<select class="time" name="resTime">
					<c:forEach var="whatTime" begin="0" end="47">
					<fmt:formatNumber type="number" value="${((whatTime*30 -(whatTime*30%60)))/60}"  var="hour"/>
					<option value="${whatTime}">${hour}:${(whatTime*30 %60 == 0)? "00" :"30" }
					</c:forEach>
			</select>
		</td>
	</tr>
	
	


</table>
<br>

<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  java.sql.Date resDate = null;
  try {
	    resDate = resVO.getResDate();
   } catch (Exception e) {
	    resDate = new java.sql.Date(System.currentTimeMillis());
   }
%>
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
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=resDate%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        
   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
        //      var somedate1 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});

        
        //      2.以下為某一天之後的日期無法選擇
        //      var somedate2 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>
</html>