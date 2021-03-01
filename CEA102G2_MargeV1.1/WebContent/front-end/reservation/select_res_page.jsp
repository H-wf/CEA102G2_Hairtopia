<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Reservation: Home</title>
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
  <li><a href='<%=request.getContextPath()%>/back-end/reservation/listAllRes.jsp'>List</a> all Reservations. <br><br></li>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" >
        <b>��J�w���s�� :</b>
        <input type="text" name="resNo">
        <input type="submit" value="�e�X">
        <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" >
        <b>��J�|���s�� :</b>
        <input type="text" name="memNo">
        <input type="submit" value="�e�X">
        <input type="hidden" name="action" value="queryByMemNo">
    </FORM>
  </li>

  <jsp:useBean id="designerSvc" scope="page" class="com.designer.model.DesignerService" />

   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" >
       <b>��ܳ]�p�v�s��(�C�X��Ҧ��w��):</b>
       <select size="1" name="desNo">
         <c:forEach var="designerVO" items="${designerSvc.all}" > 
          <option value="${designerVO.desNo}">${designerVO.desNo}-${designerVO.desName}
         </c:forEach>   
       </select>
       <input type="submit" value="�e�X">
       <input type="hidden" name="action" value="queryByDesNo">
    </FORM>
  </li>

  <li>
  <b>�s�W�w��</b>
  <a href='<%=request.getContextPath()%>/front-end/reservation/addRes.jsp'>Add</a> a new Res.
  </li>

</ul>
</body>




</html>