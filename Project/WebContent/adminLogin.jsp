<!DOCTYPE html>
<html>
<head>
<title>Admin Login</title>
</head>
<body style="background-color:#FFFDD0">

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Please Login to System</h3>
<%-- admin uid and uname is :  1 , ethan --%>
<br>
<form name="MyForm" method=post action="adminauth.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">AdminID:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">adminName:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>
</table>
<br>
<br>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>

</div>

</body>
</html>

