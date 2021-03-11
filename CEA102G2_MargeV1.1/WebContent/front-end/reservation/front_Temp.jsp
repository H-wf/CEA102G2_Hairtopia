<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.reservation.model.*"%>
<%@ page import="com.service.model.*"%>

<%
	ResVO resVO = (ResVO)request.getAttribute("resVO");
	ServiceVO serviceVO = (ServiceVO)request.getAttribute("serviceVO");
%>
<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <title>Hairtopia</title>
 <meta charset="utf-8">
<%@include file="/front-end/tempFile/head" %>
 
</head>
<style>
#calendarTable {
        	display:inline-block;
            width: 50%;
            /*height: 500px;*/
        }
        #month {
            background: #D8CF9E;
            border-radius: 5px;
            height: 50px;

        }
        #yearText {
            font-size: 20px;
            color: white;
            text-align: left;
            height: 25px;
        }
        #monthText {
            font-size: 30px;
            color: white;
            text-align: center;
            height: 30px;
            display: inline-block;
        }
        #backward {
            float:left;
            color:white;
            display:none;
        }
        #forward{
        	float:right;
        	color:white;
        }
        tr>th {
            height: 30px;
            width: 30px;
            text-align: center;
            color:#BDB58C;
        }
        tr>td {
            border: #D8CF9E solid 1px;
            border-radius: 5px;
            text-align: right;
            color: #BDB58C;
            size: 35px;
            height: 60px;
            width: 60px;
            background-color:#D8CF9E;
        }
        .calendar-box {
            height: 60px;
            width: 60px;
            display: block;
            margin: 0;
        }
        .outer-box{
        	background-color:white;
        }
        .outer-box:hover{
        	border-color:#696243;
        }
        #stepOne(
        	margin:auto;
        	width:90%;
        )
        
        hr{
        	border:0px;
        	border-top:1px dashed #D8CF9E;
        	
        }
        #timezone{
        	margin:auto;
        	width:500px;
        	display:none;
        }
        .pickTime{
        	width:35px;
        	height:20px;
        	background-color:#BDB58C;
        	color:white;
        	padding:5px;
        	margin:5px;
        	display:none;
        	border-radius:5px;
        }
        #resDetail{
        	display:none;
        }
        .bookingBtn{
        	background-color: #fff;
			color: #d9bf77;
			float:right;
			border:1px solid #d9bf77;
			cursor: pointer;
			letter-spacing: 2px;
			font-weight: 600;
		}
		.bookingBtn:hover{
			background-color:#d9bf77;
			color: #fff;
		}
		.callout {
			width:20%;
			vertical-align:top;
  			background-color: #fff;
  			border: 1px solid #e4e7ea;
  			border-left: 4px solid #c8ced3;
  			border-radius: .25rem;
  			padding: .75rem 1.25rem;
  			position: relative;
  			display:inline-block;
		}
		.callout h4 {
  			font-size: 1.3125rem;
  			margin-top: 0;
  			margin-bottom: .8rem
		}
		.callout p:last-child {
  			margin-bottom: 0;
		}
		.callout-default{
  			border-left-color: #D8CF9E;
		}
		.callout-default h4 {
  			color: #777;
		}
		.callout-dismissible .close {
    			position: absolute;
    			top: 0;
    			right: 0;
    			padding: .75rem 1.25rem;
    			color: inherit;
		}
</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do"
	  name="form1">
	  <%-- 	之後用session取得會員:<%session.getAttribute(); %> --%>
	<div>
	會員編號:<input type="TEXT" name="memNo" size="3"
			 value="<%= (resVO==null)? "" : resVO.getMemNo()%>" />
	</div>
<div id="stepOne">
	<div class="callout callout-default">
		<h4>${serviceVO.serName}<br><h4 style="font-size:1rem;">服務時間:　${serviceVO.serTime}小時</h4></h4>
										  	
		<span style="font-size:1rem;">${serviceVO.serDesc}</span>
		<div class="price">
		<h4 style="display:inline;font-size: unset;">金額:　${serviceVO.serPrice}元</h4>
		</div>
	</div>
	<div id="calendarTable">
    <table>
        <tr>
            <th colspan=7 id='month'>
                <div id='yearText'></div>
                <span id="backward">
                    <i class="fas fa-chevron-left"></i>
                </span>
                <div id='monthText'></div>
                <span id="forward">
                    <i class="fas fa-chevron-right"></i>
                </span>
            </th>
        </tr>
        <tr>
            <th>日</th>
            <th>一</th>
            <th>二</th>
            <th>三</th>
            <th>四</th>
            <th>五</th>
            <th>六</th>
        </tr>
        <tr>
            <td id='a0'></td>
            <td id='a1'></td>
            <td id='a2'></td>
            <td id='a3'></td>
            <td id='a4'></td>
            <td id='a5'></td>
            <td id='a6'></td>
        </tr>
        <tr>
            <td id='a7'></td>
            <td id='a8'></td>
            <td id='a9'></td>
            <td id='a10'></td>
            <td id='a11'></td>
            <td id='a12'></td>
            <td id='a13'></td>
        </tr>
        <tr>
            <td id='a14'></td>
            <td id='a15'></td>
            <td id='a16'></td>
            <td id='a17'></td>
            <td id='a18'></td>
            <td id='a19'></td>
            <td id='a20'></td>
        </tr>
        <tr>
            <td id='a21'></td>
            <td id='a22'></td>
            <td id='a23'></td>
            <td id='a24'></td>
            <td id='a25'></td>
            <td id='a26'></td>
            <td id='a27'></td>
        </tr>
        <tr>
            <td id='a28'></td>
            <td id='a29'></td>
            <td id='a30'></td>
            <td id='a31'></td>
            <td id='a32'></td>
            <td id='a33'></td>
            <td id='a34'></td>
        </tr>
        <tr>
            <td id='a35'></td>
            <td id='a36'></td>
            <td id='a37'></td>
            <td id='a38'></td>
            <td id='a39'></td>
            <td id='a40'></td>
            <td id='a41'></td>
        </tr>
    </table>
    </div>
</div>
    <div id="timezone">
    <hr>
    <c:forEach var="whatTime" begin="0" end="47">
    <fmt:formatNumber type="number" value="${((whatTime*30 -(whatTime*30%60)))/60}"  var="hour"/>
    <span class="pickTime" id="${whatTime}">${hour}:${(whatTime*30 %60 == 0)? "00" :"30" }</span>
    </c:forEach>
    </div>
    <div id="resDetail">
    <hr>
	<input type="hidden" name="action" value="insert">
	<input type="submit" value="送出新增" class="bookingBtn">
	<input type="hidden" name="serNo" value="${serviceVO.serNo}">
	<input type="hidden" name="resDate" id="resDate">
    <input type="hidden" name="resTime" id="resTime">
    </div>
    </FORM>
    <script>
        $(document).ready(function() {

            let current = new Date();
            let thisYear = current.getFullYear();
            let thisMonth = current.getMonth();
            let todayDate = current.getDate();
            let todayStr = thisYear + "-" + (thisMonth + 1) + "-" + todayDate
            console.log(todayStr);
            createCalendar(thisYear, thisMonth);

        })
        //點選date即會改變其value，將value取出並切割成年月日陣列
        function createCalendar(year, month) {
            let monthTitle = document.getElementById('monthText');
            let yearTitle = document.getElementById('yearText');
            let monthArr = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
            let monthDay = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
            if (year % 4 === 0 && year % 100 !== 0) {
                monthDay[1] = 29;
            }
            //清空原先填的日期
            for (let i = 0; i < 41; i++) {
                document.getElementById("a" + i).innerText = '';
                document.getElementById("a" + i).style['background-color'] = '#D8CF9E'
                document.getElementById("a" + i).classList.remove("outer-box");
            }
            let current = new Date();
            let thisYear = current.getFullYear();
            let thisMonth = current.getMonth();
            let start;
            if(thisYear<=year && thisMonth<month){
            	$("#backward").show();
            	start = 0 ;
            }else if(thisYear==year && thisMonth==month){
            	$("#backward").hide();
            	start = current.getDate();
            }
            //修改月曆的年份月份
            yearTitle.innerText = year;
            monthTitle.innerText = monthArr[month];
            //找到當月第一天，取得其星期
            let firstDay = new Date(year, month , 1);
            let day = firstDay.getDay();
            //得到當月份的天數
            let dayNum = monthDay[month];
            console.log(dayNum);
            for (let i = start; i < dayNum; i++) {
                let div = document.createElement("div");
                div.classList.add("calendar-box");
                let id =
                    year.toString() + "-" +
                    (month + 1).toString().padStart(2, "0") + "-" +
                    (i + 1).toString().padStart(2, "0");
                div.setAttribute("id", id);
                div.setAttribute("data-date", i + 1);
                document.getElementById("a" + (day + i)).classList.add("outer-box");
                document.getElementById("a" + (day + i)).append(div);
                document.getElementById("a" + (day + i)).firstChild.innerText = i + 1;
                document.getElementById("a" + (day + i)).style['background-color'] = 'white';
                
            }
            let backward = document.getElementById("backward");
            let forward = document.getElementById("forward");
            backward.addEventListener("click", function() {
                $(".calendar").remove();
                month -= 1;
                createCalendar(year, month);
            })
            forward.addEventListener("click", function() {
                $(".calendar").remove();
                month += 1;
                createCalendar(year, month);
            })
            $(".calendar-box").click(function() {
            	$(".pickTime").hide();
            	console.log($(this).attr("id"));
            	let resDate = document.getElementById("resDate");
            	resDate.value=$(this).attr("id");
            	let selectDate = $(this).attr("data-date")
            	let week = new Date(year,month,selectDate).getDay();
            	console.log(week);
            	let desNo = <%=serviceVO.getDesNo()%>;
                $.ajax({
                	url : "<%=request.getContextPath()%>/schedule/schedule.do",
                	data : {
        				action : "searchSchedule",
        				desNo : desNo,
        				schDate : $(this).attr("id"),
        				week : week
        			},
        			type : "POST",
        			cache:false,
        			ifModified :true,
        			dataType : "json",
        			success : function(data) {
        				console.log(data.schStatus);
        				for(let i=0 ; i<48 ; i++){
        					if(data.schStatus.charAt(i)==1){
        						document.getElementById(i).style.display='inline-block';
        					}
        				}
        				document.getElementById("timezone").style.display='block'
        			}
                })
        })
        
        $(".pickTime").click(function(){
        	console.log($(this).attr("id"));
        	let resTime = document.getElementById("resTime");
        	resTime.value=$(this).attr("id");
        	document.getElementById("resDetail").style.display='block';
        })
        }

    </script>
</div>
<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>
</html>