<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.reservation.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
  ResVO resVO = (ResVO) request.getAttribute("resVO"); //ResServlet.java(Concroller), 存入req的serviceVO物件
%>

<html>
<head>
<title>預約資料 - listOneResOfMem.jsp</title>
<!--關於評分星星的內容 -->
	<style type="text/css">
        /* body {
            background-color: #eee
        } */

        div.stars {
            width: 140px;
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
        btn-primary{
        	vertical-align:top !important; 
        }
    </style>
</head>
<body>
<jsp:useBean id="designerSvc" scope="page" class="com.designer.model.DesignerService" />
<jsp:useBean id="serviceSvc" scope="page" class="com.service.model.ServiceService" />
<jsp:useBean id="salonSvc" scope="page" class="com.salon.model.SalonService" />
<table class="table table-striped">
	<tr><th>預約編號</th><td>${resVO.resNo}</td></tr>
	<tr><th>服務項目</th>
		<td><c:forEach var="serviceVO" items="${serviceSvc.all}">
				<c:if test="${serviceVO.serNo==resVO.serNo}">
	            	${serviceVO.serName}
            	</c:if>
			</c:forEach>
		</td></tr>
	<tr><th>設計師</th>
		<td><c:forEach var="designerVO" items="${designerSvc.all}">
					<c:if test="${designerVO.desNo==resVO.desNo}">
	            	${designerVO.desName}
            		</c:if>
			</c:forEach>
		</td></tr>
		<tr><th>髮廊名稱</th>
		<td><c:forEach var="designerVO" items="${designerSvc.all}">
				<c:if test="${designerVO.desNo==resVO.desNo}">
	            	<c:set var="salNo" value="${designerVO.salNo}"/>
	            </c:if>
			</c:forEach>
            <c:forEach var="salonVO" items="${salonSvc.all}">
				<c:if test="${salonVO.salNo==salNo}">
	           	${salonVO.salName}
            	</c:if>
			</c:forEach>
		</td></tr>
		<tr><th>髮廊地址</th>
		<td><c:forEach var="designerVO" items="${designerSvc.all}">
				<c:if test="${designerVO.desNo==resVO.desNo}">
	            	<c:set var="salNo" value="${designerVO.salNo}"/>
	            </c:if>
			</c:forEach>
            <c:forEach var="salonVO" items="${salonSvc.all}">
				<c:if test="${salonVO.salNo==salNo}">
	           	${salonVO.salAdd}
            	</c:if>
			</c:forEach>
		</td></tr>

	<tr><th>預約產生日</th>
		<td><fmt:formatDate value="${resVO.resProDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
		</td></tr>	
	<tr><th>預約時間</th>
		<td>
			<c:forEach var="serviceVO" items="${serviceSvc.all}">
				<c:if test="${serviceVO.serNo==resVO.serNo}">
	            	<c:set var="serPeriod" value="${serviceVO.serTime}"/>
            	</c:if>
			</c:forEach>
			<fmt:formatDate value="${resVO.resDate}" pattern="yyyy-MM-dd"/>
				<c:set var="startTime" value="${resVO.resTime}"/>
				<c:set var="endTime" value="${startTime+serPeriod}"/>
				<fmt:formatNumber type="number" value="${((startTime*30 -(startTime*30%60)))/60}"  var="shour"/>
				<fmt:formatNumber type="number" value="${((endTime*30 -(endTime*30%60)))/60}"  var="ehour"/>
				${shour}:${(startTime*30 %60 == 0)? "00" :"30" }~${ehour}:${(endTime*30 %60 == 0)? "00" :"30" }
		</td></tr>
	<tr><th>預約評價</th>
		<td>
		<c:choose>	
			<c:when test="${resVO.resStatus == 3 && resVO.resCom == 0}">
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do"
	 				 name="form1">
				<div class="stars">
        		<input class="star star-5" id="star-5" type="radio" name="resCom" value=5 /> 
        		<label class="star star-5" for="star-5"></label> 
        		<input class="star star-4" id="star-4" type="radio" name="resCom" value=4 /> 
        		<label class="star star-4" for="star-4"></label> 
        		<input class="star star-3" id="star-3" type="radio" name="resCom" value=3 /> 
        		<label class="star star-3" for="star-3"></label> 
        		<input class="star star-2" id="star-2" type="radio" name="resCom" value=2 /> 
        		<label class="star star-2" for="star-2"></label> 
        		<input class="star star-1" id="star-1" type="radio" name="resCom" value=1 /> 
        		<label class="star star-1" for="star-1"></label>
    			</div>
				<input type="submit" value="送出評價" class="btn btn-primary">
				<input type="hidden" name="resNo" value="${resVO.resNo}">
				<input type="hidden" name="action" value="reviewRes">
				</FORM>
				</c:when>
				<c:when test="${resVO.resCom != 0}">
					<c:forEach var="star" begin="1" end="5">
						<c:choose>
							<c:when test="${resVO.resCom>=star}"	>
								&#x2605;
							</c:when>
							<c:otherwise>
								&#x2606;
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
				
			</c:choose>
		</td></tr>
	<tr><th>預約驗證碼</th>
		<td>
		<c:choose>
				<c:when test="${resVO.resStatus == 0}">
					預約待確認
				</c:when>
				<c:when test="${resVO.resStatus == 1}">
					${resVO.resCode}
				</c:when>
				<c:when test="${resVO.resStatus == 2}">
					${resVO.resCode}
				</c:when>
				<c:when test="${resVO.resStatus == 3}">
					${resVO.resCode}
				</c:when>
				<c:when test="${resVO.resStatus == 4}">
				無法接受預約
				</c:when>
				<c:when test="${resVO.resStatus == 5}">
				您已取消預約
				</c:when>
			</c:choose>
		</td>
		</tr>
	<tr><th>預約金額</th><td>${resVO.resPrice}</td></tr>
	<c:if test="${resVO.resStatus == 2}">
	<tr><th>確認預約</th>
		<td><FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reservation/res.do" style="margin-bottom: 0px;">
			     	<input type="submit" value="服務完成" class="btn btn-primary">
			    	<input type="hidden" name="resNo"  value="${resVO.resNo}">
			     	<input type="hidden" name="action"	value="completeRes">
			 </FORM></td></tr>
	</c:if>
</table>

</body>
</html>