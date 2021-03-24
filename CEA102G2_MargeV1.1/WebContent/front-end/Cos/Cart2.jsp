<%@page import="com.cos.model.CosService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.* , com.coudet.model.*, com.coudet.controller.*, com.cos.controller.*" %>

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

</style>
<body>
<%@include file="/front-end/tempFile/navBar" %>

<!-- Begin Page Content -->
<div class="container-fluid">

<% @SuppressWarnings("unchecked")
   HashSet<CosdetVO> buylist = (HashSet<CosdetVO>) session.getAttribute("shoppingcart");%>

<%
	Boolean check = false;
	HashSet<Integer> set = new HashSet<>();
   CosdetService cosdetSvc = new CosdetService();
   List<CosdetVO> checkifapplied =  (List<CosdetVO>) cosdetSvc.getAllCosByMemNo(1000);
   for (CosdetVO order1 : checkifapplied){
	   int cosNo1 = order1.getCosNo();
	   for (CosdetVO order : buylist){
		   int cosNo2 = order.getCosNo();
		   if (cosNo1 == cosNo2){
			   set.add(cosNo1);
			   check = true;
	   		}   
	   }
   }
   
   pageContext.setAttribute("check", check);
 %>

<%if (buylist != null && (buylist.size() > 0)) {%>

<h4>目前報名課程如下：（Cart.jsp）</h4>

<table id="mytb"style="width: 77.5rem" class="table table-striped" >
    <tr> 
	    <th style="width: 10rem" valign="middle">課程編號</th>
	    <th style="width: 10rem" valign="middle">課程名稱</th>
	    <th style="width: 10rem" valign="middle">會員編號</th>
	    <th style="width: 10rem" valign="middle">報名課程價格</th>
	    <th style="width: 10rem" valign="middle">點選刪除</th>
    </tr>
</table>
  
<table id="mytb"style="width: 77.5rem">
	<%
	 for (CosdetVO order:buylist) {
		 CosService cosSvc1 = new CosService();
	%>
	<tr>
		<td style="width: 10rem" valign="middle">&emsp;&emsp;&ensp;<%=order.getCosNo()%></td>
		<td style="width: 10rem" valign="middle">&emsp;&emsp;&ensp;<%=cosSvc1.findByPrimaryKeyCos(order.getCosNo()).getCosName()%></td>
		<td style="width: 10rem" valign="middle">&emsp;&emsp;&ensp;<%=order.getMemNo()%></td>
		<td style="width: 10rem" valign="middle">&emsp;&emsp;&ensp;<%=order.getCosDetailPrice()%></td>
        <td style="width: 10rem" valign="middle">
        	<form name="deleteForm" action="<%=request.getContextPath()%>/cos/orderdetail.do" method="POST">
              <input type="hidden" name="action"  value="DELETE">
              <input type="hidden" name="del" value="<%=order.getCosNo() %>">
              <input type="submit" value="刪除" class="button">
          </form>
          </td>
	</tr>
	<%}%>
</table>

<p>
          <form name="checkoutForm" action="<%=request.getContextPath()%>/cos/order.do" method="POST">
              <input type="hidden" name="action"  value="CHECKOUT">
              <input type="hidden" name="cosNo"  value="${cosVO.cosNo}">
              <input type="hidden" name="cosDetailPrice"  value="${cosVO.cosDetailPrice}"> 
              <input type="submit" value="確認送出" class="button">
          </form>
<%}%>

</body>
<body>
<p>
<li><a href="<%=request.getContextPath()%>/front-end/Cos/listAllCosApplyFromfront.jsp">繼續選購</a><br><br></li>

</div>
<!-- Page Content END -->
<script>
	let str = '重複報名 (請自行刪除，以免重複收費)：';
	<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService"/>
	<%
		if(check){
			for(Integer cosNo:set) {	
	%>
				str += '<%=cosSvc.findByPrimaryKeyCos(cosNo).getCosName()%>；';
	<%
			}
	%>
			alert(str);
	<%
		}
	%>
</script>
<%@include file="/front-end/tempFile/footer" %>
<%@include file="/front-end/tempFile/tempJs" %>
</body>
</html>