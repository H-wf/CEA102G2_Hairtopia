<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>

<jsp:useBean id="postSvc"  scope="page" class="com.post.model.PostService" />

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <title>Hairtopia</title>
 <meta charset="utf-8">
<%@include file="/front-end/tempFile/head" %>
 
</head>
<style>
/* postCSS */
	@media (min-width: 576px) {
  .card-columns {
	    column-count: 2;
	  	}
	}
	@media (min-width: 768px) {
	  .card-columns {
	    column-count: 4;
	  }
	}
	@media (min-width: 992px) {
	  .card-columns {
	    column-count: 4;
	  }
	}
	@media (min-width: 1200px) {
		.card-columns {
	    column-count: 4;
	  }
	}
	.post{
		padding-left: 8em;
		padding-right: 7em;
	}
 	.card:hover{ 
      transform: scale(1.05); 
 	  box-shadow: 0 10px 20px rgba(0,0,0,.12), 0 4px 8px rgba(0,0,0,.06); 
 	}
 /* postCSS END */
 	
/* Whole post Css */
#postModal .modal-dialog{
    max-width: 70%;
}
#postModal .close{
    margin-top: -15px;
    margin-right: -10px;
}
div.comDisplay{
    overflow-y:auto;
    height:300px;
    }
img {
    max-width: 100%;
}
#tags div{
	text-transform: uppercase;
    display: inline-block;
    padding: 4px 10px;
    margin-bottom: 7px;
    margin-right: 4px;
    border-radius: 4px;
    color: #000;
    border: 1px solid #e6e6e6;
    font-size: 11px;
}
/* Whole post Css END */
</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid px-0">
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
				<div class="card onePost" id="${postVO.postNo}">
					<img src="<%=request.getContextPath()%>/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=${postVO.postNo}"
					 class="card-img-top post-img" />
				</div>
		</c:forEach>
		</div>
	</div>
</div>
<!-- Page Content END -->

<!-- POST MODAL -->

	<div class="modal fade" id="postModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-6 pl-0">
                                <div id="carouselPostIndicators" class="carousel slide" data-ride="carousel">
                                    <div class="carousel-inner">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 p-0">
                                <div class="card-title" id="postTitle">
                                    <h2></h2>
                                    <h5 class="m-0"></h5>
                                    <div id="tags"></div>
                                    <small class="text-muted" id="postTime"></small>
                                </div>
                                <p class="card-text">
                                    <div class="comDisplay">
                                        <ul class="list-unstyled" id="comList">
                                        </ul>
                                    </div>
                                    <!--  有會員之後要判斷出刪除、修改按鈕 -->
                                    <form method="post"	action="<%=request.getContextPath()%>/comment/comment.do">
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="輸入留言" name="comCon">
                                            <input type="hidden" name="postNo" value="${postVO.postNo}">
                                            <input type="hidden" name="memNo" value="1"> <input type="hidden" name="action"	value="insert_Front">
                                            <button class="btn btn-outline-secondary" type="submit">留言</button>
                                        </div>
                                    </form>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<!-- POST MODAL END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>
<script>
var contextPath = "<%=request.getContextPath()%>";

$(document).ready(function(){
		$('.onePost').on('click',function(){
			$.ajax({
				type:"GET",
				url:contextPath+"/post/post.do",
				data:{
						action:"getWholePost",							
						postNo:$(this).attr('id'),
					},
				success:function(data){
					//console.log(data);
					emptyModal();
					var jData = JSON.parse(data);
					
					var commentList = jData.commentList;
					var postVo = jData.postVo;
					var tagNameList = jData.tagNameList;
					
					showWholePost(commentList, postVo, tagNameList);
// 					console.log(commentList.);
// 					console.log(postVo);
// 					console.log(tagNameList);
					$('#postModal').modal('show');
				},
				error:function(){
					console.log("AJAX ERROR!");
				},
			});
		});
	});
	
function showWholePost(commentList, postVo, tagNameList) {
    $('#carouselPostIndicators .carousel-inner').append(`<div class="carousel-item active">
                                							<img src="` + contextPath + `/PicFinder?pic=1&table=post&column=postPic1&idname=postNo&id=` + postVo.postNo + `" class="card-img-top" /></div>`);
    if (postVo.postPic2 != null || postVo.postPic3 != null) {
        $('#carouselPostIndicators').prepend(`<ol class="carousel-indicators">
												<li data-target="#carouselPostIndicators" data-slide-to="0"
													class="active"></li></ol>`);
        if (postVo.postPic2 != null) {
            $('#carouselPostIndicators .carousel-indicators').append(`<li data-target="#carouselPostIndicators" data-slide-to="1"></li>`);
            $('#carouselPostIndicators .carousel-inner').append(`<div class="carousel-item">
                                							<img src="` + contextPath + `/PicFinder?pic=1&table=post&column=postPic2&idname=postNo&id=` + postVo.postNo + `" class="card-img-top" /></div>`);
        }
        if (postVo.postPic3 != null) {
            $('#carouselPostIndicators .carousel-indicators').append(`<li data-target="#carouselPostIndicators" data-slide-to="2"></li>`);
            $('#carouselPostIndicators .carousel-inner').append(`<div class="carousel-item">
                                							<img src="` + contextPath + `/PicFinder?pic=1&table=post&column=postPic3&idname=postNo&id=` + postVo.postNo + `" class="card-img-top" /></div>`);
        }
        $('#carouselPostIndicators').prepend(`<a class="carousel-control-prev" href="#carouselPostIndicators" role="button" data-slide="prev"> <span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="sr-only">Previous</span>
                                </a>
                                <a class="carousel-control-next" href="#carouselPostIndicators" role="button" data-slide="next"> <span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="sr-only">Next</span>
                                </a>`);

    }
        // post pic 設置完成

        $('#postTitle h2').append(postVo.desNo);
        $('#postTitle h5').append(postVo.postCon);
        $.each(tagNameList, function(index,value) {
            $('#tags').append(`<div>` + value + `</div>`);
        })
        $('#postTime').append( postVo.postTime);

        //post title 設置完成

        $.each(commentList, function(index,item) {
            if (item.comStatus != false) {
                $('#comList').append(`<li class="media">` + `
                                                <!--            會員頭貼                  <img src="..." class="mr-3" alt="..."> -->` +
                    `<div class="media-body">
                                                    <h5 class="mt-0 mb-1">` + item.memNo + `</h5>
                                                    <p class="comCon">` + item.comCon + `</p>
                                                    <small class="text-muted comTime">` + item.comTime + `</small>
                                                </div>
                                            </li>`);
            }
        });
}

function emptyModal(){
	$('#carouselPostIndicators .carousel-inner').empty();
	$('#carouselPostIndicators .carousel-indicators').remove();
	$('#carouselPostIndicators a').remove();
	$('#postTitle h2').empty();
	$('#postTitle h5').empty();
	$('#tags').empty();
	$('#postTime').empty();
	$('#comList').empty();
	
	
}
</script>
</html>