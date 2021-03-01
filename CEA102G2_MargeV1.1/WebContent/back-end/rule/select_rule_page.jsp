<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Rule Test select page</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>IBM Rule: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Rule: Home</p>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='<%=request.getContextPath()%>/back-end/rule/listAllRule.jsp'>List</a> all Rule.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/rule/rule.do" >
        <b>輸入消息編號 (如1,2...):</b>
        <input type="text" name="ruleNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="ruleSvc" scope="page" class="com.rule.model.RuleService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/rule/rule.do" >
       <b>選擇條款編號:</b>
       <select size="1" name="ruleNo">
         <c:forEach var="ruleVO" items="${ruleSvc.all}" > 
          <option value="${ruleVO.ruleNo}">${ruleVO.ruleNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/rule/rule.do" >
       <b>選擇條款標題:</b>
       <select size="1" name="ruleNo">
         <c:forEach var="ruleVO" items="${ruleSvc.all}" > 
          <option value="${ruleVO.ruleNo}">${ruleVO.ruleName}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>

<ul>
  <li><a href='<%=request.getContextPath()%>/back-end/rule/addRule.jsp'>Add</a> a new Rule.</li>
</ul>

</body>
</html>