<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cos.model.*"%>

<%
    CosService cosSvc = new CosService();
    List<CosVO> list = cosSvc.getAllCosApplyFrom();
    pageContext.setAttribute("list",list);
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>所有課程資料</title>
    <meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
</head>

<style>

#mytb{
	font-size:0.6rem;
}

#mytb td{
	height:30%;
}
#table-1 h4{
	color:black; font-family: "Open Sans", Arial, sans-serif;
}

</style>

<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">

<table id="table-1">
	<tr>
	<td><h3>所有報名中課程</h3></td>
	<td><h5><a href="<%=request.getContextPath()%>/back-end/Cos/select_cos_page.jsp">回後台主頁</a></h5></td>
	</tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>


	<%
			for (CosVO cosVO : list) {
				byte[] cosPic = cosVO.getCosPic();
				Base64.Encoder encoder = Base64.getEncoder();
				String src = "data:image/jpeg;base64,";
				if (cosPic != null){
					src += encoder.encodeToString(cosPic);	
				}else{
					src="/back-end/resource/images/back1.gif";
				}
			}
		%>
	
	<%@ include file="/back-end/pages/page1.file"%> 

	<jsp:useBean id="costypeSvc" scope="page" class="com.coutype.model.CostypeService"/>
	<jsp:useBean id="lecSvc" scope="page" class="com.lecturer.model.LecturerService"/>

<div class="container bg-dark text-white">
	<c:forEach var="cosVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">

  <div class="row">
    <div class="col-2">
     <img width="100" src="<%=request.getContextPath()%>/PicFinder?pic=1&table=course&column=cosPic&idname=cosNo&id=${cosVO.cosNo}" alt='沒有圖片' />
    </div>
    <div class="col-2">
      	課程編號:${cosVO.cosNo} <br/>
      	講師編號:${lecSvc.getOneLecturer(cosVO.lecNo).lecName} <br/>
      	類別編號:${costypeSvc.getOneCosType(cosVO.cosTypeNo).cosTypeName} <br/>
      	<br>上課起:<fmt:formatDate value="${cosVO.cosFrom}" type="both"/><br/>
      	<br>上課迄:<fmt:formatDate value="${cosVO.cosTo}" type="both"/><br/>
    </div>
    <div class="col-2" >
      	課程介紹:${cosVO.cosIntro} <br/>
      	課程地址:${cosVO.cosAdd} <br/>
      	報名總人數:${cosVO.cosCount} <br/>
      	評價總分數:${cosVO.cosRate} <br/>
      	課程狀態:${cosVO.cosStatus==true?"上架":"下架"} <br/>
    </div>
    <div class="col-2">
      	最低人數:${cosVO.cosMinCount} <br/>
      	最高人數:${cosVO.cosMaxCount} <br/>
      	課程價格:${cosVO.cosPrice} <br/>
		<br>報名開始日:<fmt:formatDate value="${cosVO.cosApplyFrom}" type="both"/><br/>
      	<br>報名截止日:<fmt:formatDate value="${cosVO.cosApplyTo}" type="both"/><br/>
    	課程名稱:${cosVO.cosName} <br/>
    </div>
    <div class="col-2">
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" style="margin-bottom: 0px;" >
			     <input type="submit" value="修改">
			     <input type="hidden" name="cosNo"  value="${cosVO.cosNo}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>

			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/cos/cos.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>" >
			     <input type="hidden" name="cosNo"  value="${cosVO.cosNo}">
			     <input type="hidden" name="action" value="delete"></FORM>
    </div>
    <div class="col-10">
		 課程介紹:${cosVO.cosIntro}
    </div>
  </div>
  <div><p>
  <div><p>
  </div>
  <div><p>
  </div>
  </div>
</c:forEach>
</div>

<%@ include file="/back-end/pages/page2.file" %>

</div>
<!-- Page Content END -->
                
<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>
</body>

</html>