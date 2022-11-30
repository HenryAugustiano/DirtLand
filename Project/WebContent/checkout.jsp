<!DOCTYPE html>
<html>
<head>
<title>Jo's Grocery CheckOut Line</title>
</head>
<body style="background-color:#FFFDD0;">

<div class="text-c">
<h2>Enter your UserId and password to complete the transaction:</h2>
<br>
<form method="get" action="order.jsp">
<b>userID:</b>
<input type="text" name="customerId" size="5">
<br>
<br>
<form method="get" action="order.jsp">
<b>Password:</b>
<input type="text" name="customerPassword" size="25">
<br>
<br>
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>
</div>

<style>
    .text-c {
		text-align: center;
	}
</style>

</body>
</html>

