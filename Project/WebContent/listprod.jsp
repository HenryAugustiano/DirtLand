<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%-- navbar --%>
<%@ include file="navBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="./style.css" />
<!-- Bootstrap core CSS -->
<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css'>
<link rel="stylesheet" href="./bootstrap.min.css">
<title>Dirt Land Products</title>
</head>
<body style="background-color:#FFFDD0">
<br>
<div class = "text-c">
<div id="slideshow">
        <div class="slide-wrapper">
            <div class="slide">
                <h1 class="slide-number">
                    <img src="img/1.jpg" alt="img1" width="600" height="400">
                </h1>
            </div>
            <div class="slide">
                <h1 class="slide-number">
                    <img src="img/10.jpg" alt="img2" width="600" height="400">
                </h1>
            </div>
            <div class="slide">
                <h1 class="slide-number">
                    <img src="img/16.jpg" alt="img3"width="600" height="400">
                </h1>
            </div>
        </div>
    </div>
	</div>

<div class="text-c">
<h2 style="text-c">Search for the products you want to buy:</h2>

<form method="get" action="listprod.jsp">
<select name="category" id="category">
	<option value="all">All</option>
	<option value="Recommended">Recommended Products</option>
	<option value="Clay Soils">Clay Soils</option>
	<option value="Loamy Soils">Loamy Soils</option>
	<option value="Chalky Soils">Chalky Soils</option>
	<option value="Silty Soils">Chalky Soils</option>
	<option value="Peaty Soils">Peaty Soils</option>
	<option value="Sandy Soils">Sandy Soils</option>
</select>
<input type="text" name="productName" size="30">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>
</div>

<% // Get product name to search for
String name = request.getParameter("productName");
if(name == null) {
	name = "";
}

String cat = request.getParameter("category");
if(cat == null) {
	cat = "all";
}

//Note: Forces loading of SQL Server driver
try {	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e) {
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.CANADA);
getConnection();

String i="";

%>
<style> 
	#slideshow {
		overflow: hidden;
		height: 450px;
		width: 658px;
		margin: 0 auto;
	}

	.slide {
		float: left;
		height: 450px;
		width: 658px;
	}

	.slide-wrapper {
		width: calc(658px * 4);
		animation: slide 15s ease infinite;
	}
	
	@keyframes slide {
	20% {
		margin-left: 0px;
	}
	
	40% {
		margin-left: calc(-658px * 1);
	}
	
	60% {
		margin-left: calc(-658px * 2);
	}
	}
</style>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />

<a href="https://wa.me/12508996062?text=Hi I would like to ask about your product!" class="floating" target="_blank">
<i class="fab fa-whatsapp fab-icon"></i>
</a>
<%

PreparedStatement pstmt = null;

if(cat.equals("all")){
	String sql = "SELECT productId, productName, categoryName, productImageURL, productPrice " +
				"FROM product JOIN category ON product.categoryId = category.categoryId " +
				"WHERE productName LIKE ?";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1,"%"+name+"%");
} else if(cat.equals("Recommended")){
	String sql = "SELECT TOP 3 product.productId, productName, productImageURL, productPrice, userid, SUM(quantity) AS totalQty " +
				"FROM orderproduct LEFT JOIN product ON orderproduct.productId = product.productId " +
				"INNER JOIN ordersummary ON ordersummary.orderId = orderproduct.orderId " +
				"INNER JOIN customer ON customer.customerId = ordersummary.customerId " +
				"WHERE userid = ? AND productName LIKE ? " + 
				"GROUP BY product.productId, productName, productImageURL, productPrice, userid " +
                "ORDER BY totalQty DESC";
	String uid = (String)session.getAttribute("authenticatedUser");
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1, uid);
	pstmt.setString(2,"%"+name+"%");
} else{
	String sql = "SELECT productId, productName, categoryName, productImageURL, productPrice " +
				"FROM product INNER JOIN category ON product.categoryId = category.categoryId " +
				"WHERE categoryName = ? AND productName LIKE ?";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1, cat);
	pstmt.setString(2,"%"+name+"%");
}
ResultSet rst = pstmt.executeQuery();

if(name.equals("") && cat.equals("all")) {
	%>
	<h2 style="text-align:center;font-family: Futura;">All Products</h2>
	<%
}else if(!name.equals("") && cat.equals("all")) {
	%>
	<h2 style="text-align:center;font-family: Futura;">Products containing '<%=name%>'</h2>
	<%
}else if(name.equals("") && !cat.equals("all") && !cat.equals("Recommended")) {
	%>
	<h2 style="text-align:center;font-family: Futura;">Products with category <%=cat%></h2>
	<%
}else if(!name.equals("") && cat.equals("Recommended")) {
	%>
	<h2 style="text-align:center;font-family: Futura;">Recommended products based on previous purchases containing '<%=name%>'</h2>
	<%
}else if(name.equals("") && cat.equals("Recommended")) {
	%>
	<h2 style="text-align:center;font-family: Futura;">All recommended products based on previous purchases</h2>
	<%
}else if(!name.equals("") && !cat.equals("all") && !cat.equals("Recommended")) {
	%>
	<h2 style="text-align:center;font-family: Futura;">Products containing '<%=name%>' with category <%=cat%></h2>
	<%
}

if(cat.equals("Recommended")){
	%>

<table class="styled-table"; border="1" style="border-collapse:collapse;margin-left:auto;margin-right:auto;font-family: Futura;">
	<thead>
		<tr>
			<th></th>
			<th style="text-align:center;">Product Name</th>
			<th style="text-align:center;">Product Picture</th>
			<th style="text-align:center;">Price</th>
			<th style="text-align:center;">Quantity Ordered</th>
		</tr>
	</thead>
<%

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Print out the ResultSet


while(rst.next()) {
	String prodName = rst.getString("productName");
	String prodNameLink = "";
	if(prodName.contains(" ")) {
		prodNameLink = prodName.replaceAll(" ","%20");
	}else {
		prodNameLink = prodName;
	}
	String addCart = "addcart.jsp?id=" + rst.getInt("productId") + "&name=" + prodNameLink + "&price=" + rst.getDouble("productPrice");
	String prod = "product.jsp?id=" + rst.getInt("productId");
	
	%>		
		<tr>
			<td style="text-align:center;"><a href=<%=addCart%>>Add To Cart</a></td>
			<td style="text-align:center;"><a href=<%=prod%>><%=rst.getString("productName")%></a></td>
			<td style="text-align:center;"><img src=<%=rst.getString("productImageURL")%> alt = "Product Image" width="100" height="70"></td>
			<td style="text-align:center;"><%=currFormat.format(rst.getDouble("productPrice"))%></td>
			<td style="text-align:center;"><%=rst.getInt("totalQty")%></td>
		</tr>
	<%	
	}
}else{
%>
<table class="styled-table"; border="1" style="border-collapse:collapse;margin-left:auto;margin-right:auto;font-family: Futura;">
	<thead>
		<tr>
			<th></th>
			<th style="text-align:center;">Product Name</th>
			<th style="text-align:center;">Product Picture</th>
			<th style="text-align:center;">Category</th>
			<th style="text-align:center;">Price</th>
		</tr>
	</thead>
<%

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Print out the ResultSet


while(rst.next()) {
	String prodName = rst.getString("productName");
	String prodNameLink = "";
	if(prodName.contains(" ")) {
		prodNameLink = prodName.replaceAll(" ","%20");
	}else {
		prodNameLink = prodName;
	}
	String addCart = "addcart.jsp?id=" + rst.getInt("productId") + "&name=" + prodNameLink + "&price=" + rst.getDouble("productPrice");
	String prod = "product.jsp?id=" + rst.getInt("productId");
	String col = "", c = rst.getString("categoryName");
	if(c.equals("Loamy Soils")) col = "0000FF";
	else if(c.equals("Clay Soils")) col = "FF0000";
	else if(c.equals("Chalky Soils")) col = "00CC00";
	else if(c.equals("Silty Soils")) col = "FF66CC";
	else if(c.equals("Peaty Soils")) col = "000000";
	else if(c.equals("Sandy Soils")) col = "6600CC";

	
	%>		
		<tr>
			<td style="text-align:center;"><a href=<%=addCart%>>Add To Cart</a></td>
			<td style="text-align:center;"><a href=<%=prod%>><%=rst.getString("productName")%></a></font></td>
			<td style="text-align:center;"><font color=<%=col%>><%=rst.getString("categoryName")%></font></td>
			<td style="text-align:center;"><img src=<%=rst.getString("productImageURL")%> alt = "Product Image" width="100" height="70"></td>
			<td style="text-align:center;"><font color=<%=col%>><%=currFormat.format(rst.getDouble("productPrice"))%></font></td>
		</tr>
	<%	
	}
}

// Close connection
closeConnection();
// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>
	</tbody>
</table>
</body>
</html>