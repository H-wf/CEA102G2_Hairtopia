<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Costype: Home</title>

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
   <tr><td><h3>IBM Costype: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Costype: Home</p>

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
  <li><a href="<%=request.getContextPath()%>/back-end/Costype/listAllCostype.jsp">List</a> all Costype.  <br><br></li>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coutype/coutype.do" >
        <b>輸入課程類別編號(如1):</b>
        <input type="text" name="cosTypeNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="dao" scope="page" class="com.coutype.model.CostypeService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coutype/coutype.do" >
       <b>選擇課程類別編號:</b>
       <select size="1" name="cosTypeNo">
         <c:forEach var="costypeVO" items="${dao.all}" > 
          <option value="${costypeVO.getCosTypeNo()}">${costypeVO.getCosTypeNo()}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>

</ul>

<h3>課程公告管理：</h3>

<ul>
  <li><a href="<%=request.getContextPath()%>/back-end/Costype/addCostype.jsp">Add</a> a new Costype.</li>
</ul>

</body>
</html>