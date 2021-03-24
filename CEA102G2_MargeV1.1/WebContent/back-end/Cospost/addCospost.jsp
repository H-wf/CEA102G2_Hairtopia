<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.cospost.model.*"%>

<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService" />

<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>�ҵ{���i��Ʒs�W</title>
</head>
<style>
*{
	font-size:16px;
}
.h5{
	text-align:center;
}
</style>
<body>
	<form METHOD="POST" ACTION="<%=request.getContextPath()%>/cospost/cospost.do" name="form1" enctype="multipart/form-data">
		<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
		</c:if>
		<p class="lead mb-0">�ҵ{�s��:</p>
		<select size="1" name="cosNo">
			<c:forEach var="cosVO" items="${cosSvc.all}">
				<option value="${cosVO.cosNo}">${cosVO.cosName}
			</c:forEach>
		</select>
		<p class="lead mb-0">���i���e:</p>
		<textarea required class="mb-3 mt-0" name="cosPubCon" cols="30" rows="10" placeholder="�п�J���i���e"></textarea>
		<p class="lead mb-0">���i�ɶ�:</p>
		<input type="TEXT" name="cosPubTime" size="45"  id="f_date1">
		<div class="modal-footer">
			<input name="action" value="insert" type="hidden" >
			<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			<input type="submit" class="btn btn-primary" value="�s�W">
		</div>
	</form>

</body>
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/resource/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/resource/datetimepicker/jquery.datetimepicker.full.js"></script>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:true,       //timepicker:true,
 	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
 	       format:'Y-m-d H:i:s',
 	       value: '${cosPostVO.cosPubTime}',//format:'Y-m-d H:i:s',
 		    // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           //minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });

</script>              
</html>