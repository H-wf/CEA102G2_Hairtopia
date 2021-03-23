<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.ordermaster.model.*"%>

<jsp:useBean id="orddSvc" scope="page" class="com.orderdetail.model.OrderDetailService" />
<jsp:useBean id="proSvc" scope="page" class="com.product.model.ProductService" />
<jsp:useBean id="ptypeSvc" scope="page" class="com.ptype.model.PtypeService" />
<jsp:useBean id="brandSvc" scope="page" class="com.brand.model.BrandService" />
<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService" />

<html>
<head><title>訂單明細</title>

</head>
<style>

.paper{
 	border:0.1px solid #969592;
 	box-shadow: 12px 12px 7px rgba(150, 149, 146, 0.6);
 } 
 .line{ 
 	border-bottom:solid #BDB58C; 
 	font-size:22px; 
 	color:#333333;
 } 
</style>
<body>
<!-- Begin Page Content -->
<div class="container-fluid p-1 ">
	
		
		<c:forEach var="ordermasterVO" items="${list}">
		
			<div class="line">訂單資訊</div>
			<div class="row">
				<div class="col-6">
					<ul>
						<li>訂單編號:&emsp;${ordermasterVO.ordNo}
						<li>訂單狀態:&emsp;
							<c:choose>
								<c:when test="${ordermasterVO.ordStatus == 0}">
								未出貨
								</c:when>
								<c:when test="${ordermasterVO.ordStatus == 1}">
								已出貨
								</c:when>
								<c:when test="${ordermasterVO.ordStatus == 2}">
								已結案
								</c:when>
								<c:when test="${ordermasterVO.ordStatus == 3}">
								訂單取消
								</c:when>
								<c:otherwise>
								退貨
								</c:otherwise>
							</c:choose>
					</ul>
				</div>
				<div class="col-6">
					<ul>
						<li>訂購日期:&emsp;<fmt:formatDate pattern="yyyy-MM-dd" value="${ordermasterVO.ordDate}" />
						<li>付款方式:&emsp;信用卡
					</ul>
				</div>						
			</div>
			<div class="line">購買清單</div>	
			<table class="table table-2">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">商品圖片</th>
						<th scope="col">商品名稱</th>
						<th scope="col">商品類別</th>
						<th scope="col">品牌名稱</th>
						<th scope="col">價格</th>
						<th scope="col">數量</th>
						<th scope="col">小計</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="i" value="0" />
			        <c:forEach var="orddVO" items="${orddSvc.all}">			      				      		
			      	<c:if test="${orddVO.ordNo == ordermasterVO.ordNo}">
			      	<c:set var="i" value="${i+1}" />
					<tr>
						<th scope="row">${i}</th>
						<td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=product&column=proMpic&idname=proNo&id=${orddVO.proNo}"alt='沒有圖片' width="50" height="40"></td>
						<td>${proSvc.getOneProduct(orddVO.proNo).proName}</td>
						<td>${ptypeSvc.getOnePtype(proSvc.getOneProduct(orddVO.proNo).ptypeNo).ptypeName}</td>
						<td>${brandSvc.getOneBrand(proSvc.getOneProduct(orddVO.proNo).braNo).braName}</td>
						<td>${proSvc.getOneProduct(orddVO.proNo).proPrice}</td>
						<td>${orddVO.ordDetAmt}</td>
						<td>${orddVO.ordDetPrice}</td>
					</tr>
					</c:if>						   
			      	</c:forEach>
			      	<tr>
					    <th scope="row"></th>
					    <td></td>
					    <td></td>
					    <td></td>
					    <td></td>
					    <td></td>
						<td>TOTAL</td>
						<td>NT$${ordermasterVO.ordAmt}</td>
					</tr>					      		  
				</tbody>
			</table>
				<div class="row">
					<div class="col-6">
					<div class="line">訂購人資訊</div>
						<ul>
							<li>訂購人姓名:&emsp;${memSvc.getOneMem(ordermasterVO.memNo).memName}
							<li>訂購人信箱:&emsp;${memSvc.getOneMem(ordermasterVO.memNo).memEmail}
							<li>訂購人手機:&emsp;${memSvc.getOneMem(ordermasterVO.memNo).memPhone}
							<li>訂購人地址:&emsp;${memSvc.getOneMem(ordermasterVO.memNo).memAddr}
						</ul>
					</div>
					<div class="col-6" >
					<div class="line">收件人資訊</div>
						<ul>
							<li>收件人姓名:&emsp;${ordermasterVO.ordName}
							<li>收件人信箱:&emsp;${ordermasterVO.ordEmail}
							<li>收件人手機:&emsp;${ordermasterVO.ordPhone}
							<li>收件人地址:&emsp;${ordermasterVO.ordAddr}
						</ul>
					</div>
				</div>	
		
		</c:forEach>
	</div>




<!-- Page Content END -->
<!-- <h4> -->
<!-- ☆萬用複合查詢  - 可由客戶端 select_page.jsp 隨意增減任何想查詢的欄位<br> -->
<!-- ☆此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能</h4> -->
<!-- <table id="table-1"> -->
<!-- 	<tr><td> -->
<!-- 		 <h3>所有商品資料 - listAllOrderMaster.jsp</h3> -->
<%-- 		 <h4><a href="<%=request.getContextPath()%>/back-end/ordermaster/select_page.jsp">>回首頁</a></h4> --%>
<!-- 	</td></tr> -->
<!-- </table> -->


<!-- <table> -->
<!-- 	<tr> -->
<!-- 		<th>訂單編號</th> -->
<!-- 		<th>會員</th> -->
<!-- 		<th>訂購日期</th> -->
<!-- 		<th>訂單狀態</th> -->
<!-- 		<th>訂單金額</th> -->
<!-- 	</tr> -->
<%-- 	<c:forEach var="ordermasterVO" items="${listOrderMasters_ByCompositeQuery}"> --%>
<!-- 		<tr> -->
<%-- 			<td>${ordermasterVO.ordNo}</td> --%>
<!-- 			<td> -->
<%-- 				<c:forEach var="memVO" items="${memSvc.all}"> --%>
<%--                     <c:if test="${ordermasterVO.memNo==memVO.memNo}"> --%>
<%-- 	                    ${memVO.memNo}【${memVO.memName}】 --%>
<%--                     </c:if> --%>
<%--                 </c:forEach> --%>
<!--             </td> -->
<%-- 			<td>${ordermasterVO.ordDate}</td> --%>
<!-- 			<td> -->
<%-- 				<c:if test="${ordermasterVO.ordStatus==0}">未出貨</c:if> --%>
<%-- 				<c:if test="${ordermasterVO.ordStatus==1}">已出貨</c:if> --%>
<%-- 				<c:if test="${ordermasterVO.ordStatus==2}">已結案</c:if> --%>
<%-- 				<c:if test="${ordermasterVO.ordStatus==3}">訂單取消</c:if> --%>
<%-- 				<c:if test="${ordermasterVO.ordStatus==9}">退貨</c:if> --%>
<!-- 			</td>				 -->
<%-- 			<td>${ordermasterVO.ordAmt}</td>	 --%>
			
<!-- 			<td> -->
<%-- 				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ordermaster/ordermaster.do" style="margin-bottom: 0px;"> --%>
<!-- 					<input type="submit" value="修改">  -->
<%-- 					<input type="hidden" name="ordNo" value="${ordermasterVO.ordNo}"> --%>
<!-- 					<input type="hidden" name="action" value="getOne_For_Update"> -->
<!-- 				</FORM> -->
<!-- 			</td> -->
<!-- 			<td> -->
<%-- 				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ordermaster/ordermaster.do" style="margin-bottom: 0px;"> --%>
<!-- 					<input type="submit" value="刪除">  -->
<%-- 					<input type="hidden" name="ordNo" value="${ordermasterVO.ordNo}"> --%>
<!-- 					<input type="hidden" name="action" value="delete"> -->
<!-- 				</FORM> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<%-- 	</c:forEach> --%>
<!-- </table> -->

</body>
</html>