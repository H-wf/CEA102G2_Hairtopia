<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.cos.model.*"%>

<%
  CosVO cosVO = (CosVO) request.getAttribute("cosVO"); 
%>

<jsp:useBean id="lecSvc" scope="page" class="com.lecturer.model.LecturerService" />
<jsp:useBean id="costypeSvc" scope="page" class="com.coutype.model.CostypeService" />
<html>
<head>
<meta charset="UTF-8">
<title>課程資料修改</title>
</head>
<body>
<form METHOD="POST" ACTION="<%=request.getContextPath()%>/cos/cos.do" name="form1" enctype="multipart/form-data"> 
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<p class="lead mb-0"><label>課程編號:<i>${cosVO.cosNo}</i></label></p>
	<p class="lead mb-0"><label for="cosName">課程名稱:</label></p>
		<input class="form-control form-control-sm" style="width:200px;" id="cosName" type="TEXT" name="cosName" size="45" value="${cosVO.cosName}" />
		<p class="lead mb-0"><label for="lecNo">講師:</label></p>
		<select class="form-control form-control-sm" style="width:100px;" id="lecNo" size="1" name="lecNo" >
			<c:forEach var="lecturerVO" items="${lecSvc.all}" > 
          		<option value="${lecturerVO.lecNo}"${(cosVO.lecNo==lecturerVO.lecNo)?'selected':'' }>${lecturerVO.lecName}
         	</c:forEach>
		</select>
		<p class="lead mb-0"><label for="cosTypeNo">課程類別:</label></p>
		<select class="form-control form-control-sm" style="width:100px;" id="cosTypeNo" size="1" name="cosTypeNo" >
			<c:forEach var="cosTypeVO" items="${costypeSvc.all}" > 
          		<option value="${cosTypeVO.cosTypeNo}"${(cosVO.cosTypeNo==cosTypeVO.cosTypeNo)?'selected':'' }>${cosTypeVO.cosTypeName}
         	</c:forEach>
		</select>
		<p class="lead mb-0"><label for="f_date5">開訓日:</label></p>
		<input class="form-control form-control-sm" style="width:200px;" name="cosFrom" id="f_date5" type="text" autocomplete="off" value="${cosVO.cosFrom}">
		<p class="lead mb-0"><label for="f_date6">結訓日:</label></p>
		<input class="form-control form-control-sm" style="width:200px;" name="cosTo" id="f_date6" type="text" autocomplete="off" value="${cosVO.cosTo}">
		<p class="lead mb-0"><label for="cosIntro">課程介紹:</label></p>
		<textarea required class="form-control mb-3" id="cosIntro" name="cosIntro" cols="30" rows="10">${cosVO.cosIntro}</textarea>		
		<p class="lead mb-0"><label>課程圖片:</label></p>
		<div id="preview1"></div>
		<label>
		<input style="display:none;" class="mb-3 mt-0" type="file" name="cosPic" id="myFile1">
		<span class="btn btn-primary btn-sm pic"><i class="fas fa-image"></i>上傳圖片</span>
		</label>
		<p class="lead mb-0"><label for="cosAdd">課程地址:</label></p>
		<div id = "twzipcode"></div><input class="form-control form-control-sm" style="width:200px;" type="TEXT" id="cosAdd" name="cosAdd" size="45" value="${cosVO.cosAdd}" />
		<p class="lead mb-0"><label for="cosMaxCount">報名人數上限:</label></p>
		<input class="form-control form-control-sm" style="width:100px;" id="cosMaxCount" type="number" name="cosMaxCount" size="45" min="1" value="${cosVO.cosMaxCount}" />
		<p class="lead mb-0"><label for="cosMinCount">報名人數下限:</label></p>
		<input class="form-control form-control-sm" style="width:100px;" type="number" name="cosMinCount" size="45" min="1" value="${cosVO.cosMinCount}" />
		<p class="lead mb-0"><label for="cosPrice">課程價格:</label></p>
		<input class="form-control form-control-sm" style="width:100px;" id="cosPrice" type="number" name="cosPrice" size="45" min="1" value="${cosVO.cosPrice}" />
		<p class="lead mb-0"><label for="f_date7">報名開始日:</label></p>
		<input class="form-control form-control-sm" style="width:200px;" name="cosApplyFrom" id="f_date7" type="text" autocomplete="off" value="${cosVO.cosApplyFrom}">
		<p class="lead mb-0"><label for="f_date8">報名截止日:</label></p>
		<input class="form-control form-control-sm" style="width:200px;" name="cosApplyTo" id="f_date8" type="text" autocomplete="off" value="${cosVO.cosApplyTo}">
		<p class="lead mb-0"><label>課程狀態:</label></p>
		<label><input type="radio" name="cosStatus" value="true"  ${cosVO.cosStatus==true?'checked':''}/>上架</label>					
		<label><input type="radio" name="cosStatus" value="false" ${!cosVO.cosStatus==true?'checked':''} />下架</label>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		<input type="submit" class="btn btn-primary" value="修改">
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="cosNo" value="${cosVO.cosNo}">
	</div>
</form>
<script>
$.datetimepicker.setLocale('zh');
        $('#f_date5').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:true,       //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
 		   <%--value: '<%=cosVO.getCosFrom()%>',--%> // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        $('#f_date6').datetimepicker({
            theme: '',
  	       timepicker:true,
  	       step: 1,
  	       format:'Y-m-d H:i:s',
  	     <%-- value: '<%=cosVO.getCosTo()%>',--%>
  		   });
        $('#f_date7').datetimepicker({
            theme: '',
  	       timepicker:true,
  	       step: 1,
  	       format:'Y-m-d H:i:s',
  		  <%-- value: '<%=cosVO.getCosTo()%>',--%>
  		   });
        $('#f_date8').datetimepicker({
            theme: '',
  	       timepicker:true,
  	       step: 1,
  	       format:'Y-m-d H:i:s',
  		  <%-- value: '<%=cosVO.getCosTo()%>',--%>
  		   });
        var customFile1 = document.getElementById("myFile1");
        var preview1 = document.getElementById('preview1');
        customFile1.addEventListener('change', function(e) {
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
        				img.setAttribute('width', '200');
        				img.classList.add("prviewImg");
        				// 放到div裡面
        				preview1.innerHTML = "";
        				preview1.append(img);
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
</body>
</html>