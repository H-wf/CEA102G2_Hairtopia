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
   <tr><td><h3>IBM Cos: Home</h3><h4>( MVC )</h4></td></tr>
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

<ul>
  <li><a href="<%=request.getContextPath()%>/back-end/Cos/listAllCos.jsp">List</a> all Cos.  <br><br></li>

<li><a href="<%=request.getContextPath()%>/back-end/Cos/listAllCosApplyFrom.jsp">List</a> all CosApplyFrom.  <br><br></li>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" >
        <b>��J�ҵ{�s��(�p1):</b>
        <input type="text" name="cosNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    </FORM>
  </li>

  <jsp:useBean id="dao" scope="page" class="com.cos.model.CosService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" >
       <b>��ܽҵ{�s��:</b>
       <select size="1" name="cosNo">
         <c:forEach var="cosVO" items="${dao.all}" > 
          <option value="${cosVO.cosNo}">${cosVO.cosNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" >
       <b>��ܽҵ{�W��:</b>
       <select size="1" name="cosName">
         <c:forEach var="cosVO" items="${dao.all}" > 
          <option value="${cosVO.cosNo}">${cosVO.cosName}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
     </FORM>
  </li>
  
  <jsp:useBean id="costypeSvc" scope="page" class="com.coutype.model.CostypeService" />
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coutype/coutype.do" >
       <b><font color=orange>��ܽҵ{���O:</font></b>
       <select size="1" name="cosTypeNo">
         <c:forEach var="costypeVO" items="${costypeSvc.all}" > 
          <option value="${costypeVO.cosTypeNo}">${costypeVO.cosTypeName}
         </c:forEach>   
       </select>
       <input type="submit" value="�e�X">
       <input type="hidden" name="action" value="listCos_ByCosTypeNo_A">
     </FORM>
  </li>

</ul>

<%-- �U�νƦX�d��-�H�U���-�i�H�N�W�� --%>
<ul>  
  <li>   
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" name="form1">
        <b><font color=blue>�U�νƦX�d��:</font></b> <br>
        <b>��J�ҵ{�s��:</b>
        <input type="text" name="cosNo" value="1"><br>
           
       <b>��J�ҵ{�W��:</b>
       <input type="text" name="cosName" value="�ƨg�z�v�v"><br>
       
       <b>��ܽҵ{���O:</b>
       <select size="1" name="cosTypeNo" >
          <option value="">
         <c:forEach var="costypeVO" items="${costypeSvc.all}" > 
          <option value="${costypeVO.getCosTypeNo()}">${costypeVO.getCosTypeName()}
         </c:forEach>
       </select><br>
           
       <b>�}�Ҥ��:</b>
	   <input name="cosFrom" id="f_date1" type="text">
	   <br>
	   <b>���W���:</b>
	   <input name="cosApplyFrom" id="f_date2" type="text">
		        
        <input type="submit" value="�e�X">
        <input type="hidden" name="action" value="listCos_ByCompositeQuery">
     </FORM>
  </li>
</ul>

<h3>�s�W�ҵ{���ӡG</h3>
<ul>
  <li><a href="<%=request.getContextPath()%>/back-end/Cos/addCos.jsp">Add</a> a new Cos.</li>
</ul>

<h3><font color=orange>�ҵ{�����޲z</font></h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/back-end/Costype/listAllCostype.jsp'>List</a> all Costype. </li>
</ul>



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

