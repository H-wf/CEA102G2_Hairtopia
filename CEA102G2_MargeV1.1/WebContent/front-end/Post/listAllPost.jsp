<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>

<jsp:useBean id="postSvc"  scope="page" class="com.post.model.PostService" />
<html>

<head>
    
</head>
<style>

</style>

<body>

   
<!-- carousel -->
    <div id="carouselExampleSlidesOnly" class="carousel slide mb-5" data-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://picsum.photos/1300/300?random=2" class="d-block w-100">
            </div>
            <div class="carousel-item">
                <img src="https://picsum.photos/1300/300?random=3" class="d-block w-100">
            </div>
            <div class="carousel-item">
                <img src="https://picsum.photos/1300/300?random=4" class="d-block w-100">
            </div>
        </div>
    </div>
    <!-- csrousel end -->
    <h1></h1>
	<div class="container post">
		<div class="card-columns ">
		<c:forEach  var="postVO" items="${postSvc.all}">
			<a href="<%=request.getContextPath()%>/front-end/post/post.do?postNo=${postVO.postNo}&action=Display_fromListAll" >
				<div class="card">
					<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}"
					 class="card-img-top post-img" data-toggle="modal" data-target="#post${postVO.postNo}Modal" />
				</div>
			</a>
		</c:forEach>
		</div>
	</div>


    <h1>內容</h1>
    <c:if test="${openModal != null}" >
    <!-- Post Modal -->
            <div class="modal fade" id="postModal" tabindex="-1"  aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable listOne">
                    <div class="modal-content">
                            <button type="button" class="postClose text-right" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        <div class="modal-body p-0 m-0">
                        	<div class="includePage">
                            	<jsp:include page="/front-end/Comment/listPostWithComments_front.jsp" />
                        	</div>
                        </div>
                    </div>
                </div>
            </div>
            <script>
 			$("#postModal").modal({show: true},'handleUpdate');
            </script>
	<!-- Post END -->
	</c:if>
	
	
	
</body>

</html>