<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.designer.model.*"%>

<%
	DesignerVO designerVO = (DesignerVO) request.getAttribute("designerVO");
	//DesignerServlet.java (Concroller) 存入req的designerVO物件 (包括幫忙取出的designerVO, 也包括輸入資料錯誤時的designerVO物件)
	
	String weekArray[] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
	pageContext.setAttribute("weekArray", weekArray);

%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>服務資料修改 - update_designer_input.jsp</title>
<style>
img {
	width: 100px;
}
</style>
</head>
<body>

	<h3>服務資料修改:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post"
		ACTION="<%=request.getContextPath()%>/designer/designer.do"
		name="form1">
		<table>
			<!-- 怎麼捕捉新增服務的設計師 -->
			<tr>
				<td>設計師編號:</td>
				<td>${designerVO.desNo}</td>
			</tr>
			<tr>
				<td>沙龍編號:</td>
				<td>${designerVO.salNo}</td>
			</tr>
			<tr>
				<td>設計師名字:</td>
				<td>${designerVO.desName}</td>
			</tr>

		
			<tr>
				<td>設計師狀態</td>
				<td><select name = "desStatus">
					<option value="0"  ${designerVO.desStatus == 0 ? "selected" : ""}>未審核</option>
					<option value="1"  ${designerVO.desStatus == 1 ? "selected" : ""}>正常</option>
					<option value="2"  ${designerVO.desStatus == 2 ? "selected" : ""}>停權</option>
					<option value="3"  ${designerVO.desStatus == 3 ? "selected" : ""}>超過方案到期日</option>
				</select>
				</td>
			</tr>
			<tr>
			<td>方案到期日:</td><td>${designerVO.desEndDate}</td>
		<td><input name="desEndDate" id="f_date1" type="text"/> </td>
            </tr>
	
	<tr>
		<td>營業時間</td>
		<td>
			<table>
		
			<tr>
		
			<td><table>
			<c:forEach var="myData" begin="0" end="27" step="4">
				<c:set var="i" value="${myData/4}" />
					<c:set var="desSchedule" value="${designerVO.desSchedule}" />

					<fmt:parseNumber var="start"
											value="${desSchedule.substring(myData,myData+2)}"
											integerOnly="true" />
					<c:set var="startHour" value="${((start*30 -(start*30%60)))/60}" />
				<tr>
											<td>	${weekArray[i]}</td>
					<td><fmt:formatNumber value="${startHour}" type="number"
													maxFractionDigits="0" />:  ${(start*30 %60 == 0)? "00" :"30"}</td>
	
							<td>to</td>
		<fmt:parseNumber var="end"
												value="${desSchedule.substring(myData+2,myData+4)}"
												integerOnly="true" />
					<c:set var="endHour" value="${((end*30 -(end*30%60)))/60}" />
					
					<td><fmt:formatNumber value="${endHour}" type="number"
													maxFractionDigits="0" />: ${(end*30 %60 == 0)? "00" :"30"}</td>
										</tr>
		
				</c:forEach>
			
								</table></td>
			</tr>
			
			</table>
		</td>
	
	
			<tr>
		<td>設計師照片:</td>
		<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}"
					alt='沒有圖片' /></td>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="Update_Status">
<input type="hidden" name="desNo" value="${designerVO.desNo}">
<input type="submit" value="送出修改">
	</FORM>
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

	
$.datetimepicker.setLocale('zh');
$('#f_date1').datetimepicker({
       theme: 'dark',              //theme: 'dark',
       timepicker:false,       //timepicker:true,
       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
       format:'Y-m-d ',         //format:'Y-m-d H:i:s',
	   value: '<%="desEndDate"%>',  // value:   new Date(),
//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
//startDate:	            '2017/07/10',  // 起始日
//minDate:               '-1970-01-01', // 去除今日(不含)之前
//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
});
</script>


        

</html>