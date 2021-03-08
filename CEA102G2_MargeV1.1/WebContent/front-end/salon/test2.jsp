<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<title>Insert title here</title>
</head>
<body>
  <h2 id="text-center">enter location</h2>
    <form id= 'location-form'>
        <input type="text" id="loaction-input">
        <br>
        <button type="submit">sumbit</button>
    </form>


<script >
		//call geocode
		var locationForm = document.getElementById('location-form');

       	locationForm.addEventListener('submit',geocode);
		
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
				
				 var lat = console.log(response.data.results[0].geometry.location.lat);
				 var lng = console.log(response.data.results[0].geometry.location.lng);
				
			})
			.catch(function(error){
				console.log(error);

			});
		}
	</script>

</body>
</html>