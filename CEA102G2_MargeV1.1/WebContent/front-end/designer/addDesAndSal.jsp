<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.designer.model.*"%>
<%@ page import="com.salon.model.*"%>
<%
	DesignerVO designerVO = (DesignerVO)request.getAttribute("designerVO");
	SalonVO salonVO = (SalonVO)request.getAttribute("salonVO");

	String weekArray[] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}; 
	pageContext.setAttribute("weekArray",weekArray);
%>
<!DOCTYPE html>
<html>
<head>
<title>addDesAndSal</title>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

<style>
#addSalonimg{
width:18px;


}
#xx{
padding:0px;
border:0px;
box-sinzing:border-box;
vertical-align:bottom;
}

td{
border:1px solid red;

}
textarea {
  resize : none;
  
}

.divDisplayNone {
display: none;

}





</style>

</head>




<body>
<h1>加入設計師</h1>
	<br>
	<h2>Step1.  選擇工作地點</h2>
	<hr>

<form METHOD="post" id="location-form"	ACTION="<%=request.getContextPath()%>/salon/salon.do" name="form1"
		enctype="multipart/form-data" id="form1">
		<table>
		<tr>
		<td>
			 髮廊名稱:
		</td>
		<td>	 <div class="ui-widget">
				<input type="text" id="search-box" name="salName" placeholder="請輸入髮廊名稱" size="29"  value=${empty salonVO ? ' ' :salonVO.salName}>
				<label><button type="button" id="addButton" ><img  id="addSalonimg" src="<%=request.getContextPath()%>/resource/images/ico_add.jpg">
					</button>
				</label>	
		</td>
		</tr>
		</table>
		<table>
		<tbody  id="addSalondiv" class="divDisplayNone">
		<tr><td>髮廊地址:</td>
			<td><input type="TEXT" name="salAdd" id="loaction-input" size="45"
						 value=${empty salonVO ? ' ' :salonVO.salAdd} >
		   </td>
				</tr>
				<tr>
					<td>營業時間:</td>
					<td><input type="TEXT" name="salTime" id="salTime"  size="45"
						 value=${empty salonVO ?' ' :salonVO.salTime}></td>
				</tr>
				<tr>
					<td>髮廊電話:</td>
					<td><input type="TEXT" name="salPhone" id="salPhone"size="45"
						 value=${empty salonVO ? ' ' :salonVO.salPhone} ></td>
				</tr>
		
		  </tbody>
		</table>
		
		<hr>
	<h2>Step2.  選擇填寫設計師資料</h2>
		<table>
		<tr>
		<td>會員編號:</td>
		<td><input type="TEXT" name="memNo" size="45" 
			 value="${empty designerVO ? ' ' :designerVO.memNo}" /></td>
	
	<tr>
		<td>設計師名字:</td>
		<td><input type="TEXT" name="desName" size="45" 
			 value="${empty designerVO ? ' ' :designerVO.desName}" /></td>
	</tr>
	
	
	
	<tr>
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
			</table>		</td>
	<tr>
		<td>設計師照片:</td>
		<td><input type="file" name="desPic"></td>
	</tr>
	<tr>
		<td>設計師簡介:</td>
		
		 <td><textarea id='desInfor' row="10" cols="48" name="desInfor"  rows ="10"
						size="45" >${empty designerVO ? ' ' :designerVO.desInfor}</textarea>
		</td>
	</tr>
	<br>
	<input type="hidden" name="salStatus" value="1">
	<input type="hidden" name="desStatus" value="0">
	<input type="hidden" name="desSchedule" id="desSchedule" value="1">
		</table>
		<input type="hidden" name="action" value="addDesAndSal"> 
		<input type="hidden" id="salLat" name="salLat" value="7"> 
		<input type="hidden" id="salLng" name="salLng" value="8"> 
		<input type="hidden" id="salNo" name="salNo" value="nodata"> 
		<input type="button"  id="submitForm" value="送出新增">
	</form>
<script>
var contextPath = "<%=request.getContextPath()%>";
	$(document).ready(function() {
		//控制+號顯示出髮廊資料填寫
		$('#addButton').click(function(){
			if($('#addSalondiv').hasClass("divDisplayNone")){
				$('#addSalondiv').fadeIn(1000,function(){
					$('#addSalondiv').removeClass("divDisplayNone");	
				});
				
			}else{
				$('#addSalondiv').fadeOut(1000,function(){
					$('#addSalondiv').addClass("divDisplayNone");
				})		
			}
		})
		
		$("#search-box").autocomplete({
				source : function(request, response) {
					$.ajax({
						url : contextPath + "/salon/salon.do",
						type : "GET",
						data : {
							action : "serchByAjax",
							keyWord : request.term,
						},
						dataType : "json",
						success : function(data) {
						response($.map(data, function(item) {
								return {
									value : item.salName
								}
							}))
						}
					})
				},select: function( event, ui ) {  //選擇之後將選擇的髮廊名稱呼叫下方serchBySalname帶入地址等信息
					serchBySalname(ui.item.value)	
					// console.log(ui.item.value); 測試選取的名稱
				}
			})
			
			
			function serchBySalname(salName){
			$.ajax({
				url : contextPath + "/salon/salon.do",
				type : "GET",
				data : {
					action : "serchByAjaxSalname",
					salName : salName,
				},
				dataType : "json",
				success : function(data){
						addInfor(data)

				}
			
			
			})
		}
		
		//由function serchBySalname(salName)得到的字串填入相應表格
			function addInfor(data){
				$('#loaction-input').val(data.salAdd);
				$('#salTime').val(data.salTime);
				$('#salPhone').val(data.salPhone);
				$('#salNo').val(data.salNo);
			}
		
		
		//表單送出前須檢查班表內容是否有誤  以及串接班表
			var form = document.forms[0]
			var btnF= document.getElementById("submitForm")
			let time = document.getElementsByClassName("time");
			let schedule =document.getElementById("desSchedule");
			let str ="";
			btnF.onclick = function(){
				if(ckeck() === false){
					
					return false
				}else{
				geocode()	
				scheduleSum()
				
				
				
				}
				
				 
			}
			
	//JS錯誤驗證
			function ckeck() {
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
					
			}
	//串接班表
			function scheduleSum(){
				for(let i = 0;i <time.length; i++){
					let whichTime = time[i];
					index = whichTime.selectedIndex;

					if(index < 10){
						index = index.toString();
						str += ("0"+ index);
					}else{
						str += index.toString();
					}
						
				};
				
				schedule.value=str;
				
			}
	//google map取得lat lng
			var salLat =document.getElementById("salLat");
			var salLng =document.getElementById("salLng");
			function geocode(){
				
				
				var location=document.getElementById('loaction-input').value;
				axios.get('https://maps.googleapis.com/maps/api/geocode/json',{
					params:{
						address:location,
						key:'AIzaSyAgth_SXMI_V6SbxEmCxOFwzUwCXAizZhY'

					}
				})  
				.then(function(response){
					console.log(response);
					console.log(response.data.results[0].geometry.location.lat);
					console.log(response.data.results[0].geometry.location.lng);
					var gLat = response.data.results[0].geometry.location.lat;
					var gLng = response.data.results[0].geometry.location.lng;
					salLat.value = gLat;
					salLng.value = gLng;
					form.submit();
					
				})
				.catch(function(error){
					console.log(error);

				});
			}
			
		
		
		
		
		
		
		
		
		
		
		
		
		
	})
	
	





</script>




</body>
</html>