
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Hairtopia</title>
    <meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>

<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>

<!-- Begin Page Content -->
	<div class="container-fluid">
	 <div id="display">
       <h2 >${sessionSta.staName}歡迎回來</h2> <div id="nowTime"> </div>
    </div>
		
	</div>
<!-- Page Content END -->
                
<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>

<script type="text/javascript">
        function now() {
            let now = new Date();
            let year = now.getFullYear();
            let month = now.getMonth() + 1;
            let date = now.getDate();
            let hour = now.getHours();
            let minutes = now.getMinutes();
            let second = now.getSeconds();
            let newMin;
            let newHr;
            let newMon;
            let newDate;
            let newSec

            let status = (hour >= 12) ? 'PM' : 'AM';
            //使用三元運算給定AM /PM值

            if (month < 10) {
                newMon = "0" + month;
            } else {
                newMon = month;
            }
            //月份統一改為兩位數顯示  如01 04月
            if (date < 10) {
                newDate = "0" + date;
            } else {
                newDate = date;
            }
            //日期改為兩位是顯示   04號

            if (hour > 12) {
                newHr = "0" + (hour - 12);
            } else if (hour < 11) {
                newHr = "0" + hour;
            } else {
                newHr = hour;
            }

            //日期改為兩位是顯示  如01點 PM
            if (minutes < 10) {
                newMin = "0" + minutes;
            } else {
                newMin = minutes;
            }
            //分鐘數改為兩位數顯示  如05分

            if (second < 10) {
                newSec = "0" + second;
            } else {
                newSec = second;
            }

            let combine = '現在時間:' + year + "/" + newMon + "/" + newDate + " " + newHr + ":" + newMin + " " + newSec + "  " + status;


            return combine;
        }

        let nowTime = document.getElementById('nowTime');
        // 4. 顯示時間 innerText or innerHTML
        nowTime.innerText = now();

        // 5. 利用setInterval()寫計時器，每秒更新一次結果並輸出
        setInterval(function() {
            nowTime.innerText = now();
        }, 1000)
    </script>
</body>


</html>