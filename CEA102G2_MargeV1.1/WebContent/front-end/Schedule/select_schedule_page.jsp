<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>



<title>Schedule:Home</title>
<style>
table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
	border: 3px ridge Gray;
	height: 80px;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>
</head>
<body>



	<table id="table-1">
		<tr><td><h3>Hairtopia Schedule: Home</h3><h4>( MVC )</h4></td></tr>
	</table>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	
	<h3>班表管理</h3>

	<ul>
		<li><a href='check_dailySchedule.jsp'>Add</a> 新增單一班表</li>
		
	</ul>
<%-- 		<jsp:useBean id="desSvc" scope="page" class="com.designer.model.DesignerService" /> --%>
	
		
<form METHOD="POST" ACTION="<%=request.getContextPath()%>/schedule/schedule.do" name="form1" enctype="application/x-www-form-urlencoded">
	<table>
	<tr>
		<td>查詢(修改)設計師單日班表:<font color=red><b>*</b></font></td>
		<tr><td>設計師編號:</td>
		
		<td><input type="text" name="desNo" size="20" />
		</td>
		</tr>
		<tr>
		<td>班表日期:</td>
		<td><input name="schDate" id="f_date1" type="text"></td>
		
	</tr>
	</table>
	
	<input type="hidden" name="action" value="queryByDesNo">
	<input type="submit" value="送出查詢">
</form>	

	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/schedule/schedule.do" name="form1" enctype="application/x-www-form-urlencoded">
	<table>
	<tr>
		<td>查詢設計師多日班表(刪除):<font color=red><b>*</b></font></td>
		<tr><td>設計師編號:</td>
		
		<td><input type="text" name="desNo" size="20" />
		</td>
		</tr>
	</table>
	
	<input type="hidden" name="action" value="querySchedulesByDesNo">
	<input type="submit" value="送出查詢">
</form>	

	
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

</body>

</html>