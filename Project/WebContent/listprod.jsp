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
<title>Jo's Products</title>
</head>
<body style="background-color:#FFFDD0">
<br>
<div class = "text-c">
<h1> Top Products of the Store</h1>
<br>
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

int count = 1;
String temp="", png=".png", i="";

%>
<style> 
	#slideshow {
		overflow: hidden;
		height: 510px;
		width: 728px;
		margin: 0 auto;
	}

	.slide {
		float: left;
		height: 510px;
		width: 728px;
	}

	.slide-wrapper {
		width: calc(728px * 4);
		animation: slide 15s ease infinite;
	}
	
	@keyframes slide {
	20% {
		margin-left: 0px;
	}
	
	40% {
		margin-left: calc(-728px * 1);
	}
	
	60% {
		margin-left: calc(-728px * 2);
	}
	}
</style>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />

<a href="https://wa.me/12508996062?text=Hi I would like to ask about your product!" class="floating" target="_blank">
<i class="fab fa-whatsapp fab-icon"></i>
</div>
</a>
<%

PreparedStatement pstmt = null;

if(!cat.equals("all")){
	String sql = "SELECT productId, productName, categoryName, productPrice " +
				"FROM product INNER JOIN category ON product.categoryId = category.categoryId " +
				"WHERE categoryName = ? AND productName LIKE ?";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1, cat);
	pstmt.setString(2,"%"+name+"%");
} else{
	String sql = "SELECT productId, productName, categoryName, productPrice " +
				"FROM product JOIN category ON product.categoryId = category.categoryId " +
				"WHERE productName LIKE ?";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1,"%"+name+"%");
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
}else if(name.equals("") && !cat.equals("all")) {
	%>
	<h2 style="text-align:center;font-family: Futura;">Products with category <%=cat%></h2>
	<%
}else if(!name.equals("") && !cat.equals("all")) {
	%>
	<h2 style="text-align:center;font-family: Futura;">Products containing '<%=name%>' with category <%=cat%></h2>
	<%
}

%>
<table class="styled-table"; border="1" style="border-collapse:collapse;margin-left:auto;margin-right:auto;font-family: Futura;">
	<thead>
		<tr>
			<th></th>
			<th>Product Name</th>
			<th>Product Picture</th>
			<th>Category</th>
			<th>Price</th>
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
	if(c.equals("Beverages")) col = "0000FF";
	else if(c.equals("Condiments")) col = "FF0000";
	else if(c.equals("Produce")) col = "00CC00";
	else if(c.equals("Seafood")) col = "FF66CC";
	else if(c.equals("Dairy Products")) col = "6600CC";
	else if(c.equals("Confections")) col = "000000";
	else if(c.equals("Meat/Poultry")) col = "FF9900";
	else if(c.equals("Grains/Cereals")) col = "55A5B3";

	for(int j=1;j<17;j++){
		if(rst.getInt("productId")==j) 
			i = "img/" + Integer.toString(j) + ".jpg";
	}
	
	%>		
		<tr>
			<td><a href=<%=addCart%>>Add To Cart</a></td>
			<td><a href=<%=prod%>><%=rst.getString("productName")%></a></font></td>
			<td><font color=<%=col%>><%=rst.getString("categoryName")%></font></td>
			<td><img src=<%=i%> alt="ads" width="100" height="80"></td>
			<td><font color=<%=col%>><%=currFormat.format(rst.getDouble("productPrice"))%></font></td>
		</tr>
	<%
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