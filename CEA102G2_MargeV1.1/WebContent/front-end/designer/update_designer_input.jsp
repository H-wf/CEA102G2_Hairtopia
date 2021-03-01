<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.designer.model.*"%>

<%
  DesignerVO designerVO = (DesignerVO) request.getAttribute("designerVO"); 
  String weekArray[] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}; 
  pageContext.setAttribute("weekArray",weekArray);
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>設計師資料修改 - update_salon_input.jsp</title>
<script src="<%=request.getContextPath()%>/resource/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	window.onload=function () {

		CKEDITOR.replace('desInfor');
		
	}
	
</script>

</head>
<body>

<h3>設計師資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/designer/designer.do" name="form1"

enctype="multipart/form-data">
<table>
	<tr>
		<th>設計師編號</th>
		<td><%= designerVO.getDesNo()%></td>
	</tr>
	<tr>
		<td>沙龍編號</td>
		<td><input type="TEXT" name="salNo" size="45" 
			 value="<%= (designerVO==null)? "" : designerVO.getSalNo()%>" /></td>
	</tr>
	<tr>
		<td>設計師名字</td>
		<td><input type="TEXT" name="desName" size="45" 
			 value="<%= (designerVO==null)? "" : designerVO.getDesName()%>" /></td>
	</tr>
	
	
	
	
		<td>營業時間</td>
		<td>
			<table>
			<c:forEach begin="0" end="6" varStatus="s">
			<tr>
			
			<td>${weekArray[s.index]}</td>
			<td>
					<c:set var="x" value="${designerVO.desSchedule}"/>
				    <select class="time">
					<c:forEach var="whatTime" begin="0" end="47" >
					<fmt:formatNumber type="number" value="${((whatTime*30 -(whatTime*30%60)))/60}"  var="hour"/>
					<c:set var="select" value="${s.index *4}"/>
					
					<c:set var="schedule" value="${x.substring(select,select+2)}"/>
					<option value='${whatTime}' ${whatTime == schedule ? "selected" : ""}>
					${hour}:${(whatTime*30 %60 == 0)? "00" :"30" }
					</c:forEach>
				
				</select>
					~
				<select class="time">
					<c:forEach var="whatTime" begin="0" end="47">
					<fmt:formatNumber type="number" value="${((whatTime*30 -(whatTime*30%60)))/60}"  var="hour"/>
					<c:if test="${whatTime%6 ==0 && whatTime/6 != 7}">
					<c:set var="schedule" value="${x.substring(select+2,select+4)}"/>
					</c:if>
					
					
					<option value="${whatTime}" ${whatTime == schedule ? "selected" : ""}>
					${hour}:${(whatTime*30 %60 == 0)? "00" :"30" }
					
					</c:forEach>
					
				</select>
				
			</td>
			
			</tr>
		</c:forEach>
			</table>
		</td>
	
	<tr>
		<td>設計師照片:</td>
		<td><input type="file" name="desPic"></td>
	</tr>
	<tr>
		<td>設計師簡介:</td>
		<%-- <td><input type="TEXT" name="desInfor"  size="45" 
			 value="<%= (designerVO==null)? "" : designerVO.getDesInfor()%>" /></td>
		 <td>講師簡介</td> --%>
		 <td><textarea id='desInfor' row="10" cols="48" name="desInfor"
						size="45" ><%=(designerVO == null) ? "" : designerVO.getDesInfor()%></textarea>
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="desNo" value="<%=designerVO.getDesNo()%>">
<input type="hidden" name="desSchedule" id="desSchedule" value="1">
<input type="submit" value="送出修改"></FORM>
</body>

<script type="text/javascript">
	var form = document.forms[0]
	let time = document.getElementsByClassName("time");
	let schedule =document.getElementById("desSchedule");
	let str ="";
	form.onsubmit = function() {
		
		if(+time[0].value > +time[1].value){
			alert("Sunday時間填寫有誤")
			return false;
		}else if(parseInt(time[2].value) > parseInt(time[3].value)){
			alert("Monday時間填寫有誤")
			return false;
		}else if(parseInt(time[4].value) > parseInt(time[5].value)){
			alert("Tuesday時間填寫有誤")
			return false;
		}else if(parseInt(time[6].value) > parseInt(time[7].value)){
			alert("Wednesday時間填寫有誤")
			return false;
		}else if(parseInt(time[8].value) > parseInt(time[9].value)){
			alert("Thursday時間填寫有誤")
			return false;
		}else if(parseInt(time[10].value) > parseInt(time[11].value)){
			alert("Friday時間填寫有誤")
			return false;
		}else if(parseInt(time[12].value) > parseInt(time[13].value)){
			alert("Saturday時間填寫有誤")
			return false;
		}
		
		for(let i = 0;i <time.length; i++){
			let whichTime = time[i];
			index = whichTime.selectedIndex;
// 			let selectedValue = whichTime.options[index].value;
			if(index < 10){
				index = index.toString();
				str += ("0"+ index);
			}else{
				str += index.toString();
			}
				
		};
		schedule.value=str;
		
		form.submit();
	}


</script>


        

</html>