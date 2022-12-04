<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Jo's Order List</title>
<link rel="stylesheet" type="text/css" href="./style.css" />
<div class="topnav">
  <a href="admin.jsp">Sales Report</a>
  <a href="inventory.jsp">Inventory</a>
  <div class="topnav-right">
  <a href="index.jsp">Homepage</a>
  </div>
</div>
</head>
<body style="background-color:#FFFDD0">

<h1 style="text-align:center;font-family: Futura;">Order List</h1>
<br>	

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />

<a href="https://wa.me/12508996062?text=Hi I would like to ask about your product!" class="floating" target="_blank">
<i class="fab fa-whatsapp fab-icon"></i>
</a>
<%

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
getConnection();

// Write query to retrieve all order summary records
String sql = "SELECT customerId, firstName+' '+lastName AS name, email, phonenum, address, city, state, postalCode, country FROM customer";
Statement stmt = con.createStatement();
ResultSet rst = stmt.executeQuery(sql);

%>
<table class="styled-table"; border="1" style="border-collapse:collapse;margin-left:auto;margin-right:auto;font-family:Futura;">
			<thead>
				<tr>
					<th>Id</th>
					<th>Name</th>
					<th>Email</th>
					<th>Phone Number</th>
					<th>Address</th>
					<th>City</th>
					<th>State</th>
					<th>Postal Code</th>
					<th>Country</th>
				</tr>
			</thead>
<%

while(rst.next()){
		%>
				<tr>
					<td style="text-align:center;"><%=rst.getString("customerId")%></td>
					<td style="text-align:center;"><%=rst.getString("name")%></td>
					<td style="text-align:center;"><%=rst.getString("email")%></td>
					<td style="text-align:center;"><%=rst.getString("phonenum")%></td>
					<td style="text-align:center;"><%=rst.getString("address")%></td>
					<td style="text-align:center;"><%=rst.getString("city")%></td>
					<td style="text-align:center;"><%=rst.getString("state")%></td>
					<td style="text-align:center;"><%=rst.getString("postalCode")%></td>
					<td style="text-align:center;"><%=rst.getString("country")%></td>
				</tr>
<%
}

	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
closeConnection();
%>
</table>
</body>
</html>

