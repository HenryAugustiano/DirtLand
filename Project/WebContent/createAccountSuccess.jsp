<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Success</title>
</head>
<body style="background-color:#FFFDD0;">
<h1 style="text-align:center;font-family: Futura;">Your Account has been Successfully Created</h1>
<%
try
{
	getConnection();
	String first = request.getParameter("firstName");
	String last = request.getParameter("lastName");
	String email = request.getParameter("email");
	String phone = request.getParameter("phoneNumber");
	String address = request.getParameter("address");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String postal = request.getParameter("postalCode");
	String country = request.getParameter("country");
	String userId = request.getParameter("username");
	String password = request.getParameter("password");

	String SQL = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country,userid,password) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
	PreparedStatement pst = con.prepareStatement(SQL);
	pst.setString(1,first);
	pst.setString(2,last);
	pst.setString(3,email);
	pst.setString(4,phone);
	pst.setString(5,address);
	pst.setString(6,city);
	pst.setString(7,state);
	pst.setString(8,postal);
	pst.setString(9,country);
	pst.setString(10,userId);
	pst.setString(11,password);

    //check if insert success.
	int check = pst.executeUpdate();
	if(password != null) {
        %>
        <a href="index.jsp">Success! Back to Home Page</a>
        <%
        }
	else out.println("failed to add customer");
}
catch (Exception e)
{
    out.print(e);
}
finally
{	
	closeConnection();	
}
%>

</body>
</html>
