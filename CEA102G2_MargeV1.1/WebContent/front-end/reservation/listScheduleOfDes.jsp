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
 <link rel="stylesheet" href="<%= request.getContextPath()%>/resource/fullcalendar/fullcalendar.min.css">
 
</head>
<style>
	.ftco-navbar-light{
		position:static;
	}
	.list-group-item{
		font-weight:400;
	}
	.list-group-item.active{
		background-color:#D8CF9E;
		border:0px;
	}
	.fc-title {
		color:white;
		font-size:.9rem;
	}
	.fc-day-number{
		line-height:1.2rem;
	}
	.fc-time{
		color:white;
	}
	.fc-widget-content{
		color:#777;
	}
	.fc-scroller {
  		height: auto !important;
	}

	.fc-head .fc-widget-header {
 		 margin-right: 0 !important;
	}

	.fc-scroller {
 		 overflow: visible !important;
	}
	.btn-primary{
		margin:3px;
	}
</style>
<body>

<%@include file="/front-end/tempFile/navBar" %>
<hr class="space">
<!-- Begin Page Content -->
<div class="container-fluid">
	<div class="row">
		<div class="col-1"></div>
		<div class="col-2">
			<div class="list-group">
  			<a href="<%=request.getContextPath()%>/service/service.do?action=queryByDesNo&desNo=${desSession.desNo}" class="list-group-item list-group-item-action">
    			服務項目管理
  			</a>
  			<a href="<%=request.getContextPath()%>/reservation/res.do?action=queryByDesNo&desNo=${desSession.desNo}" class="list-group-item list-group-item-action">
  				預約狀態管理
  			</a>
  			<a href="#" class="list-group-item list-group-item-action active">
  				查看預約行程
  			</a>
  			<a href="<%=request.getContextPath()%>/designer/designer.do?action=getOne_For_Update&desNo=${desSession.desNo}" class="list-group-item list-group-item-action">
				個人資訊修改
			</a>
  			<a href="" class="list-group-item list-group-item-action">
				貼文狀態管理
			</a>
		</div>
		</div>		
		<div class="col-8">
			<div id = listView></div>
    		<div id="test"></div>
		</div>
		<div class="col-1"></div>
	</div>
	<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true" >
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
                    <h3 class="modal-title" id="myModalLabel">Reservation Detail</h3>
				</div>
                <div class="modal-body">   
					<div id=modalView></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
			</div>
		</div>
	</div>
</div>
			
<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
<script src="<%= request.getContextPath()%>/resource/fullcalendar/moment.min.js"></script>
<script src="<%= request.getContextPath()%>/resource/fullcalendar/fullcalendar.min.js"></script>
<script>
	//${sessionScope.desNo}
	var desNo = ${sessionScope.desSession.desNo};
	window.onload = function() {
		getSchedule(desNo);
	};
	
	function lookUp(resNo) {
		$.ajax({
			url : "<%=request.getContextPath()%>/reservation/res.do",
			data : {
				action : "searchByResNo",
				resNo : resNo,
			},
			type : "POST",
			cache:false,
			ifModified :true,
			dataType : "json",
			success : function(data) {
				$("#modalView").empty();
				modalView(data);
				$("#basicModal").modal('show');
			}
		});
	}
	
	function modalView(data) {
		  let starthour = parseInt(data.resTime/2);
	  	  let startminute = (data.resTime%2==0)?"00":"30";
	  	  let endtime = data.resTime+data.serTime;
	  	  let endhour = parseInt(endtime/2);
	  	  let endminute = (endtime%2==0)?"00":"30";
	  	  let star;
	  	  let confirm = "<%=request.getContextPath()%>/reservation/res.do?action=getOne_For_Update_Confirm&resNo="+data.resNo;
	  	  let cancel = "<%=request.getContextPath()%>/reservation/res.do?action=cancelByDes&resNo="+data.resNo;
	  	  if(data.resCom!==0){
	  	  	star = '&#x2605;'.repeat(data.resCom)+'&#x2606;'.repeat(5-data.resCom);
	  	  }
			let table = $("<table>");
			let tr = $("<tr>");
			let th = $("<th>");
			th.text("預約編號");
			let td = $("<td>");
			td.text(data.resNo);
			tr.append(th, td);
			table.append(tr);
			tr = $("<tr>");
			th = $("<th>");
			th.text("會員姓名");
			td = $("<td>");
			td.text(data.memName);
			tr.append(th, td);
			table.append(tr);
			tr = $("<tr>");
			th = $("<th>");
			th.text("服務名稱");
			td = $("<td>");
			td.text(data.serName);
			tr.append(th, td);
			table.append(tr);
			tr = $("<tr>");
			th = $("<th>");
			th.text("預約時間");
			td = $("<td>");
			td.text(starthour + ":" + startminute + "~" + endhour + ":" + endminute);
			tr.append(th, td);
			table.append(tr);
			tr = $("<tr>");
			th = $("<th>");
			th.text("預約金額");
			td = $("<td>");
			td.text(data.resPrice);
			tr.append(th, td);
			table.append(tr);
			tr = $("<tr>");
			th = $("<th>");
			th.text("預約評價");
			td = $("<td style='color:#BDB58C'>");
			td.html(star);
			tr.append(th, td);
			table.append(tr);
			tr = $("<tr>");
			th = $("<th>");
			
			td = $("<td>");
			let confirmBtn = $("<a>");
			confirmBtn.attr("href",confirm);
			confirmBtn.attr("class","btn btn-primary");
			confirmBtn.text("確認");
			let cancelBtn = $("<a>");
			cancelBtn.attr("href",cancel);
			cancelBtn.attr("class","btn btn-primary");
			cancelBtn.text("取消");
			td.append(confirmBtn, cancelBtn);
			tr.append(th, td);
			table.append(tr);
			$("#modalView").append(table);
		}
	
	function getSchedule(desNo) {
		let events=[];
        $.ajax({
            url: "<%=request.getContextPath()%>/reservation/res.do",
            data: {
                action: "searchByDesNo",
                desNo: desNo,
            },
            type: "POST",
            cache: false,
            ifModified: true,
            dataType: "JSON",
            success: function(data) {
              
              for(let i=0 ; i<data.length ; i++){
            	  
            	  let starthour = parseInt(data[i].resTime/2);
            	  let startminute = (data[i].resTime%2==0)? "00" : "30" ;
            	  let endtime = data[i].resTime+data[i].serTime;
            	  let endhour = parseInt(endtime/2);
            	  let endminute = (endtime%2==0)?"00":"30";
            	  let colors = ["#A6A6A6","#D8CF9E","#333333","#333333"]
            	  events.push({
  					id : data[i].resNo,
  					start : moment(data[i].resDate+" "+starthour+":"+startminute).format('YYYY/MM/DD HH:mm'),
  					end : moment(data[i].resDate+" "+endhour+":"+endminute).format('YYYY/MM/DD HH:mm'),
  					
  					title : data[i].memName,
  					color : colors[data[i].resStatus],
  					content:"<div style=font-size:.9rem;>"
  							+data[i].memName
  							+"<br>"+data[i].serName
  							+"<br>" + starthour + ":" + startminute + "~" + endhour + ":" + endminute
  							+"</div>"
  				});
            	 
            	  $("#test").append(data[i].resTime+data[i].serTime);
              }
              GenerateCalendar(events);
            }
       })

		}
	
	function GenerateCalendar(events) {
		$('#listView').fullCalendar(
				{
					defaultView : 'month',
					editable : false,
					selectable : true,
					header : { 
						left : "prev,next",
						center : "title",
						right : "month,listWeek"
					},
					height:700,
					aspectRatio: 1,
					dayNamesShort : [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri","Sat" ],
					dayNamesMin : [ "日", "一", "二", "三", "四", "五", "六" ],
					monthNames : [ "January", "February", "March", "April", "May", "June", "July", "August",
							"Septemper", "October", "November", "December" ],
					buttonText : {
						today : 'today',
						month : 'month',
						week : 'week',
						day : 'day',
						prev : '<',
						next : '>',
						prevYear : 'preYear',
						nextYear : 'nextYear',
					},
					eventLimitText : "more", 
					events : events,
					timeFormat:'H:mm',
					eventBackgroundColor: '#272727',
					dayClick : function(date, jsEvent, view, resourceObj) {
						let nowDate = date.format();
						toAdd(nowDate);
					},
					eventMouseover : function(calEvent, jsEvent, view) {
						$(this).css('border', '1px solid #272727');
					},
					eventMouseout : function(calEvent, jsEvent, view) {
						$(this).css('border', '1px solid transparent');
					},
					eventClick : function(event) {
						lookUp(event.id);
					}
				})
	};

	
        
        
</script>
</body>

</html>