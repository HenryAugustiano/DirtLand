<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Customer</title>

    <!-- Bootstrap core CSS -->
    <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css'>
    <link rel="stylesheet" href="./bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="./style.css"/>
</head>
<body style="background-color:#FFFDD0">
<div class = "text-c">
<%
    // Make connection

    // Write query to retrieve all order summary records
    try {
        getConnection();
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        if(address == null){
            address = "";
        }
        if(password == null){
            password = "";
        }
        if(address.equals("") || password.equals("")){
        %>
        <h2>Please fill the form again as a field is left empty</h2><br>
        <h2><a href="myaccount.jsp">Back</a></h2>
        <%
        }else{
        String uid = (String)session.getAttribute("authenticatedUser");
        String SQL = "UPDATE customer SET address = ?, password = ? WHERE userid = ?";

        PreparedStatement pst = con.prepareStatement(SQL);
        pst.setString(1, address);
        pst.setString(2, password);
        pst.setString(3, uid);


        int check = pst.executeUpdate();
        if (check > 0) {
            %>
            <h2>Update Successful</h2>
            <a href="index.jsp">Success! Back to Home Page</a>
            <%
        }
        else
            out.println("failed to update Customer");
        }
    } catch (Exception e) {
        out.print("<h3 style='color:red'>" + e + "</h3>");
    } finally {
        closeConnection();
    }


// Close connection
%>
</div>
</body>
</html>