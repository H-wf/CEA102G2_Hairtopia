<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>chat Test select page</title>

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
   <tr><td><h3>IBM Chat: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM chat: Home</p>

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
  <li><a href='listAllChat.jsp'>List</a> all chat.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/chat/chat.do" >
        <b>輸入消息編號 (如1,2...):</b>
        <input type="text" name="chatNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="chatSvc" scope="page" class="com.chat.model.ChatService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/chat/chat.do" >
       <b>選擇聊天內容編號:</b>
       <select size="1" name="chatNo">
         <c:forEach var="chatVO" items="${chatSvc.all}" > 
          <option value="${chatVO.chatNo}">${chatVO.chatNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/chat/chat.do" >
       <b>選擇聊天內容:</b>
       <select size="1" name="chatNo">
         <c:forEach var="chatVO" items="${chatSvc.all}" > 
          <option value="${chatVO.chatNo}">${chatVO.chatText}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>員工管理</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/chat/addChat.jsp'>Add</a> add chat.</li>
</ul>

</body>
</html>