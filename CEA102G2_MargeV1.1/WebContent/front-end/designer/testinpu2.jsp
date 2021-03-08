<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>



<script>
var contextPath ="<%=request.getContextPath()%>";
function searchInfo(keyWord) {
	$.ajax({
		url : contextPath + "/salon/salon.do",
			data : {
				action : "serchByAjax",
				keyWord : keyWord,
			},
			type : "POST",
			cache : false,
			ifModified : true,
			dataType : "json",
			success : function(data) {
				console.log(data);
			}
		});

	}
	$(document).ready(function(){
		$('#input_text').keyup(function(e) {
			let value = $('[name=value]').val();
			searchInfo(value);
			console.log(value);
		})
	})
		
</script>
</head>
<body>
	<h1>Search Employee</h1>
	<form name="vinform">
		<input type="text" id="input_text" name="value">
	</form>

	<span id="mylocation"></span>
</body>
</html>