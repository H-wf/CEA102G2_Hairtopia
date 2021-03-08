<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.salon.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  SalonVO salonVO = (SalonVO) request.getAttribute("salonVO"); //SalonServlet.java(Concroller), 存入req的salonVO物件
%>

<html>
<head>
<title>髮廊資料 - listOneSalon.jsp</title>
<style type="text/css">
        /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
        #map {
            height: 300px;
            width: 300px;
        }

        /* Optional: Makes the sample page fill the window. */
    </style>
    <script>
        var mylat = ${salonVO.salLat};
        var mylng = ${salonVO.salLng};
        var mySalonName = '${salonVO.salName}';

        function initMap() {
            //準備好要顯示的緯經度
            const myLatLng = { lat: mylat, lng: mylng };
            //抓取div id生成Map類別 zoom代表顯示地圖範圍大小 數字越小範圍越大
            const map = new google.maps.Map(document.getElementById("map"), {
                zoom: 18,
                center: myLatLng,
            });
            //增加圖釘效果
            var marker = new google.maps.Marker({
                position: myLatLng,
                map,

            });
            //將地點資訊放入小卡片
            var infoWindow = new google.maps.InfoWindow({
                content: '<h1>' + mySalonName + '</h1>'
            })
            //加入聆聽器 點擊彈出小卡片
            marker.addListener('click', function() {
                infoWindow.open(map, marker);
            });
        }
    </script>

</head>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>

<table>
	<tr>
		<th>髮廊編號</th>
		<th>髮廊名稱</th>
		<th>髮廊地址</th>
		<th>營業時間</th>
		<th>髮廊電話</th>
		<th>營業狀態</th>
		
	</tr>
	<tr>
		<td><%=salonVO.getSalNo()%></td>
		<td><%=salonVO.getSalName()%></td>
		<td><%=salonVO.getSalAdd()%></td>
		<td><%=salonVO.getSalTime()%></td>
		<td><%=salonVO.getSalPhone()%></td>
		<td><%=salonVO.getSalStatus()%></td>
	</tr>
	
</table>
	<td>
		
    <div id="map"></div>
    <!-- Async script executes immediately and must be after any DOM elements used in callback. -->
    
		
		
	</td>
	
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAgth_SXMI_V6SbxEmCxOFwzUwCXAizZhY&callback=initMap&libraries=&v=weekly" async></script>
</body>
</html>