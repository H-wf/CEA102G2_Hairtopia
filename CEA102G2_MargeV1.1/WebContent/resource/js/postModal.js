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