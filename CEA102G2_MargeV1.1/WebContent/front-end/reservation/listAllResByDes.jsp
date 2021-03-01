<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.reservation.model.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>設計師預約資料 - listAllResByDesNo.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<h2>設計師名稱</h2>
	<jsp:useBean id="designerSvc" scope="page" class="com.designer.model.DesignerService" />
	 ${designerSvc.getOneDesByDesNo(desNo).desName}
	<table class="table table-striped">
	<tr>
		<th>預約編號</th>
		<th>會員編號</th>
		<th>服務項目</th>
		<th>預約產生日</th>
		<th>預約時間</th>
		<th>預約狀態</th>
		<th>預約評價</th>
		<th>預約驗證碼</th>
		<th>預約金額</th>
		<th>預約操作</th>
	</tr>
	<jsp:useBean id="serviceSvc" scope="page" class="com.service.model.ServiceService" />
 
	
	<c:forEach var="resVO" items="${list}" >
		
		<tr>
			<td><a href="res.do?resNo=${resVO.resNo}&action=getOne_For_Display_Of_Des">${resVO.resNo}</a></td>
			<td>${resVO.memNo}改名字</td>
			<td><c:forEach var="serviceVO" items="${serviceSvc.all}">
					<c:if test="${serviceVO.serNo==resVO.serNo}">
	            	${serviceVO.serNo}-${serviceVO.serName}
            		</c:if>
				</c:forEach></td>
			<td><fmt:formatDate value="${resVO.resProDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>
				<fmt:formatDate value="${resVO.resDate}" pattern="yyyy-MM-dd"/>
				<c:set var="serTime" value="${resVO.resTime}"/>
				<fmt:formatNumber type="number" value="${((resTime*30 -(resTime*30%60)))/60}"  var="hour"/>
				${hour}:${(serTime*30 %60 == 0)? "00" :"30" }
			</td>
			<td>
			<c:choose>
				<c:when test="${resVO.resStatus == 0}">
				預約待確認
				</c:when>
				<c:when test="${resVO.resStatus == 1}">
				預約成功
				</c:when>
				<c:when test="${resVO.resStatus == 2}">
				已到店認證
				</c:when>
				<c:when test="${resVO.resStatus == 3}">
				服務完成
				</c:when>
				<c:when test="${resVO.resStatus == 4}">
				無法提供服務
				</c:when>
				<c:when test="${resVO.resStatus == 5}">
				會員取消
				</c:when>
				<c:otherwise>
				會員未到
				</c:otherwise>
			</c:choose>
			</td>
			<td>${resVO.resCom}</td> 
			<td>
				<c:choose>
				<c:when test="${resVO.resStatus == 0}">
				驗證碼未產生
				</c:when>
				<c:when test="${resVO.resStatus == 1}">
				驗證碼已產生
				</c:when>
				<c:when test="${resVO.resStatus == 4}">
				預約取消
				</c:when>
				<c:otherwise>
				${resVO.resCode}
				</c:otherwise>
			</c:choose></td>
			<td>${resVO.resPrice}</td>
			<td>
			<c:choose>
				<c:when test="${resVO.resStatus == 0}">
				<table>
				<tr>
				<td><FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" style="margin-bottom: 0px;">
			    	<input type="submit" value="確認">
			    	<input type="hidden" name="resNo"  value="${resVO.resNo}">
			    	<input type="hidden" name="action"	value="getOne_For_Update_Confirm"></FORM>
			    </td>
			    <td><FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" style="margin-bottom: 0px;">
			    	<input type="submit" value="取消">
			    	<input type="hidden" name="resNo"  value="${resVO.resNo}">
			   		<input type="hidden" name="action" value="cancelByDes"></FORM></td>
			   	</tr>
			   		</table>
			    </c:when>
				<c:when test="${resVO.resStatus == 1}">
				預約已確認
			    </c:when>
				<c:when test="${resVO.resStatus == 2}">
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" style="margin-bottom: 0px;">
			    	<input type="text">
			    	<input type="submit" value="送出驗證碼">
			    	<input type="hidden" name="resNo"  value="${resVO.resNo}">
			   		<input type="hidden" name="action" value="cancelByDes"></FORM>
			    </c:when>
			    <c:when test="${resVO.resStatus == 4}">
				預約已取消
			    </c:when>
			    <c:otherwise>
				還沒寫
			    </c:otherwise>
			    
			 </c:choose>
				
			</td>
			
		</tr>
	</c:forEach>
</table>
</body>
</html>