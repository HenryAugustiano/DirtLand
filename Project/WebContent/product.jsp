<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<style>
.text-c {
		text-align: center;
	}
</style>

<%
getConnection();
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.CANADA);
// Get product name to search for
// TODO: Retrieve and display info for the product
String p = request.getParameter("id");
int prodId = Integer.parseInt(p);

String sql = "SELECT productId, productName, productPrice, productImageURL " +
            "FROM product WHERE productId LIKE ?";
PreparedStatement pstmt = pstmt = con.prepareStatement(sql);
pstmt.setInt(1,prodId);

// Print out the ResultSet
ResultSet rst = pstmt.executeQuery();
rst.next();

%>
<div class = "text-c">
<h1><%=rst.getString("productName")%></h1>
<%

// TODO: If there is a productImageURL, display using IMG tag
String imagePath = rst.getString("productImageURL");
if(imagePath != null) {
%>
    <img src=<%=imagePath%> alt = "Product Image">
<%
}
%><br><%	
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
String displayImgDatabase = "displayImage.jsp?id=" + prodId;
%>
<img src="<%=displayImgDatabase%>"  style="margin-left:auto; margin-right:auto; display:block; border:3px solid black;">
<b>Id: </b>
<%=p%><br>
<b>Price: </b>
<%=currFormat.format(rst.getDouble("productPrice"))%>      
<%
		
// TODO: Add links to Add to Cart and Continue Shopping
String prodName = rst.getString("productName");
	String productImageURL = "";
	if(prodName.contains(" ")) {
		productImageURL = prodName.replaceAll(" ","%20");
	}else {
		productImageURL = prodName;
	}
String addcartVal = "addcart.jsp?id=" + rst.getInt("productId") + "&name=" + productImageURL + "&price=" + rst.getDouble("productPrice");
%>
<h2><a href=<%=addcartVal%>>Add To Cart</a></h2>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
<%
closeConnection();
%>
</div>
</body>
</html>

