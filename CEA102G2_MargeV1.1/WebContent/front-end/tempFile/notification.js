
$(function() {
	$('.bi-bell').click(function() {
		$('.notification_buble').toggleClass('active');
		console.log($('.notification_buble'));
	});
	var list = document.querySelectorAll(".notification_buble > div");
	console.log(list);
	  
	$('#chat').click(function(){
		$('.notification_buble > div:eq(0)').css('display', 'block');
		$('.notification_buble > div:eq(1)').css('display', 'none');
		$('.notification_buble > div:eq(2)').css('display', 'none');
		$(this).parent().addClass("active");
		$(this).parent().next().removeClass("active");
		$(this).parent().next().next().removeClass("active");
	});
	$('#aboutme').click(function(){
		$('.notification_buble > div:eq(0)').css('display', 'none');
		$('.notification_buble > div:eq(1)').css('display', 'block');
		$('.notification_buble > div:eq(2)').css('display', 'none');
		$(this).parent().prev().removeClass("active");
		$(this).parent().addClass("active");
		$(this).parent().next().removeClass("active");
		
	});
	$('#myfollowing').click(function(){
		$('.notification_buble > div:eq(0)').css('display', 'none');
		$('.notification_buble > div:eq(1)').css('display', 'none');
		$('.notification_buble > div:eq(2)').css('display', 'block');
		$(this).parent().prev().removeClass("active");
		$(this).parent().prev().prev().removeClass("active");
		$(this).parent().addClass("active");
	});
	
	
});
