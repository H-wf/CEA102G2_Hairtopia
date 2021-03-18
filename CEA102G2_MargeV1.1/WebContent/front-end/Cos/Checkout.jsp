<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.coudet.model.*, com.coudet.controller.*, com.cos.controller.*"%>

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
#checkoutbtn{
	align="right"
}

</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">

<h4>結帳：（Checkout.jsp）</h4>
<hr><p>
 
<table id="mytb"style="width: 77.5rem" class="table table-striped" >
	<tr>
		<th style="width: 10rem" valign="middle">課程編號</th>
		<th style="width: 10rem" valign="middle">課程名稱</th>
	    <th style="width: 10rem" valign="middle">會員編號</th>
	    <th style="width: 10rem" valign="middle">報名課程價格</th>
	</tr></table>
	
<form action="<%=request.getContextPath()%>/cos/orderdetail.do" method="POST">		

<table id="mytb"style="width: 77.5rem">
	<% @SuppressWarnings("unchecked")
   		HashSet<CosdetVO> buylist = (HashSet<CosdetVO>) session.getAttribute("shoppingcart");
		String ordAmt =  (String) request.getAttribute("ordAmt");
	%>
	<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService" />
	<%	for (CosdetVO order:buylist) {
	%>
	<tr>
		<td style="width: 10rem" valign="middle">&emsp;&emsp;&ensp;<%=order.getCosNo()%></td>
		<td style="width: 10rem" valign="middle">&emsp;&emsp;&ensp;<%=cosSvc.findByPrimaryKeyCos(order.getCosNo()).getCosName()%></td>
		<td style="width: 10rem" valign="middle">&emsp;&emsp;&ensp;<%=order.getMemNo()%></td>
		<td style="width: 10rem" valign="middle">&emsp;&emsp;&ensp;<%=order.getCosDetailPrice()%></td>
	</tr>
	<%
		}
	%>
	 
	
	<tr>
		<td colspan="6" style="text-align:right;"> 
		   <h4>總金額：<h4>$<%=ordAmt%></h4></h4>
	    </td>
	</tr>
</table>

<div class="demo-container">
        <div class="card-wrapper"></div>
        <div class="form-container active">
            <form action="">
                <input placeholder="Card number" type="tel" name="number">
                <input placeholder="Full name" type="text" name="name">
                <input placeholder="MM/YY" type="tel" name="expiry">
                <input placeholder="CVC" type="number" name="cvc">
                <input type="hidden" name="memNo" value="${memVO.memNo}"> 
				<input type="hidden" name="action" value="SENDMAIL">
				<input type="submit" value="送出結帳" id="checkoutbtn">
            </form>
        </div>
</div>

<%session.setAttribute("buylist",buylist);%>

</form>
       

</div>
<!-- Page Content END -->
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
<script src="<%=request.getContextPath()%>/resource/card-master/dist/jquery.card.js"></script>
<script>
        new Card({
            form: document.querySelector('form'),
            container: '.card-wrapper'
        });
    </script>

</body>
</html>