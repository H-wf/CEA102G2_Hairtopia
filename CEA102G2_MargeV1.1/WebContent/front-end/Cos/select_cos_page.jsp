<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Cos: Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>�C�X�Ҧ��ҵ{���A</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Cos: Home</p>

<h3>�ҵ{�d��:</h3>
	
<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do">
        <b>��J�ҵ{�s��(�p1)�G</b>
        <input type="text" name="cosNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    </FORM>
 </li>



</body>
<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
var somedate1 = new Date();
$('#f_date1').datetimepicker({
 beforeShowDay: function(date) {
  if (  date.getYear() <  somedate1.getYear() || 
          (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
            ) {
               return [false, ""]
           }
           return [true, ""];
   }});
   
var somedate2 = new Date();
$('#f_date2').datetimepicker({
 beforeShowDay: function(date) {
  if (  date.getYear() <  somedate2.getYear() || 
          (date.getYear() == somedate2.getYear() && date.getMonth() <  somedate2.getMonth()) || 
	           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() < somedate2.getDate())
            ) {
               return [false, ""]
           }
           return [true, ""];
   }});


</script>   

</html>

