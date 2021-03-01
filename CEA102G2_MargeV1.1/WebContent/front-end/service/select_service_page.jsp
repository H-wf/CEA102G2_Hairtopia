<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Service: Home</title>
</head>
<body>

<h3>資料查詢:</h3>
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font color='red'>請修正以下錯誤:</font>
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
        <b>輸入服務編號 :</b>
        <input type="text" name="serNo">
        <input type="submit" value="送出">
        <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>

  <jsp:useBean id="designerSvc" scope="page" class="com.designer.model.DesignerService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/service/service.do" >
       <b>選擇設計師編號(列出其所有服務):</b>
       <select size="1" name="desNo">
         <c:forEach var="designerVO" items="${designerSvc.all}" > 
          <option value="${designerVO.desNo}">${designerVO.desNo}-${designerVO.desName}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="queryByDesNo">
    </FORM>
  </li>
  
  

<h3>新增服務</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/service/addService.jsp'>Add</a> a new Service.</li>
</ul>

</body>




</html>