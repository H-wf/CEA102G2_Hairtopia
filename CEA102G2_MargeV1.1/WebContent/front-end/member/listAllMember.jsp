<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	MemService memSvc = new MemService();
	List<MemVO> list = memSvc.getAll();
	pageContext.setAttribute("list", list);
%>


<html>
<head>
<title>所有會員資料 - listAllMem.jsp</title>

<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>

<style>
table {
	width: 100%;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}
.headshot{
	width : 75px;
	height: auto;
}
</style>

</head>
<body bgcolor='white'>

	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有新聞資料 - listAllMemNews.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/front-end/member/select_page.jsp"><img src="<%=request.getContextPath()%>/resource/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<table>
		<tr>
			<th>會員編號</th>
			<th>會員姓名</th>
			<th>性別</th>
			<th>自介</th>
			<th>信箱</th>
			<th>密碼</th>
			<th>電話</th>
			<th>地址</th>
			<th>錢包餘額</th>
			<th>狀態</th>
			<th>停權到期日</th>
			<th>啟用碼</th>
			<th>大頭照</th>
			<th>修改</th>
			<th>刪除</th>
			
		</tr>
		<%@ include file="/resource/pages/page1.file"%>
		<c:forEach var="memVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<td>${memVO.memNo}</td>
				<td>${memVO.memName}</td>
				<td>${(memVO.memGender == 0	)?"": (memVO.memGender == 1) ? "男" : "女"}</td>
				<td>${memVO.memInform}</td>
				<td>${memVO.memEmail}</td>
				<td>${memVO.memPswd}</td>
				<td>${memVO.memPhone}</td>
				<td>${memVO.memAddr}</td>
				<td>${memVO.memBal}</td>
				<td>${(memVO.memStatus == 0	)? "未驗證": (memVO.memStatus == 1) ? "正常" : "停權"}</td>
				<td><fmt:formatDate value="${memVO.memEndDate}" pattern="yyyy-MM-dd" /></td> 
				<td>${memVO.memCode}</td>
				<td><img class="headshot" src="<%=request.getContextPath()%>/showImges.do?tableName=member&picColumn=memPic&pkColumn=memNo&memNo=${memVO.memNo}"></td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/member/mem.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改"> 
						<input type="hidden" name="memNo" value="${memVO.memNo}">
						<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> <!--送出本網頁的路徑給Controller-->
						<input type="hidden" name="whichPage" value="<%=whichPage%>"> <!--送出當前是第幾頁給Controller-->
						<input type="hidden" name="action" value="getOne_For_Update">
						 
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/member/mem.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="memNo" value="${memVO.memNo}"> 
						<input type="hidden" name="requestURL"
							value="<%=request.getServletPath()%>"> <!--送出本網頁的路徑給Controller-->
						<input type="hidden" name="whichPage" value="<%=whichPage%>"> <!--送出當前是第幾頁給Controller-->
						<input type="hidden" name="action" value="delete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/pages/page2.file"%>

</body>
</html>