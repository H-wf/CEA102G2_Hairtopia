<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="com.coudet.model.*"%>
    
<% CosdetVO cosdetVO =  (CosdetVO) request.getAttribute("cosdetVO");%>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>



<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService"/>
	<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService"/>
	
	<tr>
		<img src="http://localhost:8081/CEA102G2_Merge/coudet/coudet.do/?cosNO=${cosdetVO.cosNo}&action=getOne_For_Display">
		<td>${cosSvc.findByPrimaryKeyCos(cosdetVO.cosNo).cosName}</td>
		<td>${memSvc.getOneMem(cosdetVO.memNo).memName}</td>
		<td>${cosdetVO.cosComment}</td>
		<td>${cosdetVO.cosDetailPrice}</td>
	</tr>


</body>
</html>