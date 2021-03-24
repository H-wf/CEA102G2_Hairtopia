<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.cos.model.*"%>

<%
  CosVO cosVO = (CosVO) request.getAttribute("cosVO"); 
%>
<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService" />
<jsp:useBean id="lecSvc" scope="page" class="com.lecturer.model.LecturerService" />
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
	<p class="lead mb-0">課程編號:<i>${cosVO.cosNo}</i></p>
	<p class="lead mb-0">課程名稱:</p>
		<input type="TEXT" name="cosName" size="45" value="${cosVO.cosNames}" />
		<p class="lead mb-0">講師:</p>
		<select size="1" name="lecNo" >
			<c:forEach var="lecturerVO" items="${lecSvc.all}" > 
          		<option value="${lecturerVO.lecNo}"${(cosVO.lecNo==lecturerVO.lecNo)?'selected':'' }>${lecturerVO.lecName}
         	</c:forEach>
		</select>
		<p class="lead mb-0">課程類別:</p>
		<select size="1" name="cosTypeNo" >
			<c:forEach var="cosTypeVO" items="${costypeSvc.all}" > 
          		<option value="${cosTypeVO.cosTypeNo}"${(cosVO.cosTypeNo==cosTypeVO.cosTypeNo)?'selected':'' }>${cosTypeVO.cosTypeName}
         	</c:forEach>
		</select>
		<p class="lead mb-0">開訓日:</p>
		<input name="cosFrom" id="f_date5" type="text" autocomplete="off" value="${cosVO.cosFrom}">
		<p class="lead mb-0">結訓日:</p>
		<input name="cosTo" id="f_date6" type="text" autocomplete="off" value="${cosVO.cosTo}">
		<p class="lead mb-0">課程介紹:</p>
		<textarea required class="mb-3 mt-0" name="cosIntro" cols="30" rows="10">${cosVO.cosIntro}</textarea>		
		<p class="lead mb-0">課程圖片:</p>
		<div id="preview"></div>
		<input required class="mb-3 mt-0" type="file" name="cosPic" id="myFile">
		<p class="lead mb-0">課程地址:</p>
		<div id = "twzipcode"></div><input type="TEXT" id="cosAdd" name="cosAdd" size="45" value="${cosVO.cosAdd}" />
		<p class="lead mb-0">報名人數上限:</p>
		<input type="number" name="cosMaxCount" size="45" min="1" value="${cosVO.cosMaxCount}" />
		<p class="lead mb-0">報名人數下限:</p>
		<input type="number" name="cosMinCount" size="45" min="1" value="${cosVO.cosMinCount}" />
		<p class="lead mb-0">課程價格:</p>
		<input type="number" name="cosPrice" size="45" min="1" value="${cosVO.cosPrice}" />
		<p class="lead mb-0">報名開始日:</p>
		<input name="cosApplyFrom" id="f_date7" type="text" autocomplete="off" value="${cosVO.cosApplyFrom}">
		<p class="lead mb-0">報名截止日:</p>
		<input name="cosApplyTo" id="f_date8" type="text" autocomplete="off" value="${cosVO.cosApplyTo}">
		<p class="lead mb-0">課程狀態:</p>
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
 		   value: '<%=cosVO.getCosFrom()%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        $('#f_date5').datetimepicker({
            theme: '',
  	       timepicker:true,
  	       step: 1,
  	       format:'Y-m-d H:i:s',
  		   value: '<%=cosVO.getCosTo()%>',
  		   });
        $('#f_date7').datetimepicker({
            theme: '',
  	       timepicker:true,
  	       step: 1,
  	       format:'Y-m-d H:i:s',
  		   value: '<%=cosVO.getCosTo()%>',
  		   });
        $('#f_date8').datetimepicker({
            theme: '',
  	       timepicker:true,
  	       step: 1,
  	       format:'Y-m-d H:i:s',
  		   value: '<%=cosVO.getCosTo()%>',
  		   });
</script>
</body>
</html>