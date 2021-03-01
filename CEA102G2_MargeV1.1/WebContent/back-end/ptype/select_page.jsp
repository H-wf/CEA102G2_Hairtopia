<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Hairtopia Ptype: Home</title>
</head>
<body>
<table>
	<tr><td><h3>Hairtopia Ptype: Home</h3></td></tr>
</table>
	
<%-- 錯誤列表 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllPtype.jsp'>List</a> all Ptypes<h4>(byDAO)</h4></li>
  <br>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ptype/ptype.do" >
        <b>輸入商品類別編號:</b>
        <input type="text" name="ptypeNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">                   <h4>(資料格式驗證  by Controller ).</h4> 
    </FORM>
  </li>


  <jsp:useBean id="dao" scope="page" class="com.ptype.model.PtypeService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ptype/ptype.do" >
       <b>選擇商品類別編號:</b>
       <select size="1" name="ptypeNo">
         <c:forEach var="ptypeVO" items="${dao.all}" > 
          <option value="${ptypeVO.ptypeNo}">${ptypeVO.ptypeNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ptype/ptype.do" >
       <b>選擇商品類別名稱:</b>
       <select size="1" name="ptypeNo">
         <c:forEach var="ptypeVO" items="${dao.all}" > 
          <option value="${ptypeVO.ptypeNo}">${ptypeVO.ptypeName}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>

	<h3>商品類別管理</h3>

	<ul>
		<li><a href='addPtype.jsp'>Add</a> a new Ptype.</li>
	</ul>


	
</body>
</html>