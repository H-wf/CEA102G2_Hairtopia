<%@page import="com.cos.model.CosService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*,
com.coudet.model.*, com.coudet.controller.*, com.cos.controller.*, com.member.model.*"%>

<!DOCTYPE html>
<html>
<head>
<!-- 網頁標題要改記得改! -->
<title>Hairtopia</title>
<meta charset="utf-8">
<%@include file="/front-end/tempFile/head"%>

</head>
<style>
.ftco-navbar-light {
	position: static;
}

#mytb {
	font-size: 0.8rem;
}

#mytb td {
	height: 30%;
}

#table-1 h4 {
	color: black;
	font-family: "Open Sans", Arial, sans-serif;
}

.cosBtn {
	margin: 10px 10px 10px 0px;
}

</style>
<body>
	<%@include file="/front-end/tempFile/navBar"%>

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<div class="container">
			<div class="row">
				<div class="col-1.5" style="background-image: url()">
					<a
						href="<%=request.getContextPath()%>/front-end/Cos/Course_Lec_1st.jsp">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">課程首頁</button>
					</a>
				</div>

				<div class="col-1.5" style="background-image: url()">
					<a onClick="javascript:history.back(1)">
						<button type="button"
							class="btn btn-outline-primary btn-login cosBtn">繼續選購</button>
					</a>
				</div>

			</div>
		</div>

		<%
			@SuppressWarnings("unchecked")
			List<CosdetVO> buylist = (List<CosdetVO>) session.getAttribute("shoppingcart");
			MemVO userSession = (MemVO) session.getAttribute("userSession");
		%>

		<%
			if (buylist != null && (buylist.size() > 0)) {
		%>

		<h5>目前報名課程如下</h5>

		<table id="mytb" style="width: 77.5rem" class="table table-striped">
			<tr>
				<th style="width: 10rem" valign="middle">課程編號</th>
				<th style="width: 10rem" valign="middle">課程名稱</th>
				<th style="width: 10rem" valign="middle">會員編號</th>
				<th style="width: 10rem" valign="middle">報名課程價格</th>
				<th style="width: 10rem" valign="middle">點選刪除</th>
			</tr>
		</table>

		<table id="mytb" style="width: 77.5rem">
			<%
				// for (CosdetVO order:buylist) {
					CosService cosSvc1 = new CosService();
					for (int i = 0; i < buylist.size(); i++) {
						CosdetVO order = buylist.get(i);
			%>
			<tr>
				<td style="width: 10rem" valign="middle">&emsp;&emsp;&ensp;<%=order.getCosNo()%></td>
				<td style="width: 10rem" valign="middle">&emsp;&emsp;&ensp;<%=cosSvc1.findByPrimaryKeyCos(order.getCosNo()).getCosName()%></td>
				<td style="width: 10rem" valign="middle">&emsp;&emsp;&ensp;<%=order.getMemNo()%></td>
				<td style="width: 10rem" valign="middle">&emsp;&emsp;&ensp;<%=order.getCosDetailPrice()%></td>
				<td style="width: 10rem" valign="middle">
					<form name="deleteForm"
						action="<%=request.getContextPath()%>/cos/order.do" method="POST">
						<input type="hidden" name="action" value="DELETE"> <input
							type="hidden" name="del" value="<%=i%>"> <input
							type="submit" value="刪除" class="button">
					</form>
				</td>
			</tr>
			<%
				}
			%>
		</table>

		<p>
		<form name="checkoutForm"
			action="<%=request.getContextPath()%>/cos/order.do" method="POST">
			<input type="hidden" name="action" value="CHECKOUT"> <input
				type="hidden" name="cosNo" value="${cosVO.cosNo}"> <input
				type="hidden" name="cosDetailPrice" value="${cosVO.cosDetailPrice}">
			<input type="submit" value="確認送出" class="button">
		</form>
		<%
			}
		%>
	
</body>
<body>
	<p>

		<!-- Page Content END -->

		<%@include file="/front-end/tempFile/footer"%>
		<%@include file="/front-end/tempFile/tempJs"%>
</body>
</html>