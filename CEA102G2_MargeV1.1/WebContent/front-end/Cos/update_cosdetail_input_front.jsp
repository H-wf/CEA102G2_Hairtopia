<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.coudet.model.*"%>
<%@ page import="com.cos.model.*"%>
<%@ page import="com.member.model.*"%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>課程評分 - update_cosdetail_input_front.jsp</title>
<!--關於評分星星的內容 -->
	<style type="text/css">
        /* body {
            background-color: #eee
        } */

        div.stars {
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

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正~~以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
 <jsp:useBean id="cosdetSvc" scope="page" class="com.coudet.model.CosdetService"/>
 <jsp:useBean id="cosSvc" scope="page" class="com.cos.model.CosService"/>
 <jsp:useBean id="memSvc" scope="page" class="com.member.model.MemService"/>
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/coudet/coudet.do" name="form1" enctype="multipart/form-data">
<table class="table table-striped">
	<tr>
		<td>課程名稱:</td>
		<td><c:forEach var="cosVO" items="${cosSvc.all}">
				<c:if test="${cosdetVO.cosNo==cosVO.cosNo}">
	            	${cosVO.cosName}
            	</c:if>
			</c:forEach></td>
	</tr>
	<tr>
		<td>會員姓名:</td>
		<td><c:forEach var="memVO" items="${memSvc.all}">
				<c:if test="${cosdetVO.memNo==memVO.memNo}">
	            	${memVO.memName}
            	</c:if>
			</c:forEach></td>
	</tr>
	<tr>
		<td>課程評價:</td>
		<td><div class="stars">
        		<input class="star star-5" id="star-5" type="radio" name="cosComment" value=5 /> 
        		<label class="star star-5" for="star-5"></label> 
        		<input class="star star-4" id="star-4" type="radio" name="cosComment" value=4 /> 
        		<label class="star star-4" for="star-4"></label> 
        		<input class="star star-3" id="star-3" type="radio" name="cosComment" value=3 /> 
        		<label class="star star-3" for="star-3"></label> 
        		<input class="star star-2" id="star-2" type="radio" name="cosComment" value=2 /> 
        		<label class="star star-2" for="star-2"></label> 
        		<input class="star star-1" id="star-1" type="radio" name="cosComment" value=1 /> 
        		<label class="star star-1" for="star-1"></label>
    			</div></td>
	</tr>
	<tr>
		<td>課程價格:</td>
		<td>${cosdetVO.getCosDetailPrice()}</td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action" value="updateCosRate">
<input type="hidden" name="memNo" value="${cosdetVO.getMemNo()}"> <%-- 真正送出修改處 --%>
<input type="hidden" name="cosNo" value="${cosdetVO.getCosNo()}">
<input type="hidden" name="cosComment" value="${cosdetVO.getCosComment()}">
<input type="submit" value="送出評分" class="btn btn-primary">
</FORM>
</body>
</html>       