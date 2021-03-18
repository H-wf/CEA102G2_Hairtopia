<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*, com.coudet.model.*, com.coudet.controller.*, com.cos.controller.*" %>

<!DOCTYPE html>
<html>
<head>
<title>課程評分</title>
</head>
<body>

<%-- <%session.getAttribute("memVO");%> --%>

<form METHOD="POST" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" name="form1">  
<input type="hidden" name="memNo" value="1000">	                
<input type="hidden" name="action" value="findByMenNoToCos">
<input type="submit" value="查詢歷史休課紀錄">
</form>

</body>
</html>