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
<title>�ҵ{��ƭק�</title>
</head>
<body>
<form METHOD="POST" ACTION="<%=request.getContextPath()%>/cospost/cospost.do" name="form1"> 
	<%-- ���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<p class="lead mb-0"><label>�ҵ{���i�s��:<i>${cospostVO.cosPubNo}</i></label></p>	
	<p class="lead mb-0"><label for="cosNo">�ҵ{�W��:</label></p>
	<select class="form-control form-control-sm" style="width:300px;" id="cosNo" size="1" name="cosNo" >
		<c:forEach var="cosVO" items="${cosSvc.all}" > 
          	<option value="${cosVO.cosNo}"${(cosVO.cosNo==cospostVO.cosNo)?'selected':'' }>${cosVO.cosName}
         </c:forEach>
	</select>
	<p class="lead mb-0"><label for="cosPubCon">���i���e:</label></p>
	<textarea required class="form-control mb-3" id="cosPubCon" name="cosPubCon" cols="30" rows="10">${cospostVO.cosPubCon}</textarea>		
	<p class="lead mb-0"><label for="f_date2">�ҵ{���i���:</label></p>
	<input  class="form-control form-control-sm mb-3" style="width:200px;" name="cosPubTime" id="f_date2" type="text" autocomplete="off" value="${cospostVO.cosPubTime}">
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		<input type="submit" class="btn btn-primary" value="�ק�">
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="cosPubNo" value="${cospostVO.cosPubNo}">
	</div>
</form>


<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->
<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:true,       //timepicker:true,
 	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
 	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
 		   value: '<%=cospostVO.getCosPubTime()%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           //minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });

</script>
</body>        
</html>       