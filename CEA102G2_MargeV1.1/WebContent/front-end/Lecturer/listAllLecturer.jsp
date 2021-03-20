<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.lecturer.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	LecturerService lecSvc2 = new LecturerService();
	List<LecturerVO> list = lecSvc2.getAll();
	pageContext.setAttribute("list", list);
%>


<html>
<head>
<title>講師 - listAllLec.jsp</title>
<%@include file="/front-end/tempFile/head"%>
<style type="text/css">
.ftco-navbar-light {
	position: static;
}


.salName{
		font-size:1.45rem;
/* 		text-align:center; */
	}
</style>

</head>
<body>
	<%@include file="/front-end/tempFile/navBar"%>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3">

				<%-- 錯誤表列 --%>
				<%-- <c:if test="${not empty errorMsgs}"> --%>
				<!-- 	<font style="color:red">請修正以下錯誤:</font> -->
				<!-- 	<ul> -->
				<%-- 		<c:forEach var="message" items="${errorMsgs}"> --%>
				<%-- 			<li style="color:red">${message}</li> --%>
				<%-- 		</c:forEach> --%>
				<!-- 	</ul> -->
				<%-- </c:if> --%>
			</div>
			<jsp:useBean id="lecSvc" scope="page" class="com.lecturer.model.LecturerService" />
			<div class="col-md-6 ">
			<c:set var="size" value="${lecSvc.all.size()}"/>
			
<!-- 			pagination start -->
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
			    <li class="page-item">
			      <a class="page-link" href="#" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			    <forEach var="whichPages" begin="1" end="${((size-size%5)/5) + 1}">
		
			    
			    <li class="page-item"><a class="page-link" href="#">1</a></li>
			 
			    </forEach>
			    <li class="page-item">
			      <a class="page-link" href="#" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			  </ul>
			</nav>
<!--     pagination end	 -->


				<c:forEach var="lecturerVO" items="${lecSvc.all}" >
				
				<c:if test="${lecturerVO.lecStatus == 1 }">
					<div class="card w-auto" style="width: 18rem;">
						<div class="row no-gutters">
							<div class="col-md-3 ">
								<img class="img-fluid"
									src="<%=request.getContextPath()%>/PicFinder?pic=1&table=lecturer&column=lecPic&idname=lecNo&id=${lecturerVO.lecNo}"
									alt='沒有圖片' />
							</div>
							<div class="col-md-6 mr-5 pr-2">
								<div class="card-body pl-3 pb-0">
									<h2 class="card-text salName">${lecturerVO.lecName}</h2>
									
									<p class="card-text ">${lecturerVO.lecIntro}</p>
								
								
								</div>
							</div>
							<span class="col-md-2 align-self-end  mb-3 ml-2">
									<a
										href="<%=request.getContextPath()%>/lecturer/lecturer.do?action=getOne_For_Display_front&lecNo=${lecturerVO.lecNo}"
										class="btn btn-primary">查看詳情</a>
							
							</span>


						</div>
					</div>
			</c:if>
				</c:forEach>
			
			</div>
			

			<%@include file="/front-end/tempFile/footer"%>
			<%@include file="/front-end/tempFile/tempJs"%>
</body>
</html>