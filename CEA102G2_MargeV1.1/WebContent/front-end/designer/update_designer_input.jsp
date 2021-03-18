<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.designer.model.*"%>

<%
  DesignerVO designerVO = (DesignerVO) request.getAttribute("designerVO"); 
  String weekArray[] = {"Sun.", "Mon.", "Tues.", "Wed.", "Thur.", "Fri.", "Sat."}; 
  pageContext.setAttribute("weekArray",weekArray);
%>

<html>
<head>
<title>Hairtopia</title>
<meta charset="utf-8">
<%@include file="/front-end/tempFile/head" %>
<style>
.ftco-navbar-light{
  position:static;
 }
 
 #picDes{
 width:200px;
 }
 
 .prviewImg{
width: 200px;
}

.ScheduleTime{
margin-top:10px;
}
.Weekday{
padding:5px;
}
 

 </style>

</head>
<body>
<%@include file="/front-end/tempFile/navBar" %>
<div class="container-fluid">




<div class="row">

<%-- 錯誤表列 --%>
	<div class="col-md-3">
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	</div>
	<div class="col-md-6">
			<h3>設計師資料修改:</h3>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/designer/designer.do" name="form1"
				enctype="multipart/form-data">
		<div class="card card-body">
	
		
		<div class="form-group">
		<label for="picDes">設計師照片</label>
		<div id="preview">	
		<img id="picDes" src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}" 
		alt='沒有圖片' />
		</div>
		
		</div>
	
		
		<div class="form-group">
			<label for="desName">設計師名字</label>
		<input type="TEXT" name="desName" id="desName"  class="form-control" value="${empty designerVO ? ' ' :designerVO.desName}" />
		</div>
	
	
	
	
		<div class="form-group">
		<label for="desSchedule">營業時間</label>
		</div>
		<div class="container-fluid ScheduleTime">
		<div class="row">
			
			<c:forEach begin="0" end="6" varStatus="s">
			
			<div class="col-2 ScheduleTime Weekday">
			
			${weekArray[s.index]}
			</div>
			<div class="col-4 ScheduleTime">
					<c:set var="x" value="${designerVO.desSchedule}"/>
				    <select class="custom-select custom-control-inline time">
					<c:forEach var="whatTime" begin="0" end="47" >
					<fmt:formatNumber type="number" value="${((whatTime*30 -(whatTime*30%60)))/60}"  var="hour"/>
					<c:set var="select" value="${s.index *4}"/>
					
					<c:set var="schedule" value="${x.substring(select,select+2)}"/>
					<option value='${whatTime}' ${whatTime == schedule ? "selected" : ""}>
					${hour}:${(whatTime*30 %60 == 0)? "00" :"30" }
					</c:forEach>
				
				</select>
			</div>
			<div  class="col-1 ScheduleTime">~</div>
					
			<div class="col-4 ScheduleTime">
				<select class="custom-select custom-control-inline time">
					<c:forEach var="whatTime" begin="0" end="47">
					<fmt:formatNumber type="number" value="${((whatTime*30 -(whatTime*30%60)))/60}"  var="hour"/>
					<c:if test="${whatTime%6 ==0 && whatTime/6 != 7}">
					<c:set var="schedule" value="${x.substring(select+2,select+4)}"/>
					</c:if>
					
					
					<option value="${whatTime}" ${whatTime == schedule ? "selected" : ""}>
					${hour}:${(whatTime*30 %60 == 0)? "00" :"30" }
					
					</c:forEach>
					
				</select>
			</div>
		</c:forEach>
			
			
		</div>
		<div class="form-group ScheduleTime">
		<label for="desInfor">設計師簡介</label>
		<textarea id='desInfor' row="10" cols="48" name="desInfor"  class="form-control"  rows ="10"
						size="45" >${empty designerVO ? ' ' :designerVO.desInfor}</textarea>
			
		</div>
		<div class="form-group ScheduleTime">
		<label for="customFile" class="btn btn-primary btn-block">上傳照片</label>
		<input type="file" name="desPic"  id="customFile"  class="form-control" style="display:none">
		<div id="preview">	</div>
		</div>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="salNo" size="45" value="${designerVO.salNo}">
<input type="hidden" name="desNo" value="${designerVO.desNo}">
<input type="hidden" name="desSchedule" id="desSchedule" value="1">
<input type="submit" value="送出修改" class="btn btn-primary btn-block"></FORM>

</div>
</div>

</div>

</div>



<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
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
	
	var customFile = document.getElementById("customFile");
	var preview = document.getElementById('preview');
	
	customFile.addEventListener('change', function(e) {
        // 取得檔案物件的兩種方式
        // 1. 直接從myFile物件上取得檔案物件 (因為非同步，一樣，多個classname註冊時會有問題)
        // 2. 從event物件中取得他的soure target，也就是myFile物件，再取得檔案物件 
        // 檔案的基本資訊，包括：檔案的名稱、大小與文件型態
        let files = e.target.files;
        // 判斷files物件是否存在
        if (files) {
            // 取出files物件的第一個
            let file = files[0];
            // 判斷file.type的型別是否包含'image'
            if (file.type.indexOf('image') > -1) {
            	


                // new a FileReader
                let reader = new FileReader();
                // 在FileReader物件上註冊load事件 - 載入檔案的意思
                reader.addEventListener('load', function(e) {
                    // 取得結果 提示：從e.target.result取得讀取到結果
                    let result = e.target.result;
                    console.log(result);
                    // 新增img元素
                    let img = document.createElement('img');
                    // 賦予src屬性
                    img.setAttribute('src', result);
                    img.classList.add("prviewImg");
                    // 放到div裡面
                    preview.innerHTML = "";
                    preview.append(img);
                });
                // 使用FileReader物件上的 readAsDataURL(file) 的方法，傳入要讀取的檔案，並開始進行讀取
                reader.readAsDataURL(file); // *** trigger read file content
            } else {
                // 彈出警告視窗 
                 alert('請上傳圖片！');
            }
        }
    });


</script>


        

</html>