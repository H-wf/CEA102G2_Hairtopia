<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html>
<html>
<head>

</head>
<body>

<script type="text/javascript">

function processFormData() {
	  const formElement = document.getElementById("form");
	  const name = formElement[0].value;
	  const email = formElement[1].value;
	  alert("你的姓名是 " + name + "\n電子郵件是 " + email);
	}
</script>


<form name='form' id='form'>
  姓名：
  <input type='text' name='name' id='name' /> E-mail：
  <input type='text' name='email' id='email' />
  <input type='button' name='submit' value='送出' onclick='processFormData();' />
</form>

</body>
</html>