<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM CosPost: Home</title>

<style>
  table#table-1 {
	width: 4500px;
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
   <tr><td><h3>IBM CosPost: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM CosPost: Home</p>

<h3>�ҵ{���i�d��:</h3>
	
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
  <li><a href="<%=request.getContextPath()%>/back-end/Cospost/listAllCospost.jsp">List</a> all CosPosts.  <br><br></li>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cospost/cospost.do" >
        <b>��J�ҵ{���i�s��(�p1):</b>
        <input type="text" name="cosPubNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    </FORM>
  </li>

  <jsp:useBean id="dao" scope="page" class="com.cospost.model.CospostService" />
   
  <li>
     <FORM METHOD="get" ACTION="<%=request.getContextPath()%>/cospost/cospost.do" >
       <b>��ܽҵ{���i�s��:</b>
       <select size="1" name="cosPubNo">
         <c:forEach var="cospostVO" items="${dao.all}" > 
          <option value="${cospostVO.getCosPubNo()}">${cospostVO.getCosPubNo()}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li>

</ul>

<h3>�ҵ{���i�޲z�G</h3>

<ul>
  <li><a href="<%=request.getContextPath()%>/back-end/Cospost/addCospost.jsp">Add</a> a new CosPost.</li>
</ul>

</body>
</html>