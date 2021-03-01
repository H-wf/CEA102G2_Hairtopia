<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.cos.model.*"%>

<%
  CosVO cosVO = (CosVO) request.getAttribute("cosVO"); 
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>課程資料修改 - update_cos_input.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
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

<style>
  table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>課程資料修改 - update_cos_input.jsp</h3>
		 <h4><a href="<%= request.getContextPath()%>/back-end/Cos/select_cos_page.jsp"><img src="<%= request.getContextPath()%>/resource/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正~~以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>課程編號:<font color=red><b>*</b></font></td>
		<td><%=cosVO.getCosNo()%></td>
	</tr>
	<tr>
		<td>講師編號:</td>
		<td><input type="TEXT" name="lecNo" size="45" value="<%=cosVO.getLecNo()%>" /></td>
	</tr>
	<tr>
		<td>課程類別編號:</td>
		<td><input type="TEXT" name="cosTypeNo" size="45" value="<%=cosVO.getCosTypeNo()%>" /></td>
	</tr>
	<tr>
		<td>上課起:</td>
		<td><input name="cosFrom" id="f_date1" type="text"></td>
	</tr>
	<tr>
		<td>上課迄:</td>
		<td><input name="cosTo" id="f_date2" type="text"></td>
	</tr>
	<tr>
		<td>課程介紹:</td>
		<td><input type="TEXT" name="cosIntro" size="45" value="<%=cosVO.getCosIntro()%>" /></td>
	</tr>
	<tr>
		<td>課程圖片:</td>
		<td><input type="file" name="upfile1" id="myFile"></td>
	</tr>
	<tr>
		<td>課程地址:</td>
		<td><input type="TEXT" name="cosAdd" size="45" value="<%=cosVO.getCosAdd()%>" /></td>
	</tr>
	<tr>
		<td>報名總人數:</td>
		<td><input type="TEXT" name="cosCount" size="45" value="<%=cosVO.getCosCount()%>" /></td>
	</tr>
	<tr>
		<td>評價總分數:</td>
		<td><input type="TEXT" name="cosRate" size="45" value="<%=cosVO.getCosRate()%>"/></td>
	</tr>
	<tr>
		<td>課程狀態:</td>
		<td><input type="TEXT" name="cosStatus" size="45" value="<%=cosVO.getCosStatus()%>" /></td>
	</tr>
	
	
	<tr>
		<td>最低人數:</td>
		<td><input type="TEXT" name="cosMinCount" size="45" value="<%=cosVO.getCosMinCount()%>" /></td>
	</tr>
	<tr>
		<td>最高人數:</td>
		<td><input type="TEXT" name="cosMaxCount" size="45" value="<%=cosVO.getCosMaxCount()%>" /></td>
	</tr>
	<tr>
		<td>課程價格:</td>
		<td><input type="TEXT" name="cosPrice" size="45" value="<%=cosVO.getCosPrice()%>" /></td>
	</tr>
	<tr>
		<td>報名開始日:</td>
		<td><input name="cosApplyFrom" id="f_date3" type="text"></td>
	</tr>
	<tr>
		<td>報名截止日:</td>
		<td><input name="cosApplyTo" id="f_date4" type="text"></td>
	</tr>
	<tr>
		<td>課程名稱:</td>
		<td><input type="TEXT" name="cosName" size="45" value="<%=cosVO.getCosName()%>" /></td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="cosNo" value="<%=cosVO.getCosNo()%>"> <%-- 真正送出修改處 --%>
<input type="submit" value="送出修改"></FORM>
</body>


<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

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
 	       timepicker:true,       //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
 		   value: '<%=cosVO.getCosFrom()%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        $('#f_date2').datetimepicker({
            theme: '',
  	       timepicker:true,
  	       step: 1,
  	       format:'Y-m-d H:i:s',
  		   value: '<%=cosVO.getCosTo()%>',
  		   });
        $('#f_date3').datetimepicker({
            theme: '',
  	       timepicker:true,
  	       step: 1,
  	       format:'Y-m-d H:i:s',
  		   value: '<%=cosVO.getCosTo()%>',
  		   });
        $('#f_date4').datetimepicker({
            theme: '',
  	       timepicker:true,
  	       step: 1,
  	       format:'Y-m-d H:i:s',
  		   value: '<%=cosVO.getCosTo()%>',
  		   });

</script>   
</html>       