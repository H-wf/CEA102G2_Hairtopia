<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.coudet.model.*"%>
<%
  CosdetVO cosdetVO = (CosdetVO) request.getAttribute("cosdetVO"); 
%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<!--關於評分星星的內容 -->
	<style type="text/css">
        /* body {
            background-color: #eee
        } */

        div.stars {
            width: 150px;
            display: inline-block
        }

        .mt-200 {
            margin-top: 200px
        }

        input.star {
            display: none
        }

        label.star {
            float: right;
            font-size: 30px;
            color: #4A148C;
            transition: all .2s
        }

        input.star:checked~label.star:before {
            content: "\2605";
            color: #FD4;
            transition: all .25s
        }

        input.star-5:checked~label.star:before {
            color: #FE7;
            text-shadow: 0 0 20px #952
        }

        input.star-1:checked~label.star:before {
            color: #F62
        }

        label.star:hover {
            transform: rotate(-15deg) scale(1.3)
        }

        label.star:before {
            content: '\2606';
            font-family: FontAwesome
        }
    </style>
</head>
<body>
<jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService" />
<table class="table table-striped">

</table>
</body>
</html>