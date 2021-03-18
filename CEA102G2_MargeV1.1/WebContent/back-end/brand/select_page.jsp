<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Hairtopia Brand: Home</title>
    <meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>

<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>

<!-- Begin Page Content -->
	<div class="container-fluid">
		<table>
			<tr><td><h3>Hairtopia Brand: Home</h3></td></tr>
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
  <li><a href='listAllBrand.jsp'>List</a> all Brands<h4>(byDAO)</h4></li>
  <br>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/brand/brand.do" >
        <b>輸入品牌編號:</b>
        <input type="text" name="braNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">                   <h4>(資料格式驗證  by Controller ).</h4> 
    </FORM>
  </li>


  <jsp:useBean id="dao" scope="page" class="com.brand.model.BrandService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/brand/brand.do" >
       <b>選擇品牌編號:</b>
       <select size="1" name="braNo">
         <c:forEach var="brandVO" items="${dao.all}" > 
          <option value="${brandVO.braNo}">${brandVO.braNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/brand/brand.do" >
       <b>選擇品牌名稱:</b>
       <select size="1" name="braNo">
         <c:forEach var="brandVO" items="${dao.all}" > 
          <option value="${brandVO.braNo}">${brandVO.braName}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>

	<h3>品牌管理</h3>

	<ul>
		<li><a href='addBrand.jsp'>Add</a> a new Brand.</li>
	</ul>


</div>
<!-- Page Content END -->
                
<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>
</body>

</html>