<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Service: Home</title>
</head>
<body>

<h3>��Ƭd��:</h3>
<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font color='red'>�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/service/listAllService.jsp'>List</a> all Services. <br><br></li>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/service/service.do" >
        <b>��J�A�Ƚs�� :</b>
        <input type="text" name="serNo">
        <input type="submit" value="�e�X">
        <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>

  <jsp:useBean id="designerSvc" scope="page" class="com.designer.model.DesignerService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/service/service.do" >
       <b>��ܳ]�p�v�s��(�C�X��Ҧ��A��):</b>
       <select size="1" name="desNo">
         <c:forEach var="designerVO" items="${designerSvc.all}" > 
          <option value="${designerVO.desNo}">${designerVO.desNo}-${designerVO.desName}
         </c:forEach>   
       </select>
       <input type="submit" value="�e�X">
       <input type="hidden" name="action" value="queryByDesNo">
    </FORM>
  </li>
  
  

<h3>�s�W�A��</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/service/addService.jsp'>Add</a> a new Service.</li>
</ul>

</body>




</html>