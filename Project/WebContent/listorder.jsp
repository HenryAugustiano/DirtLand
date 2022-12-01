<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="navBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Dirt Land Order List</title>
</head>
<body style="background-color:#FFFDD0">

<h1 style="text-align:center;font-family: Futura;">Order List</h1>
<br>
<style> 
	.styled-table {
		border-collapse: collapse;
		margin: 25px 0;
		font-size: 0.9em;
		font-family: sans-serif;
		min-width: 400px;
		box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
	}

	.styled-table thead tr {
		background-color: #009879;
		color: #ffffff;
		text-align: center;
	}

	.styled-table th,
	.styled-table td {
    	padding: 12px 15px;	
	}
	.styled-table tbody tr {
		border-bottom: 1px solid #dddddd;
	}

	.styled-table tbody tr:nth-of-type(even) {
		background-color: #f3f3f3;
	}

	.styled-table tbody tr:last-of-type {
		border-bottom: 2px solid #009879;
	}

	.styled-table tbody tr.active-row {
		font-weight: bold;
		color: #009879;
	}

	.topnav {
			background-color: #333;
			overflow: hidden;
	}

	.topnav a {
		float: left;
		color: #f2f2f2;
		text-align: center;
		padding: 14px 16px;
		text-decoration: none;
		font-size: 17px;
	}

	.topnav a:hover {
		background-color: #ddd;
		color: black;
	}

	.topnav a.active {
		background-color: #04AA6D;
		color: white;
	}
	
	.topnav p {
		float: right;
		color: #f2f2f2;
		text-align: center;
		padding: 10px 10px;
		text-decoration: none;
		font-size: 17px;
		margin:0;
	}

	.floating {
		position: fixed;
		width: 60px;
		height: 60px;
		bottom: 40px;
		right: 40px;
		background-color: #25d366;
		color: #fff;
		border-radius: 50px;
		text-align: center;
		font-size: 30px;
		box-shadow: 2px 2px 3px #999;
		z-index: 100;
	}

	.fab-icon {
		margin-top: 16px;
	}
</style>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />

<a href="https://wa.me/12508996062?text=Hi I would like to ask about your product!" class="floating" target="_blank">
<i class="fab fa-whatsapp fab-icon"></i>
</a>
<%



String name = request.getParameter("customerName");
if(name == null) {
	name = "";
}

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
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.CANADA);

getConnection();

// Write query to retrieve all order summary records
String sql = "SELECT ordersummary.orderId, customer.customerId, " +
"firstName+' '+lastName AS name, ordersummary.totalAmount " +
"FROM customer JOIN ordersummary ON ordersummary.customerId = customer.customerId";

String sql2 = "SELECT product.productId, orderproduct.quantity, product.productPrice " +
"FROM product JOIN orderproduct on product.productId = orderproduct.productId " +
"WHERE orderId = ?";

Statement stmt = con.createStatement();
PreparedStatement pstmt = con.prepareStatement(sql2);

// For each order in the ResultSet
ResultSet rst = stmt.executeQuery(sql);

// Print out the order summary information
while(rst.next()){
	int oId = rst.getInt("orderId");
		%>
		<table class="styled-table"; border="1" style="border-collapse:collapse;margin-left:auto;margin-right:auto;;font-family: Futura;">
			<thead>
				<tr>
					<th width = "45" height = "20">OrderId</th>
					<th width = "60" height = "20">CustomerId</th>
					<th width = "150" height = "20">Customer Name</th>
					<th width = "100" height = "20">Total Amount</th>
				</tr>
			</thead>
				<tr>
					<td style="text-align:center;font-family: Futura;"><%=oId%></td>
					<td style="text-align:center;font-family: Futura;"><%=rst.getString("customerId")%></td>
					<td style="text-align:center;font-family: Futura;"><%=rst.getString("name")%></td>
					<td style="text-align:center;font-family: Futura;"><%=currFormat.format(rst.getDouble("totalAmount"))%></td>
				</tr>
				<tr>
					<table class="styled-table"; border="1" style="border-collapse:collapse;margin-left:auto;margin-right:auto;font-family: Futura;;">
						<thead>
							<th height = "20">ProductId</th>
							<th height = "20">Quantity</th>
							<th width = "80" height = "20">Price</th>
						</thead>
				</tr>
		<%
	
	
	pstmt.setInt(1, oId);
	ResultSet rst2 = pstmt.executeQuery();
	int quantity, totalQ=0; 
	double price, totalP=0.0;
	while(rst2.next()){
	quantity = rst2.getInt("quantity");
	price = rst2.getDouble("productPrice");
	%>
		<tr>
			<td style="text-align:center;font-family: Futura;" height = "20"><%=rst2.getString("productId")%></td>
			<td style="text-align:center;font-family: Futura;" height = "20"><%=quantity%></td>
			<td style="text-align:center;font-family: Futura;" height = "20"><%=currFormat.format(price)%></td>
		</tr>
	<%
	totalQ += quantity;
	totalP += price * quantity;
		}
		
	%>
		<tr>
			<td style="text-align:center;font-family: Futura;" height = "20">Total:</td>
			<td style="text-align:center;font-family: Futura;" height = "20"><%=totalQ%></td>
			<td style="text-align:center;font-family: Futura;" height = "20"><%=currFormat.format(totalP)%></td>
		</tr>
		</table>
		<br>
		<br>
	<%
}
%>
	</table>
<%

	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
closeConnection();
%>
</body>
</html>

