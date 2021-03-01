<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Cosdetail: Home</title>

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
   <tr><td><h3>IBM Cosdetail: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Cosdetail: Home</p>

<h3>課程類型查詢:</h3>
	
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
  <li><a href="<%=request.getContextPath()%>/back-end/Cosdetail/listAllCosdetail.jsp">List</a> all Cosdetail.  <br><br></li>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" >
        <b>輸入課程編號(如1):</b>
        <input type="text" name="cosNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="dao" scope="page" class="com.coudet.model.CosdetService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" >
       <b>選擇課程編號:</b>
       <select size="1" name="cosNo">
         <c:forEach var="cosdetVO" items="${dao.all}" > 
          <option value="${cosdetVO.getCosNo()}">${cosdetVO.getCosNo()}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>

</ul>

<h3>課程明細管理：</h3>

<ul>
  <li><a href="<%=request.getContextPath()%>/back-end/Cosdetail/addCosdetail.jsp">Add</a> a new Cosdetail.</li>
</ul>

</body>
</html>