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
	  alert("�A���m�W�O " + name + "\n�q�l�l��O " + email);
	}
</script>


<form name='form' id='form'>
  �m�W�G
  <input type='text' name='name' id='name' /> E-mail�G
  <input type='text' name='email' id='email' />
  <input type='button' name='submit' value='�e�X' onclick='processFormData();' />
</form>

</body>
</html>