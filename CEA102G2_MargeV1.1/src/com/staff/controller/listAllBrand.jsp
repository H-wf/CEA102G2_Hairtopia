<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.brand.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	BrandService braSvc = new BrandService();
	List<BrandVO> list = braSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>所有品牌資料 - listAllBrand.jsp</title>
    <meta charset="utf-8">
<%@include file="/back-end/tempFile/head" %>
<link href="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
</head>
<body id="page-top">
<%@include file="/back-end/tempFile/navBar_sideBar" %>
	<!-- Begin Page Content -->	
	<div class="container-fluid">
		<!-- Page Heading -->
		<h1 class="h3 mb-2 text-gray-800">所有品牌資料 - listAllBrand.jsp</h1>
        <p class="mb-4">	
        	<%-- 錯誤表列 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
				</ul>
			</c:if>
		</p>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
						<thead>
							<tr>
                           		<th>品牌編號</th>
                                <th>品牌名稱</th>
                                <th>品牌logo</th>
                                <th>品牌介紹</th>
                                <th>修改</th>
                                <th>刪除</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                               <th>品牌編號</th>
                               <th>品牌名稱</th>
                               <th>品牌logo</th>
                               <th>品牌介紹</th>
                               <th>修改</th>
                               <th>刪除</th>
                        	</tr>
                        </tfoot>
                        <tbody>
                        <c:forEach var="brandVO" items="${list}">
                            <tr ${(brandVO.braNo == param.braNo) ? 'bgcolor=#CCCCFF':''}>
                                <td>${brandVO.braNo}</td>
                                <td>${brandVO.braName}</td>
                                <td><img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=brand&column=braLogo&idname=braNo&id=${brandVO.braNo}" alt='沒有圖片' width="50px"/></td>
                                <td>${brandVO.braIntro}</td>
                                <td>
                                	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/brand/brand.do" style="margin-bottom: 0px;">
										<input type="submit" value="修改"> <input type="hidden" name="braNo" value="${brandVO.braNo}"> <input type="hidden" name="action" value="getOne_For_Update">
									</FORM>
								</td>
                               	<td>
                               		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/brand/brand.do" style="margin-bottom: 0px;">
										<input type="submit" value="刪除"> <input type="hidden" name="braNo" value="${brandVO.braNo}"> <input type="hidden" name="action" value="delete">
									</FORM>
                               	</td>
                            </tr>
						</c:forEach>                        
                         </tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
<!-- Page Content END -->
                
<%@include file="/back-end/tempFile/footer" %>
<%@include file="/back-end/tempFile/srcJs" %>
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- Custom scripts for all pages-->
<script src="<%=request.getContextPath()%>/dist/backTemp/js/sb-admin-2.min.js"></script>
<!-- Page level plugins -->
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/dist/backTemp/vendor/datatables/dataTables.bootstrap4.min.js"></script>
<!-- Page level custom scripts -->
<script src="<%=request.getContextPath()%>/dist/backTemp/js/demo/datatables-demo.js"></script>


</body>

</html>