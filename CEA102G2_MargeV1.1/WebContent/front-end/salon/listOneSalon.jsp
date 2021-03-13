<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.salon.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>
<%
  SalonVO salonVO = (SalonVO) request.getAttribute("salonVO"); //SalonServlet.java(Concroller), 存入req的salonVO物件
%>
<html>

<head>
    <title>髮廊資料 - listOneSalon.jsp</title>
    <meta charset="utf-8">
    <%@include file="/front-end/tempFile/head" %>
    <style type="text/css">
        /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
        #map {
            height: 500px;
            max-width: 100%;
            
        }

        .ftco-navbar-light {
            position: static;
        }
        
        
      

        /* Optional: Makes the sample page fill the window. */
    </style>
    <script>
        var mylat = ${salonVO.salLat};
        var mylng = ${salonVO.salLng};
        var mySalonName = '${salonVO.salName}';

        function initMap() {
            //準備好要顯示的緯經度
            const myLatLng = {lat: mylat, lng: mylng};
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
                content: '<h5>' + mySalonName + '</h5>'
            })
            //加入聆聽器 點擊彈出小卡片
            marker.addListener('click', function() {
                infoWindow.open(map, marker);
            });
        }
    </script>
</head>

<body>
    <%@include file="/front-end/tempFile/navBar" %>
<div class="container-fluid">
    <div class="row">
<!--         髮廊資訊區塊 -->
           
            <div class="col-md-6 offset-md-3">
            <h2>${salonVO.salName}</h2>
                <table class="table">
                    <tr>
                       
                        <th>髮廊地址</th>
                        <th>營業時間</th>
                        <th>髮廊電話</th>
                    </tr>
                    <tr>
                       
                        <td>${salonVO.salAdd}</td>
                        <td>${salonVO.salTime}</td>
                        <td>${salonVO.salPhone}</td>
                    </tr>
                </table>
            </div>
          
     </div>
 <!--         髮廊資訊區塊結束 -->  
	<!--  髮廊設計師列表    -->
 	 <div class="row">
   			 <div class="col-md-6 offset-md-3">
   			 <hr>
   			 <h2>成員</h2>
   			 <jsp:useBean id="desSvc" scope="page" class="com.designer.model.DesignerService" />
   			 
   			 <div class="card-group">
   			 	<c:forEach var="desInSalVO" items="${desSvc.all}">
   				 <c:if test="${desInSalVO.salNo == salonVO.salNo}">
   	 
   			
   			  <div class="card desCard" style=" width: 200px;">
  					<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${desInSalVO.desNo}" 
  					class="card-img-top desImg" style="max-width: 100%; " alt="...">
  				<div class="card-body">
   				<h5 class="card-title">${desInSalVO.desName} </h5>
    			<a href="<%=request.getContextPath()%>/designer/designer.do?action=getOne_For_Display&desNo=${desInSalVO.desNo}" class="btn btn-primary" style="margin-left: 50px;">查看設計師</a>
 				</div>
		 	</div>
   			 
   			 </c:if>

   			 </c:forEach>
   			 </div>
   			 
   			 
   			 
   			 
   			</div> 
  	</div>
<!--  髮廊設計師列表    -->
<!--             以下是GMamp區塊 -->


    <div class="row">
            
            
           <div class="col-md-6 offset-md-3">
           <hr>
           <h2>髮廊位置</h2>
                <div id="map"></div>
                <!-- Async script executes immediately and must be after any DOM elements used in callback. -->
            </div>
           
     </div>
<!--      Gmap結束 -->
            
</div>
  
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAgth_SXMI_V6SbxEmCxOFwzUwCXAizZhY&callback=initMap&libraries=&v=weekly" async></script>
    <%@include file="/front-end/tempFile/footer" %>
    <%@include file="/front-end/tempFile/tempJs" %>
</body>

</html>