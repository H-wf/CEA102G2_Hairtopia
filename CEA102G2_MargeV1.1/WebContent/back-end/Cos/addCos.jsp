<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.cos.model.*"%>

<%
  CosVO cosVO = (CosVO) request.getAttribute("cosVO");
%>
 

<!DOCTYPE html>
<html lang="en">

<head>
    <title>新增課程內容</title>
    <meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>

<style>

#mytb{
	font-size:0.6rem;
}

#mytb td{
	height:30%;
}
#table-1 h4{
	color:black; font-family: "Open Sans", Arial, sans-serif;
}

</style>

<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">

<table id="table-1">
	<tr>
	<td><h3>新增課程內容</h3></td>
	<td><h5><a href="<%=request.getContextPath()%>/back-end/Cos/select_cos_page.jsp">回後台主頁</a></h5></td>
	</tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<jsp:useBean id="lecSvc" scope="page" class="com.lecturer.model.LecturerService" />
<jsp:useBean id="costypeSvc" scope="page" class="com.coutype.model.CostypeService"/>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>講師編號:</td>
		<td><select size="1" name="lecNo" >
          <option value="">
         <c:forEach var="LecturerVO" items="${lecSvc.all}" > 
          <option value="${LecturerVO.getLecNo()}">${LecturerVO.getLecName()}
         </c:forEach>
       </select><br></td>
	</tr>
	<tr>
		<td>課程類別編號:</td>
		<td><select size="1" name="cosTypeNo" >
          <option value="">
         <c:forEach var="costypeVO" items="${costypeSvc.all}" > 
          <option value="${costypeVO.getCosTypeNo()}">${costypeVO.getCosTypeName()}
         </c:forEach>
       </select><br></td>
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
		<td><input type="TEXT" name="cosIntro" size="45" value="${cosVO.CosIntro}" /></td>
	</tr>
	<tr>
		<td>課程圖片:</td>
		<td><input type="file" name="upfile1" id="myFile"></td>
	</tr>
	<tr>
		<td>課程地址:</td>
		<td><div id = "twzipcode"></div><input type="TEXT" id="cosAdd" name="cosAdd" size="45" value="${cosVO.CosAdd}" /></td>
	</tr>
	<tr>
		<td>報名總人數:</td>
		<td><input type="TEXT" name="cosCount" size="45" value="${cosVO.CosCount}" /></td>
	</tr>
	<tr>
		<td>評價總分數:</td>
		<td><input type="TEXT" name="cosRate" size="45" value="${cosVO.CosRate}"/></td>
	</tr>
	<tr>
		<td>課程狀態:</td>
		<td><input type="TEXT" name="cosStatus" size="45" value="${cosVO.CosStatus}" /></td>
	</tr>
	<tr>
		<td>最低人數:</td>
		<td><input type="TEXT" name="cosMinCount" size="45" value="${cosVO.CosMinCount}" /></td>
	</tr>
	<tr>
		<td>最高人數:</td>
		<td><input type="TEXT" name="cosMaxCount" size="45" value="${cosVO.CosMaxCount}" /></td>
	</tr>
	<tr>
		<td>課程價格:</td>
		<td><input type="TEXT" name="cosPrice" size="45" value="${cosVO.CosPrice}" /></td>
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
		<td><input type="TEXT" name="cosName" size="45" value="${cosVO.CosName}" /></td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resource/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/resource/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/resource/datetimepicker/jquery.datetimepicker.full.js"></script>

<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>

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
 		   value: '${cosVO.cosFrom}', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           minDate:               '${cosVO.cosFrom}', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        $('#f_date2').datetimepicker({
            theme: '',
  	       timepicker:true,
  	       step: 1,
  	       format:'Y-m-d H:i:s',
  		   value: '${cosVO.cosTo}',
  		   maxDate: '${cosVO.cosTo}'
  		   });
        $('#f_date3').datetimepicker({
            theme: '',
  	       timepicker:true,
  	       step: 1,
  	       format:'Y-m-d H:i:s',
  		   value: '${cosVO.cosApplyFrom}'
  		   });
        $('#f_date4').datetimepicker({
            theme: '',
  	       timepicker:true,
  	       step: 1,
  	       format:'Y-m-d H:i:s',
  		   value: '${cosVO.cosApplyTo}'
  		   });

        $("#twzipcode").twzipcode({
        	onDistrictSelect: function() {
        		var country = $("select[name='county']").val();  // 取縣市的值
    			var district = $("select[name='district']").val();  // 取鄉鎮市區的值
    			var zipcode = $("input[name='zipcode']").val();  // 取郵遞區號的值
    			$("#cosAdd").val(zipcode+country+district);

        	},
        })
        
</script>              
<!-- Page Content END -->
                
<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>
</body>

</html>