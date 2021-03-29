<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.salon.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	List<SalonVO> salList = (ArrayList<SalonVO>) request.getAttribute("salList");
	pageContext.setAttribute("salList", salList);
%>


<html>
<head>
<title>搜尋髮廊資料 - listAllSalon_Search.jsp</title>
<%@include file="/front-end/tempFile/head"%>

</head>
<style>

#headImg{ 
 height: 40vh;
    background-image: url(<%=request.getContextPath()%>/front-end/Post/forHeadBG2.jpg);
    background-repeat: no-repeat;
    background-position: 50% 34%;
    background-size: 100%;
 } 
</style>

<body>
	<%@include file="/front-end/tempFile/navBar"%>



	<div class="container-fluid px-0">
	<div id="headImg">
	</div>
	<nav aria-label="breadcrumb">
		  <ol class="breadcrumb">
		    <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/front-end/index.jsp">首頁</a></li>
		    <li class="breadcrumb-item active" aria-current="page">搜尋髮廊　' ${keyword} '</li>
		  </ol>
	</nav>
		<div class="row justify-content-center">
			


			<div class="col-md-6 my-5">



				<c:forEach var="salonVO" items="${salList}">
					<div class="card w-auto p-3 " style="width: 18rem;">
						<div class="card-body">
							<a href="<%=request.getContextPath()%>/salon/salon.do?action=getOne_For_Display&salNo=${salonVO.salNo}"
								class="card-link"><h5 class="card-title">${salonVO.salName}</h5></a>

							<span class="icon icon-map-marker mr-3"><i
								class="bi bi-geo-alt-fill"></i></span><span class="card-text mb-0">${salonVO.salAdd}</span>




							<div class="row justify-content-between">
								<div class="col-md-4">
									<p class="card-text">
										<span class="icon icon-phone mr-3"><i
											class="bi bi-telephone-fill"></i></span> <span class="text">${salonVO.salPhone}</span></a>
								</div>
								<div class="col-md-4 text-right">
									<a
										href="<%=request.getContextPath()%>/salon/salon.do?action=getOne_For_Display&salNo=${salonVO.salNo}"
										class="btn btn-primary">查看髮廊</a>
								</div>
							</div>


						</div>
					</div>
				</c:forEach>

			</div>
		</div>
		<%@include file="/front-end/tempFile/footer"%>
		<%@include file="/front-end/tempFile/tempJs"%>
</body>
</html>