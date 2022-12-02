<!DOCTYPE html>
<html>
<head>
<title>Dirt Shop</title>
        <script>
        function checkPassword() {
            if (document.getElementById('pwd').value == document.getElementById('confirmPwd').value) {
                document.getElementById("confText").style.color = 'black';
                document.getElementById('submit').disabled = false;
            } else {
                document.getElementById("confText").style.color = 'red';
                document.getElementById('submit').disabled = true;
            }
        }
        </script>
        <style>
            h2 {
                text-align: center;
                font-size: 30px;
                padding: 4px;
            }
            form{
		        font-family: sans-serif;
		        font-size: 15px;
	        }
	        .input{
		        font-family: sans-serif;
		        font-size: 18px;
		        text-align: center;
		        padding: 4px;
		        margin: 2px;
		        transition-duration: 0.4s;
		        cursor: pointer;
		        background: #FCFBF6;
                width: 98%;
	        }
	        .input2, button {
                font-family: sans-serif;
		        font-size: 12px;
		        text-align: center;
		        font-weight: bold;
                color:black;
		        padding: 4px;
		        margin: 2px;
		        transition-duration: 0.4s;
		        cursor: pointer;
		        background: #FCFBF6;
                float: center;
	        }
	        .input:hover {
		        background-color: #81BEF7;
	        }
	        .input2:hover, button:hover{
		        background-color: #81BEF7;
	        }
            table{
		        width: 50%;
                padding: 4px;
                margin-left: auto;
                margin-right: auto;
	        }
	        table, td{
		        border: 1px solid #7E8193;
	        }
            td, p{
                font-family: sans-serif;
                font-size: 14px;
		        height: 25px;
                width:auto;
            }
	        .tableheader{
		        height: 30px;
		        font-size: 18px;
		        font-family: customFont;
		        text-align: center;
		        background-color: #81BEF7;
	        }
        </style>
</head>
<body style="background-color:#FFFDD0;">

<div class="text-c">
<h2>Create a New Accoount</h2>
<br>
<br>
<form class="register" method="post" action="createAccountSuccess.jsp">
    <table>
        <tr><td class='tableheader'>Username:</td><td><input class='input' type="text" name="username" value="" required></td></tr>
        <tr><td class='tableheader'>First Name:</td><td><input class='input' type="text" name="firstName" value="" required></td></tr>
        <tr><td class='tableheader'>Last Name:</td><td><input class='input' type="text" name="lastName" value="" required></td></tr>
        <tr><td class='tableheader'>Password:</td><td><input onchange='checkPassword();' id='pwd' class='input' type="password" name="password" value="" ></td></tr>
        <tr><td class='tableheader' id='confText'>Confirm password:</td><td ><input onchange='checkPassword();' id="confirmPwd" class='input' type="password" name="confirmPassword" value="" required></td></tr>
        <tr><td class='tableheader'>Email:</td><td><input class='input' type="email" name="email" value="" required></td></tr>
        <tr><td class='tableheader'>Phone Number (000-000-0000):</td><td><input class='input' type="tel" name="phoneNumber" value="" placeholder="000-000-0000" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" required></td></tr>
        <tr><td class='tableheader'>Country:</td><td><input class='input' type="text" name="country" value="" required></td></tr>
        <tr><td class='tableheader'>State / Province:</td><td><input class='input' type="text" name="state" value="" required></td></tr>
        <tr><td class='tableheader'>City:</td><td><input class='input' type="text" name="city" value="" required></td></tr>
        <tr><td class='tableheader'>Address:</td><td><input class='input' type="text" name="address" value="" required></td></tr>
        <tr><td class='tableheader'>Zip / Postal Code:</td><td><input class='input' type="text" name="postalCode" value="" required></td></tr>
    </table>
    <h2><input id="submit" type="submit" name="sub" class='input2' disabled></h2><br>
</form>
</div>

<style>
    .text-c {
		text-align: center;
	}
</style>
</body>
</html>

