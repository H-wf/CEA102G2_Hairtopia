<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.trend.model.*"%>

<%
	TrendVO treVO = (TrendVO) request.getAttribute("treVO");
%>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath()%>/resource/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
	window.onload=function () {

		CKEDITOR.replace('content');
		
	}
	
</script>

<title>風格誌新增 - addTre.jsp</title>
</head>
<body>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>風格誌新增 - addTre.jsp</h3>
			</td>
			<td>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/Trend/select_tre_page.jsp">
						<img
						src="<%=request.getContextPath()%>/resource/images//tomcat.png"
						width="100" height="100" border="0">回首頁
					</a>
				</h4>
			</td>
		</tr>
	</table>
	<h3>資料新增:</h3>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>



	<form METHOD="POST"
		ACTION="<%=request.getContextPath()%>/trend/trend.do" name="form1"
		enctype="application/x-www-form-urlencoded">
		<table>
			<tr>
				<td>風格誌標題:</td>
				<td><input type="TEXT" name="treTitle" size="45"
					value="<%=(treVO == null) ? "" : treVO.getTreTitle()%>" /></td>

			</tr>
			<tr>
				<td>上傳時間:</td>
				<td><input name="treTime" id="f_date1" type="text"></td>
			</tr>
			<tr>
				<td>風格誌內文:</td>
				<td><textarea id='content' row="10" cols="48" name="treCon"
						size="45"><%=(treVO == null) ? "" : treVO.getTreCon()%></textarea>
				</td>
			</tr>
		</table>
		<br> <input name="action" value="insert" type="hidden">
		<input type="submit" value="新增" onclick="processData()">

	</form>





</body>


<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resource/datetimepicker/jquery.datetimepicker.css" />
<script
	src="<%=request.getContextPath()%>/resource/datetimepicker/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/resource/datetimepicker/jquery.datetimepicker.full.js"></script>
<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>
<script>
	function processData() {
	// getting data
		var data = CKEDITOR.instances.content.getData()
		form.submit();
		}
	
	$.datetimepicker.setLocale('zh');
    $('#f_date1').datetimepicker({
	       theme: 'dark',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: '<%="treTime"%>',  // value:   new Date(),
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	//minDate:               '-1970-01-01', // 去除今日(不含)之前
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});
</script>
</html>