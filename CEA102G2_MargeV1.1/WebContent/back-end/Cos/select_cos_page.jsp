<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>後台主頁：課程、講師相關管理</title>
    <meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>

<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>

<!-- Begin Page Content -->
	<div class="container-fluid">

<table id="table-1">
   <tr><td><h3>後台主頁：課程、講師相關管理</h3><h4></h4></td></tr>
</table>

<h3>課程、講師相關查詢：</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table width=100%>
<tr>
<td>課程相關</td>
<td></td>
<td>講師相關</td>
<tr>
<tr>
<td><li><a href="<%=request.getContextPath()%>/back-end/Cos/listAllCos.jsp">列出所有課程</a><br><br></li>

<li><a href="<%=request.getContextPath()%>/back-end/Cos/listAllCosApplyFrom.jsp">列出所有報名中課程</a><br><br></li>

<li><a href="<%=request.getContextPath()%>/back-end/Cos/listAllCosFrom.jsp">列出所有開課中課程</a><br><br></li></td>

<td><li><a href="<%=request.getContextPath()%>/back-end/Cosdetail/listAllCosdetail.jsp">列出所有修課明細</a><br><br></li>

<li><a href="<%=request.getContextPath()%>/back-end/Cospost/listAllCospost.jsp">列出所有課程公告</a><br><br></li>

<li><a href="<%=request.getContextPath()%>/back-end/Costype/listAllCostype.jsp">列出所有課程型態</a><br><br></li></td>

<td valign="top"><li><a href="<%=request.getContextPath()%>/back-end/Lecturer/listAll_lec.jsp">列出所有講師資訊</a><br><br></li></td>
</tr>
</table>
<ul>
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do">
        <b>輸入課程編號(如1)：</b>
        <input type="text" name="cosNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService"/>
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do">
       <b>查詢課程編號：</b>
       <select size="1" name="cosNo">
         <c:forEach var="cosVO" items="${cosSvc.all}" > 
          <option value="${cosVO.cosNo}">${cosVO.cosNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do">
       <b>查詢課程名稱：</b>
       <select size="1" name="cosNo">
         <c:forEach var="cosVO" items="${cosSvc.all}" > 
          <option value="${cosVO.cosNo}">${cosVO.cosName}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
  
  <jsp:useBean id="cosdetSvc" scope="page" class="com.coudet.model.CosdetService"/>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" >
       <b>查詢修課明細：</font></b>
       <select size="1" name="cosNo">
         <c:forEach var="cosVO" items="${cosdetSvc.all}" > 
          <option value="${cosVO.cosNo}">${cosVO.cosNo}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="getOne_For_Display">
     </FORM>
  </li>
  
  <jsp:useBean id="cospostSvc" scope="page" class="com.cospost.model.CospostService" />
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cospost/cospost.do" >
       <b>查詢課程公告：</font></b>
       <select size="1" name="cosPubNo">
         <c:forEach var="cospostVO" items="${cospostSvc.all}" > 
          <option value="${cospostVO.cosPubNo}">${cospostVO.cosPubCon}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="getOne_For_Display">
     </FORM>
  </li>

<jsp:useBean id="costypeSvc" scope="page" class="com.coutype.model.CostypeService"/>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coutype/coutype.do">
       <b>查詢課程類別：</font></b>
       <select size="1" name="cosTypeNo">
         <c:forEach var="costypeVO" items="${costypeSvc.all}" > 
          <option value="${costypeVO.cosTypeNo}">${costypeVO.cosTypeName}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="listCos_ByCosTypeNo_A">
     </FORM>
  </li>

<jsp:useBean id="lecSvc" scope="page" class="com.lecturer.model.LecturerService" />
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/lecturer/lecturer.do" >
       <b>查詢講師名稱：</font></b>
       <select size="1" name="lecNo">
         <c:forEach var="lecVO" items="${lecSvc.all}" > 
          <option value="${lecVO.lecNo}">${lecVO.lecName}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="getOne_For_Display">
     </FORM>
  </li>

</ul>	

<h3>多條件查詢：</font></h3>
<ul>  
  <li>   
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" name="form1">
        <b></b><br>
        <b>輸入課程編號：</b>
        <input type="text" name="cosNo" value="1"><br>
           
       <b>輸入課程關鍵字：</b>
       <input type="text" name="cosName" value="瘋狂理髮師"><br>
       
       <b>選擇課程類別：</b>
       <select size="1" name="cosTypeNo" >
          <option value="">
         <c:forEach var="costypeVO" items="${costypeSvc.all}" > 
          <option value="${costypeVO.getCosTypeNo()}">${costypeVO.getCosTypeName()}
         </c:forEach>
       </select><br>
       
       <b>選擇課程公告：</b>
       <select size="1" name="cosPubNo" >
          <option value="">
         <c:forEach var="costypeVO" items="${costypeSvc.all}" > 
          <option value="${costypeVO.getCosTypeNo()}">${costypeVO.getCosTypeName()}
         </c:forEach>
       </select><br>
       
       <b>選擇講師名字：</b>
       <select size="1" name="lecNo" >
          <option value="">
         <c:forEach var="LecturerVO" items="${lecSvc.all}" > 
          <option value="${LecturerVO.getLecNo()}">${LecturerVO.getLecName()}
         </c:forEach>
       </select><br>
		        
        <input type="submit" value="送出">
        <input type="hidden" name="action" value="listCos_ByCompositeQuery">
     </FORM>
  </li>
</ul>

<h3>課程、講師相關新增：</h3>
<table width=100%>
<tr>
<td>課程相關</td>
<td></td>
<td>講師相關</td>
<tr>
<tr>
<td><li><a href="<%=request.getContextPath()%>/back-end/Cos/addCos.jsp">新增課程內容</a></li>
<li><a href='<%=request.getContextPath()%>/back-end/Costype/addCosdetail.jsp'>新增課程明細</a></li>
<li><a href='<%=request.getContextPath()%>/back-end/Costype/addCostype.jsp'>新增課程類型</a></li>
<li><a href='<%=request.getContextPath()%>/back-end/Cospost/addCospost.jsp'>新增課程公告</a></li></td>
<td></td>
<td valign="top">
<li><a href='<%=request.getContextPath()%>/back-end/Lecturer/addLec.jsp'>新增講師</a></li>
</td>
</table>


</body>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

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
</div>
<!-- Page Content END -->
                
<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>
</body>

</html>