<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.cospost.model.*"%>

<%
  CospostVO cospostVO = (CospostVO) request.getAttribute("cospostVO"); 
%>
<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService" />

<html>
<head>
<meta charset="UTF-8">
<title>課程資料修改</title>
</head>
<body>
<form METHOD="POST" ACTION="<%=request.getContextPath()%>/cospost/cospost.do" name="form1"> 
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<p class="lead mb-0"><label>課程公告編號:<i>${cospostVO.cosPubNo}</i></label></p>	
	<p class="lead mb-0"><label for="cosNo">課程名稱:</label></p>
	<select class="form-control form-control-sm" style="width:300px;" id="cosNo" size="1" name="cosNo" >
		<c:forEach var="cosVO" items="${cosSvc.all}" > 
          	<option value="${cosVO.cosNo}"${(cosVO.cosNo==cospostVO.cosNo)?'selected':'' }>${cosVO.cosName}
         </c:forEach>
	</select>
	<p class="lead mb-0"><label for="cosPubCon">公告內容:</label></p>
	<textarea required class="form-control mb-3" id="cosPubCon" name="cosPubCon" cols="30" rows="10">${cospostVO.cosPubCon}</textarea>		
	<p class="lead mb-0"><label for="f_date2">課程公告日期:</label></p>
	<input  class="form-control form-control-sm mb-3" style="width:200px;" name="cosPubTime" id="f_date2" type="text" autocomplete="off" value="${cospostVO.cosPubTime}">
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		<input type="submit" class="btn btn-primary" value="修改">
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="cosPubNo" value="${cospostVO.cosPubNo}">
	</div>
</form>


<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->
<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:true,       //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
 		   value: '<%=cospostVO.getCosPubTime()%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });

</script>
</body>        
</html>       