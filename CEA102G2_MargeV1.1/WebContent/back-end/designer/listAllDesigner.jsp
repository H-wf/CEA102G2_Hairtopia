<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.designer.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    DesignerService designerSvc = new DesignerService();
    List<DesignerVO> list = designerSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有設計師資料for後台 - listAllDesigner.jsp</title>
<style type="text/css">

img{
 width:100px;
}

</style>

</head>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>設計師編號</th>
		<th>會員編號</th>
		<th>服務沙龍編號</th>
		<th>設計師名稱</th>
		<th>設計師簡介</th>
		<th>方案到期日</th>
		<th>評價總人數</th>
		<th>評價總分</th>
		<th>審核狀態</th>
		<th>班表</th>
		<th>設計師照片</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	
	<c:forEach var="designerVO" items="${list}">
		<tr>
			<td>${designerVO.getDesNo()}</td>
			<td>${designerVO.getMemNo()}</td>
			<td>${designerVO.getSalNo()}</td>
			<td>${designerVO.getDesName()}</td>
			<td>${designerVO.getDesInfor()}</td>
			<td>${designerVO.getDesEndDate()}</td>
			<td>${designerVO.getDesCount()}</td>
			<td>${designerVO.getDesTolScore()}</td>
			<td>
			<c:if test="${designerVO.desStatus == 0}">
				未審核
			</c:if>
			<c:if test="${designerVO.desStatus == 1}">
				正常
			</c:if>
			
			<c:if test="${designerVO.desStatus == 2}">
			    停權
			</c:if>
			<c:if test="${designerVO.desStatus == 3}">
				超過方案到期日
			</c:if>
			</td>
			<% String weekArray[] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
			   pageContext.setAttribute("weekArray",weekArray);%>
			<td>
				<table>
				<c:forEach var="myData" begin="0" end="27" step="4">
				<c:set var="i" value="${myData/4}"/>
				<tr>
				<td>${weekArray[i]}</td>
				<c:set var="desSchedule" value="${designerVO.desSchedule}"/>
				<fmt:parseNumber var="start" value="${desSchedule.substring(myData,myData+2)}" integerOnly="true"/>
				<c:set var="startHour" value="${((start*30 -(start*30%60)))/60}" />
				<td>
				<fmt:formatNumber value="${startHour}"  type="number" maxFractionDigits="0" />: ${(start*30 %60 == 0)? "00" :"30"}
				</td>
				<fmt:parseNumber var="end" value="${desSchedule.substring(myData+2,myData+4)}" integerOnly="true"/>
				<c:set var="endHour" value="${((end*30 -(end*30%60)))/60}" />
				<td>~</td><td>
				<fmt:formatNumber value="${endHour}"  type="number" maxFractionDigits="0" />: ${(end*30 %60 == 0)? "00" :"30"}
				</td>
				</tr>
				</c:forEach>
				</table>

			</td>
			<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=Designer&column=desPic&idname=desNo&id=${designerVO.desNo}" alt='沒有圖片' /></td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/designer/designer.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="desNo"  value="${designerVO.desNo}">
			     <input type="hidden" name="action"	value="getOne_For_Update_Back"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/designer/designer.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="desNo"  value="${designerVO.desNo}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
		</c:forEach>
</table>

</body>
</html>