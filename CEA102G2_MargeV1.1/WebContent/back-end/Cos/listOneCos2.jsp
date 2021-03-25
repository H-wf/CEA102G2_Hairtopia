<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.cos.model.*"%>
<%
  CosVO cosVO = (CosVO) request.getAttribute("cosVO"); 
%>
<jsp:useBean id="lecSvc" scope="page" class="com.lecturer.model.LecturerService" />
<jsp:useBean id="costypeSvc" scope="page" class="com.coutype.model.CostypeService" />
<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>課程明細</title>
</head>
<body>
<div>課程編號:${cosVO.cosNo}</div>
<div>課程名稱:${cosVO.cosName}</div>
<div>講師名稱:${lecSvc.getOneLecturer(cosVO.lecNo).lecName}</div>
<div>類別名稱:${costypeSvc.getOneCosType(cosVO.cosTypeNo).cosTypeName}</div>
<div>上課期間:<fmt:formatDate value="${cosVO.cosFrom}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${cosVO.cosTo}" pattern="yyyy-MM-dd"/></div>
<div>報名期間:<fmt:formatDate value="${cosVO.cosApplyFrom}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${cosVO.cosApplyTo}" pattern="yyyy-MM-dd"/></div>
<div>課程介紹:${cosVO.cosIntro}</div>
<div>課程地址:${cosVO.cosAdd}</div>
<div>報名總人數:${cosVO.cosCount}</div>
<div>評價總分數:${cosVO.cosRate}</div>
<div>課程狀態:${cosVO.cosStatus==true?"上架":"下架"}</div>
<div>最低人數:${cosVO.cosMinCount}</div>
<div>最高人數:${cosVO.cosMaxCount}</div>
<div>課程價格:${cosVO.cosPrice}</div>
<div>報名會員:</div>
<c:forEach var="coudetVO" items="${costypeSvc.getCosByCosTypeNo(cosVO.cosNo)}">
${memSvc.getOneMem(coudetVO.memNo).memName}<br>

</c:forEach>
<br>
</body>
</html>