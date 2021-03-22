<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
    <%@ page import="com.coudet.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>

<c:forEach var="cosdetVar" items="${cosdetVO}">	
	<tr>
		<td>${cosSvc.findByPrimaryKeyCos(cosdetVar.cosNo).cosName}</td>
		<td>${memSvc.getOneMem(cosdetVar.memNo).memName}</td>
		<td>${cosdetVar.cosComment}</td>
		<td>${cosdetVar.cosDetailPrice}</td>
	</tr>
	</c:forEach>

</body>
</html>