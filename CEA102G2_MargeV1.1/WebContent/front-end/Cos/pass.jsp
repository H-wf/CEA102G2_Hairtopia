<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>

恭喜報名成功，系通將發送通知信至您信箱！
<div class="demo-container">
        <div class="card-wrapper"></div>
        <div class="form-container active">
            <form action="">
                <input placeholder="Card number" type="tel" name="number">
                <input placeholder="Full name" type="text" name="name">
                <input placeholder="MM/YY" type="tel" name="expiry">
                <input placeholder="CVC" type="number" name="cvc">
            </form>
        </div>
    </div>

<script src="<%=request.getContextPath()%>/resource/card-master/dist/jquery.card.js"></script>
<script>
        new Card({
            form: document.querySelector('form'),
            container: '.card-wrapper'
        });
    </script>
</body>
</html>