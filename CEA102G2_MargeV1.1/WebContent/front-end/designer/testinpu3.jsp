<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.designer.model.*"%>
<%
	DesignerVO designerVO = (DesignerVO)request.getAttribute("designerVO");
	String weekArray[] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}; 
	pageContext.setAttribute("weekArray",weekArray);
%>

<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style type="text/css">
#addSalonimg{
width:30px;

}
#xx{
padding:0px;
border:0px;
box-sinzing:border-box;
}
td{
border:1px solid red;
}
tr{
}

</style>
</head>
<body>
	<h1>加入設計師</h1>
	<br>
	<h2>Step1.  選擇工作地點</h2>
	<hr>
	
	<form METHOD="post" id="location-form"
		ACTION="<%=request.getContextPath()%>/salon/salon.do" name="form1"
		enctype="multipart/form-data">

		<table>
		<tr>
		<td>
			<div class="ui-widget">
				<input type="text" id="search-box" name="salName" placeholder="請輸入髮廊名稱">
				<label><button type="button" id="xx" ><img  id="addSalonimg" src="<%=request.getContextPath()%>/resource//images/ico_add.jpg">
					</button>
			</label>	
			</div>
		</td>
		</tr>
		<tr>
		<td><div id="addSalondiv"></div>
		</td></tr>
		</table>
		
	<hr>
	<h2>Step2.  選擇填寫設計師資料</h2>
		<table>
		<tr>
		<td>會員編號:</td>
		<td><input type="TEXT" name="memNo" size="45" 
			 value="<%= (designerVO==null)? "" : designerVO.getMemNo()%>" /></td>
	
	<tr>
		<td>設計師名字:</td>
		<td><input type="TEXT" name="desName" size="45" 
			 value="<%= (designerVO==null)? "" : designerVO.getDesName()%>" /></td>
	</tr>
	
	
	
	<tr>
		<td>營業時間</td>
		<td>
			<table>
			<c:forEach begin="0" end="6" varStatus="s">
			<tr>
			<td>${weekArray[s.index]}</td>
			<td>
				<select class="time">
					<c:forEach var="whatTime" begin="0" end="47">
					<fmt:formatNumber type="number" value="${((whatTime*30 -(whatTime*30%60)))/60}"  var="hour"/>
					<option value="${whatTime}">${hour}:${(whatTime*30 %60 == 0)? "00" :"30" }
					</c:forEach>
				</select>~
				<select class="time">
					<c:forEach var="whatTime" begin="0" end="47">
					<fmt:formatNumber type="number" value="${((whatTime*30 -(whatTime*30%60)))/60}"  var="hour"/>
					<option value="${whatTime}">${hour}:${(whatTime*30 %60 == 0)? "00" :"30" }
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
		
		 <td><textarea id='desInfor' row="10" cols="48" name="desInfor"
						size="45" ><%=(designerVO == null) ? "" : designerVO.getDesInfor()%></textarea>
		</td>
	</tr>
	


<br>

	<input type="hidden" name="desStatus" value="0">
	<input type="hidden" name="desSchedule" id="desSchedule" value="1">
		
		
		</table>
		<input type="hidden" name="action" value="test"> 
		<input type="hidden" id="salLat" name="lat" value="1"> 
		<input type="hidden" id="salLng" name="lng" value="2"> 
		<input type="submit" value="送出新增">
	</form>
	<script>
	
	var contextPath = "<%=request.getContextPath()%>";

		$(document).ready(function() {
			var locationForm = document.getElementById('location-form');
	   		locationForm.addEventListener('submit',geocode);
	   		let salLat =document.getElementById("salLat");
			let salLng =document.getElementById("salLng");
			let time = document.getElementsByClassName("time");
			let schedule =document.getElementById("desSchedule");
			let str ="";
			
			function geocode(e){
				e.preventDefault();
				
				var location=document.getElementById('loaction-input').value;
				
				axios.get('https://maps.googleapis.com/maps/api/geocode/json',{
					params:{
						address:location,
						key:'AIzaSyAgth_SXMI_V6SbxEmCxOFwzUwCXAizZhY'

					}
				})
				.then(function(response){
					console.log(response);
					
					 let lat = response.data.results[0].geometry.location.lat;
					 let lng = response.data.results[0].geometry.location.lng;
					 salLat.value = lat;
					 salLng.value = lng;
					 alert(salLat.value)
					 alert(salLng.value)
					 
					 
// 				這邊開始是設計師的檢查部分	 
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
//				 			let selectedValue = whichTime.options[index].value;
							if(index < 10){
								index = index.toString();
								str += ("0"+ index);
							}else{
								str += index.toString();
							}
								
						};
						
						schedule.value=str;
			 
					locationForm.submit();		 
				})
				.catch(function(error){
					console.log(error);
				});

			}
		

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
				}
			})
				
			$('#xx').click(function(){
				var html = ""
				html +=`<tr>
					<td>髮廊地址:</td>
					<td><input type="TEXT" name="salAdd" id="loaction-input" size="45"
						 value=${empty salonVO ? ' ' :salAdd} ></td>
				</tr>
				<tr>
					<td>營業時間:</td>
					<td><input type="TEXT" name="salTime" size="45"
						 value=${empty salonVO ?' ' :salTime}></td>
					
				</tr>
				<tr>
					<td>髮廊電話:</td>
					<td><input type="TEXT" name="salPhone" size="45"
						 value=${empty salonVO ? ' ' :salPhone} ></td>
				</tr>` ;
				
				$('#addSalondiv').after(html);
				$('#xx').attr('disabled', true);	
			})
			
		})
	</script>
	
</body>
</html>