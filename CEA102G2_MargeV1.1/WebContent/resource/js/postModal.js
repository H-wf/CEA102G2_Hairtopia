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
		
		$('#comButton').on('click',function(){
			if(userSessionNo === null){
				window.alert("登入後即可對該貼文留言。");
				return false;
			}if($('#comCon').val().trim().length === 0 ){
				window.alert("請輸入留言內容。");
				return false;
			}
			$.ajax({
				type:"POST",
				url:contextPath + "/comment/comment.do",
				data:{
					action:"addComByAJAX",
					userSessionNo:userSessionNo,
					postNo:$('.modal-body').attr('id'),
					comCon:$('#comCon').val(),
				},
				success:function(data){
					var comVo =  JSON.parse(data);
					addCom(comVo);
					$('#comCon').val("");
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
    	$('.modal-body').attr('id',postVo.postNo);
    	$('#desInfo').prepend(`<img src="` + contextPath + `/PicFinder?pic=1&table=designer&column=desPic&idname=desNo&id=` + postVo.desNo + `" id="desPic" class="img-thumbnail" />`);
        $('#postTitle h5').append(postVo.desName);
        $('#postTitle p').append(postVo.postCon);
        $.each(tagNameList, function(index,value) {
            $('#tags').append(`<div>` + value + `</div>`);
        })
        $('#postTime').append( postVo.postTime);
        if(isDes === true){
	        if(desSessionNo === postVo.desNo){
	        	$('#desInfo').append(`<div class="dropdown" id="postD">
		                                    	<a class="dropdown-toggle" href="#" id="postDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		                                    		<i class="bi bi-three-dots-vertical""></i>
							                    </a>
												  <div class="dropdown-menu" aria-labelledby="postDropdown">
												    <a class="dropdown-item" href="#">隱藏此貼文</a>
												    <a class="dropdown-item" href="#">修改</a>
							   					  </div>
											</div>`);
	        }
        }

        //post title 設置完成

        $.each(commentList, function(index,item) {
        	
        	
            if (item.comStatus != false) {
	            	if(item.memNo != userSessionNo){
	                $('#comList').append(`<li class="media">` + `
	                                                <img src="` + contextPath + `/PicFinder?pic=1&table=member&column=memPic&idname=memNo&id=` + item.memNo + `" class="img-thumbnail" />` +
	                    `<div class="media-body">
	                                                    <h5 class="mt-0 mb-1">` + item.memName + `</h5>
	                                                    <p class="comCon">` + item.comCon + `</p>
	                                                    <small class="text-muted comTime">` + item.comTime + `</small>
	                                                </div>
	                                            </li>`);
	            }else if(item.memNo === userSessionNo){
	            	$('#comList').append(`<li class="media">` + `
	                        <img src="` + contextPath + `/PicFinder?pic=1&table=member&column=memPic&idname=memNo&id=` + item.memNo + `" class="img-thumbnail" />` +
	                        `<div class="media-body">
	                            <h5 class="mt-0 mb-1">` + item.memName + `</h5>`+
	                            `<div class="dropdown" id="comD">
		                                    	<a class="dropdown-toggle" href="#" id="comDropdown`+item.comNo+`" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		                                    		<i class="bi bi-three-dots-vertical"></i>
							                    </a>
												  <div class="dropdown-menu" aria-labelledby="comDropdown`+item.comNo+`">
												    <a class="dropdown-item" href="#">刪除留言</a>
												    <a class="dropdown-item" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">修改</a>
							   					  </div>
												</div>`+
	                            `<p class="comCon">` + item.comCon + `</p>
	                            <div class="collapse" id="collapseExample">
	                            		<div class="input-group">
                                            <input type="text" class="form-control" placeholder="修改留言" id="udComCon">
                                            <button class="btn btn-outline-secondary" id="udCom" type="submit">留言</button>
                                        </div>
								 </div>
	                            <small class="text-muted comTime">` + item.comTime + `</small>
	                        </div>
	                    </li>`);
	            }else{
	            	console.log("XXXX");
	            }
            }
        });
        
}

function emptyModal(){
	$('#carouselPostIndicators .carousel-inner').empty();
	$('#carouselPostIndicators .carousel-indicators').remove();
	$('#carouselPostIndicators a').remove();
	$('#desPic').remove();
	$('#postTitle h5').empty();
	$('#postTitle p').empty();
	$('#tags').empty();
	$('#postTime').empty();
	$('#comList').empty();
	$('.modal-body').removeAttr('id');
	$('#comCon').val("");
	
	
	
}
function addCom(comVo){
console.log(comVo.comStatus);
console.log(comVo.memName);

	if (comVo.comStatus !== false) {
        $('#comList').append(`<li class="media">` + `
                                        <img src="` + contextPath + `/PicFinder?pic=1&table=member&column=memPic&idname=memNo&id=` + comVo.memNo + `" class="img-thumbnail" />` +
            `<div class="media-body">
                                            <h5 class="mt-0 mb-1">` + comVo.memName + `</h5>
                                            <p class="comCon">` + comVo.comCon + `</p>
                                            <small class="text-muted comTime">` + comVo.comTime + `</small>
                                        </div>
                                    </li>`);
    }
}