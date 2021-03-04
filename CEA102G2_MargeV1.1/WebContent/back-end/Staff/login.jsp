<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
    <title>員工的登入頁面</title>
</head>

<body>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
    <form method="post" action="<%=request.getContextPath()%>/staff/staff.do">
    <table>
        <tbody>
            <tr>
                <td>帳號：</td>
                <td>
                    <input type="text" name="staAcct">
                </td>
            </tr>
            <tr>
                <td>密碼：</td>
                <td>
                    <input type="password" name="staPswd">
                </td>
            </tr>
            <tr>
            	<td><input type="hidden" name="action" value="login"></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right;">
                    <button id="send">登入</button>
                </td>
            </tr>
        </tbody>
    </table>
	</form>
</body>

</html>