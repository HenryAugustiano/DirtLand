<!DOCTYPE html>
<html>
<head>
<title>Customer Account Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color:#FFFDD0">

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
//Note: Forces loading of SQL Server driver
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "YourStrong@Passw0rd";

try {	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e) {
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
Connection con = DriverManager.getConnection(url, uid, pw);


// Retrieves customer ID from username
String sql1 = "SELECT customerID FROM customer WHERE userId = ?";
PreparedStatement pstmt1 = con.prepareStatement(sql1);
pstmt1.setString(1,userName);
ResultSet rst1 = pstmt1.executeQuery();

int custId =0;
while(rst1.next()){
custId = rst1.getInt("customerId");
}

%>
<%
// TODO: Print Customer information

String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid FROM customer WHERE customerId = ? ";

PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1,custId );
ResultSet rst = pstmt.executeQuery();

// Prints customer information in formatted table

%>
<h1 align = "center" >Customer Information</h1>
<font face="Century Gothic" size="5">
<table class="table" border = "1">
	<tr align = "right">
		<%
		while(rst.next()){
		%>	
		<tr>
			<th>Customer Id</th>
			<td><%=custId%></td>
			
		</tr>	
		<tr>
			
			<th>First Name</th>
			<td><%=rst.getString("firstName")%></td>
			
		</tr>
		<tr>
			<th>Last Name</th>
			<td><%=rst.getString("lastName")%></td>
		</tr>	
		<tr>
			<th>Email</th>
			<td><%=rst.getString("email")%></td>
		</tr>
		<tr>
			<th>Phone Number</th>
			<td><%=rst.getString("phonenum")%></td>
		</tr>
		<tr>
			<th>Address</th>
			<td><%=rst.getString("address")%></td>
		</tr>
		<tr>
			<th>City</th>

			<td><%=rst.getString("city")%></td>
		</tr>
		<tr>
			<th>State</th>
			<td><%=rst.getString("state")%></td>
		</tr>
		<tr>
			<th>Postal Code</th>

			<td><%=rst.getString("postalCode")%></td>
		</tr>
		<tr>
			<th>Country</th>

			<td><%=rst.getString("country")%></td>
		</tr>
		<tr>
			<th >User ID</th>
			<td><%=rst.getString("userId")%></td>
		</tr>
		<%
		}
		%>					
	</tr>
</table>
</font>
</body>
</html>