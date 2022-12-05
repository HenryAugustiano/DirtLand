<%@ include file="jdbc.jsp" %>
<%@ page language="java" import="java.io.*,java.sql.*" %>
<%@ page import="java.DateTime.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<!DOCTYPE html>
<html>
<head>
    <title>MyAccount</title>
    <!-- Bootstrap core CSS -->
    <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css'>
    <link rel="stylesheet" href="./bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="./style.css" />
</head>
<body style="background-color:#FFFDD0">

<div style="padding: 30px">
    <%
    String uid = (String)session.getAttribute("authenticatedUser");
    if(uid == null){
        %>
        <div class = "text-c">
        <h3>Please login by clicking the link below.</h3><br> 
        <h3><a href="login.jsp">Login</a></h3><br><br><br>
        <h3>Or if you don't have an account, click the create account link below.</h3><br>
        <h3><a href="createAccount.jsp">Create Account</a></h3>
        </div>
        <%
    } else {
    %>

    <form class="align-items-md-center" name="updateForm" method=post action="editCustomer.jsp">

        <h2>Edit Account Information</h2>

        <div class="form-group">

            <div class="form-group">
                <label for="address" class="form-label mt-4">Address:</label>
                <input type="text" class="form-control" id="address" name="address">
            </div>

            <div class="form-group">
                <label for="password" class="form-label mt-4">Password:</label>
                <input type="text" class="form-control" id="password" name="password">
            </div>

            <br/>

            <div class="d-grid gap-2">
                <input class="btn btn-lg btn-primary" type="submit" name="Edit" id="Edit" value="Edit Account">
            </div>
        </div>
    </form>
</div>
<%
    }
%>
</body>
</html>