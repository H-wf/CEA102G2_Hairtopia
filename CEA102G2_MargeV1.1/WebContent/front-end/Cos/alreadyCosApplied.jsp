<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
 <title>Hairtopia</title>
 <meta charset="utf-8">
<%@include file="/front-end/tempFile/head" %>
 
</head>
<style>
.ftco-navbar-light{
		position:static;
	}
#mytb{
	font-size:0.8rem;
}
#mytb td{
	height:30%;
}
#table-1 h4{
	color:black; font-family: "Open Sans", Arial, sans-serif;
}

#h5{
color=D8CF9E
}

.cosBtn {
	margin: 10px 10px 10px 0px;
}

</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">

<div class="container">
			<div class="row">
				<div class="col-1.5" style="background-image: url()">
					<a onClick="javascript:history.back(1)">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">已報名過，回上一頁</button>
					</a>
				</div>

			</div>
		</div>

<!-- Page Content END -->

<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>
</html>