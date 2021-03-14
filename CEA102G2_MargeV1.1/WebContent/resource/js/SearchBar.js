$(document).ready(function() {
	$('#navbar-search').on('click', function() {
        swal.fire({
            html: ` 
            	<form method="post" id="searchForm" action="">
            		<div style="margin:8%;">
                		<div class="row justify-content-center">
					        <div class="btn-group btn-group-toggle search_3" data-toggle="buttons">
					            <label class="btn btn-outline-primary active">
					                <input type="radio" name="searchWhat" id="des" value="des" checked> 搜尋設計師
					            </label>
					            <label class="btn btn-outline-primary">
					                <input type="radio" name="searchWhat" id="sal" value="sal"> 搜尋髮廊
					            </label>
					            <label class="btn btn-outline-primary">
					                <input type="radio" name="searchWhat" id="pos" value="pos"> 搜尋貼文
					            </label>
					        </div>
					    </div>
					    <div class="input-group" style="background: width:80%;margin: 0 auto;">
					        <input type="text" name="keyword" class="form-control" id="nav-searchBox" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
					        <div class="input-group-append">
					            <button class="btn btn-primary" type="submit">
					                <i class="bi bi-search" style="font-size: 1.5em;"></i>
					            </button>
					        </div>
				    	</div>
				    </div>
				    <input type="hidden" name="action" value="navSearch"> 
				</form>`,
            width: '90%',
            padding: '0 20px 20px 20px',
            showConfirmButton: false,
            showCloseButton: true,
            allowOutsideClick:false,
            background: 'rgba(51,51,51,0.9)',
            showClass: {
                popup: 'animated fadeInDown',
                // icon: 'animated heartBeat delay-1s'
            },
            hideClass: {
                popup: 'animated fadeOutUp',
            },
            didOpen: function() {
            	$('#nav-searchBox').focus();
                var contor = "/designer/designer.do";
                $('#searchForm').attr('action',contextPath+contor);
                $('input[name=searchWhat]').on('change', function() {
                    if (this.value === "sal") {
                        contor = "/salon/salon.do";
                    } else if (this.value === "pos") {
                        contor = "/tag/tag.do";
                    } else {
                        contor = "/designer/designer.do";
                    }
                    $('#searchForm').attr('action',contextPath+contor);
                });
        	    $('#nav-searchBox').autocomplete({
        	    	source :function(request, response) {
	    					$.ajax({
	    						url : contextPath + contor,
	    						type : "GET",
	    						data : {
	    							action : "nav_serchByAjax",
	    							keyWord : request.term,
	    						},
	    						dataType : "json",
	    						error : function(){
	         						console.log("AJAX ERROR!");
	         						},
	    						success : function(data) {
		    						response($.map(data, function(item) {
		    								return {
		    									value : item
		    								}
	    							}))
	    						}	
	    					})
	    				},
        	    });
            }
        });
	});
});