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
					emptyModal();
					var jData = JSON.parse(data);
					
					var commentList = jData.commentList;
					var postVo = jData.postVo;
					var tagNameList = jData.tagNameList;
					
					showWholePost(commentList, postVo, tagNameList);
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
												    <a class="dropdown-item" data-toggle="collapse" href="#udCom`+item.comNo+`" role="button" aria-expanded="false" aria-controls="udCom`+item.comNo+`">修改</a>
							   					  </div>
												</div>`+
	                            `<p class="comCon" id="comCon`+item.comNo+`">` + item.comCon + `</p>
	                            <div class="collapse" id="udCom`+item.comNo+`">
	                            		<div class="input-group">
                                            <input type="text" class="form-control udComCon" placeholder="修改留言" id="udComCon`+item.comNo+`">
                                            <button class="btn btn-outline-secondary udComButtom" id="`+item.comNo+`" type="submit">修改</button>
                                        </div>
								 </div>
	                            <small class="text-muted comTime">` + item.comTime + `</small>
	                        </div>
	                    </li>`);
	            }
            }
        });
        $('.udComButtom').on('click',function(){
        	if($(this).prev('input').val().trim().length === 0 ){
				window.alert("請輸入修改內容。");
				return false;
			}
			$.ajax({
				type:"POST",
				url:contextPath + "/comment/comment.do",
				data:{
					action:"updateComByAJAX",
					comNo:$(this).attr('id'),
					comCon:$(this).prev('input').val(),
				},
				success:function(data){
					var  comVo =  JSON.parse(data);
					var comNo = comVo.comNo;
					var comConId ='#comCon'+comNo;
					var udComId = '#udCom'+comNo;
					var udComConId='#udComCon'+comNo;
					$(comConId).text(comVo.comCon);
					$(udComConId).val('');
					$(udComId).collapse('hide');
					window.alert("留言已修改。");
				},
				error:function(){
					console.log("AJAX ERROR!!")
				},
			});
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
		if (comVo.comStatus != false) {
			if(comVo.memNo != userSessionNo){
		    $('#comList').append(`<li class="media">` + `
		                                    <img src="` + contextPath + `/PicFinder?pic=1&table=member&column=memPic&idname=memNo&id=` + comVo.memNo + `" class="img-thumbnail" />` +
		        `<div class="media-body">
		                                        <h5 class="mt-0 mb-1">` + comVo.memName + `</h5>
		                                        <p class="comCon">` + comVo.comCon + `</p>
		                                        <small class="text-muted comTime">` + comVo.comTime + `</small>
		                                    </div>
		                                </li>`);	
		}else if(comVo.memNo === userSessionNo){
			$('#comList').append(`<li class="media">` + `
                    <img src="` + contextPath + `/PicFinder?pic=1&table=member&column=memPic&idname=memNo&id=` + comVo.memNo + `" class="img-thumbnail" />` +
                    `<div class="media-body">
                        <h5 class="mt-0 mb-1">` + comVo.memName + `</h5>`+
                        `<div class="dropdown" id="comD">
                                    	<a class="dropdown-toggle" href="#" id="comDropdown`+comVo.comNo+`" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    		<i class="bi bi-three-dots-vertical"></i>
					                    </a>
										  <div class="dropdown-menu" aria-labelledby="comDropdown`+comVo.comNo+`">
										    <a class="dropdown-item" href="#">刪除留言</a>
										    <a class="dropdown-item" data-toggle="collapse" href="#udCom`+comVo.comNo+`" role="button" aria-expanded="false" aria-controls="udCom`+comVo.comNo+`">修改</a>
					   					  </div>
										</div>`+
                        `<p class="comCon" id="comCon`+comVo.comNo+`">` + comVo.comCon + `</p>
                        <div class="collapse" id="udCom`+comVo.comNo+`">
                        		<div class="input-group">
                                    <input type="text" class="form-control udComCon" placeholder="修改留言" id="udComCon`+comVo.comNo+`">
                                    <button class="btn btn-outline-secondary udComButtom" id="`+comVo.comNo+`" type="submit">修改</button>
                                </div>
						 </div>
                        <small class="text-muted comTime">` + comVo.comTime + `</small>
                    </div>
                </li>`);
		}
	}
		$('.udComButtom').on('click',function(){
        	if($(this).prev('input').val().trim().length === 0 ){
				window.alert("請輸入修改內容。");
				return false;
			}
        	$.ajax({
				type:"POST",
				url:contextPath + "/comment/comment.do",
				data:{
					action:"updateComByAJAX",
					comNo:$(this).attr('id'),
					comCon:$(this).prev('input').val(),
				},
				success:function(data){
					var  comVo =  JSON.parse(data);
					var comNo = comVo.comNo;
					var comConId ='#comCon'+comNo;
					var udComId = '#udCom'+comNo;
					var udComConId='#udComCon'+comNo;
					$(comConId).text(comVo.comCon);
					$(udComConId).text('');
					$(udComId).collapse('hide');
					window.alert("留言已修改。");
				},
				error:function(){
					console.log("AJAX ERROR!!")
				},
			});
		});
}
