<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.schedule.model.*"%>
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
	<h2>選擇工作地點</h2>
	
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
		<table>
		
		
		
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
					
					 var lat = response.data.results[0].geometry.location.lat;
					 var lng = response.data.results[0].geometry.location.lng;
					 salLat.value = lat;
					 salLng.value = lng;
					 console.log(salLat.value)
					 console.log(salLng.value)
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
					<td><input type="TEXT" name="salTime" size="15"
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