<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Salon: Home</title>
</head>
<body>

<table id="table-1">
   <tr><td><h3>IBM Salon: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Salon: Home</p>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllSalon.jsp'>List</a> all Salons.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/salon/salon.do" >
        <b>輸入髮廊編號 :</b>
        <input type="text" name="salNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="salonSvc" scope="page" class="com.salon.model.SalonService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/salon/salon.do" >
       <b>選擇髮廊編號:</b>
       <select size="1" name="salNo">
         <c:forEach var="salonVO" items="${salonSvc.all}" > 
          <option value="${salonVO.salNo}">${salonVO.salNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/salon/salon.do" >
       <b>選擇髮廊名稱:</b>
       <select size="1" name="salNo">
         <c:forEach var="salonVO" items="${salonSvc.all}" > 
          <option value="${salonVO.salNo}">${salonVO.salName}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>髮廊管理</h3>

<ul>
  <li><a href='addSalon.jsp'>Add</a> a new Salon.</li>
</ul>

</body>
</html>