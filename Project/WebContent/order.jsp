<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%-- to request authentication --%>
<%@ include file="auth.jsp" %>  

<!DOCTYPE html>
<html>
<head>
<title>The Jo&#39s Order Processing</title>
</head>
<body style="background-color:#FFFDD0;">

	<h1 style="text-align: center;">Your Order Summary</h1>

<% 
// Get customer id
String custId = request.getParameter("customerId");
String custPass = request.getParameter("customerPassword");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Make connection
getConnection();

// Determine if valid customer id was entered
try {
	int testId = Integer.parseInt(custId);
	String testPass = custPass;
	String custIdCheck = "SELECT customerId, password FROM customer WHERE customerId = ?";
	PreparedStatement testCust = con.prepareStatement(custIdCheck);
	testCust.setInt(1,testId);
	ResultSet testCustId = testCust.executeQuery();
	testCustId.next();
	// If either are not true, display an error message
	if(testId != testCustId.getInt("customerId")) {
		%>
		<h1 style="text-align: center;">Customer ID Is Invalid</h1>
		<h2 style="text-align: center;"><a href="checkout.jsp">Try Again</a></h2>
		<h2 style="text-align: center;"><a href="shop.html">Return To Jo&#39s Homepage</a></h2>
		<%
	}else {
		// Determine if password is correct
		if(!testPass.equals(testCustId.getString("password"))) {
			%>
			<h1 style="text-align: center;">Customer Password Is Invalid</h1>
			<h2 style="text-align: center;"><a href="checkout.jsp">Try Again</a></h2>
			<h2 style="text-align: center;"><a href="shop.html">Return To Jo&#39s Homepage</a></h2>
			<%
		}else {
			// Determine if there are products in the shopping cart
			if(productList.isEmpty()) {
				%>
				<h1 style="text-align: center">Your Shopping Cart Is Empty</h1>
				<h2 style="text-align: center"><a href="shop.html">Return To Shopping</a></h2>
				<h2 style="text-align: center"><a href="shop.html">Return To Jo&#39s Homepage</a></h2>
				<%
			}else {
				// Save order information to database
				Date currentDate = new Date();
				java.sql.Date sqlDate = new java.sql.Date(currentDate.getTime());
	
				// Use retrieval of auto-generated keys.
				String insertSql = "INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (?, ?, ?)";
				PreparedStatement retrieveKey = con.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
				retrieveKey.setInt(1,testId);
				retrieveKey.setDate(2,sqlDate);
				retrieveKey.setDouble(3,0);
				retrieveKey.executeUpdate();		
				ResultSet keys = retrieveKey.getGeneratedKeys();
				keys.next();
				int orderId = keys.getInt(1);
	
				// Insert each item into OrderProduct table using OrderId from previous INSERT
				String insertProductsSql = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
				double totalOrderCost = 0.0;
	
				Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
				while (iterator.hasNext()) { 
					Map.Entry<String, ArrayList<Object>> entry = iterator.next();
					ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
					String productId = (String) product.get(0);
					String price = (String) product.get(2);
					double pr = Double.parseDouble(price);
					int qty = ( (Integer)product.get(3)).intValue();
					PreparedStatement insertProduct = con.prepareStatement(insertProductsSql);
					insertProduct.setInt(1,orderId);
					insertProduct.setInt(2,Integer.parseInt(productId));
					insertProduct.setInt(3,qty);
					insertProduct.setDouble(4,pr);
					insertProduct.executeUpdate();
					totalOrderCost += (pr*qty);
				}
				// Update total amount for order record
				String updateTotalAmount = "UPDATE ordersummary SET totalAmount = ? WHERE orderId = ?";
				PreparedStatement updateAmount = con.prepareStatement(updateTotalAmount);
				updateAmount.setDouble(1,totalOrderCost);
				updateAmount.setInt(2,orderId);
				updateAmount.executeUpdate();
	
				// Print out order summary
				%>
				<table border="1" style="border-collapse:collapse;margin-left:auto;margin-right:auto;">
					<tbody>
						<tr>
							<th>Product ID</th>
							<th>Product Name</th>
							<th>Quantity</th>
							<th>Price</th>
							<th>Subtotal</th>
						</tr>
				<%
				String sql = "SELECT OP.productId, P.productName, OP.quantity, OP.price FROM orderproduct AS OP LEFT JOIN product AS P ON OP.productId = P.productId WHERE orderId = ?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,orderId);
				// Print out the ResultSet
				ResultSet rst = pstmt.executeQuery();
				NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.CANADA);
				double orderTotal = 0.0;
				while(rst.next()) {
					orderTotal += (rst.getDouble("price") * rst.getInt("quantity"));
					%>
					<tr>
						<td><%=rst.getInt("productId")%></td>
						<td><%=rst.getString("productName")%></td>
						<td><%=rst.getInt("quantity")%></td>
						<td><%=currFormat.format(rst.getDouble("price"))%></td>
						<td><%=currFormat.format(rst.getDouble("price") * rst.getInt("quantity"))%></td>
					</tr>
					<%
				}
				%>
					<tr>
						<td colspan="4" align="right"><b>Order Total</b></td>
						<td align="right"><%=currFormat.format(orderTotal)%></td>
					</tr>
					</tbody>
				</table>
				<%
				String customerInfo = "SELECT O.customerId, C.firstName, C.lastName FROM ordersummary AS O LEFT JOIN customer AS C ON O.customerId = C.customerId WHERE orderId = ?";
				PreparedStatement cInfo = con.prepareStatement(customerInfo);
				cInfo.setInt(1,orderId);
				ResultSet cInfoSearch = cInfo.executeQuery();
				cInfoSearch.next();
				String fullName = cInfoSearch.getString("firstName") + " " + cInfoSearch.getString("lastName");
				int cId = cInfoSearch.getInt("customerId");
				%>
				<h1>Order completed. Order will be shipped within 5 business days.</h1>
				<h1>Your order reference number is: <%=orderId%>.</h1>
				<h1>Order will be shipped to <%=fullName%>, Customer ID: <%=cId%>.</h1>
				<h2><a href="listprod.jsp">Return To Shopping</a></h2>
				<h2><a href="shop.html">Return To Jo&#39s Homepage</a></h2>
				<%
				// Clear cart if order placed successfully
				productList.clear();
			}
		}
	}
} catch(NumberFormatException ex) {
	%>
	<h1>Customer ID Is Invalid</h1>
	<h2><a href="checkout.jsp">Try Again</a></h2>
	<h2><a href="shop.html">Return To Jo&#39s Homepage</a></h2>
	<%
}
// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price
/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/
closeConnection();
%>
</body>
</html>

