<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Top Dirt</title>
<link rel="stylesheet" type="text/css" href="./style.css" />
<div class="topnav">
  <a href="index.jsp">Homepage</a>
  <a href="listprod.jsp">Product List</a>
  <a href="listorder.jsp">Order List</a>
  <div class="topnav-right">
  	<a href="showcart.jsp">Cart</a>
	</div>
</div>
<div class = "text-c">
<h1> Top Products of the Store</h1>
<div id="slideshow">
        <div class="slide-wrapper">
            <div class="slide">
                <h1 class="slide-number">
                    <img src="img/5.jpg" alt="img1" width="600" height="400">
                </h1>
            </div>
            <div class="slide">
                <h1 class="slide-number">
                    <img src="img/3.jpg" alt="img2" width="600" height="400">
                </h1>
            </div>
            <div class="slide">
                <h1 class="slide-number">
                    <img src="img/16.jpg" alt="img3"width="600" height="400">
                </h1>
            </div>
            <div class="slide">
                <h1 class="slide-number">
                    <img src="img/8.jpg" alt="img3"width="600" height="400">
                </h1>
            </div>
            <div class="slide">
                <h1 class="slide-number">
                    <img src="img/7.jpg" alt="img3"width="600" height="400">
                </h1>
            </div>
        </div>
    </div>
	</div>
    <style> 
	#slideshow {
		overflow: hidden;
		height: 410px;
		width: 688px;
		margin: 0 auto;
	}

	.slide {
		float: left;
		height: 410px;
		width: 688px;
	}

	.slide-wrapper {
		width: calc(688px * 6);
		animation: slide 20s ease infinite;
	}
	
	@keyframes slide {
	20% {
		margin-left: 0px;
	}
	
	40% {
		margin-left: calc(-688px * 1);
	}
	
	60% {
		margin-left: calc(-688px * 2);
	}

    80% {
		margin-left: calc(-688px * 3);
	}

    100% {
		margin-left: calc(-688px * 4);
	}
	}
</style>
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />

<a href="https://wa.me/12508996062?text=Hi I would like to ask about your product!" class="floating" target="_blank">
<i class="fab fa-whatsapp fab-icon"></i>
</div>
</a>
    </head>
    <body style="background-color:#FFFDD0">
    <%
    try {	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    }
    catch (java.lang.ClassNotFoundException e) {
        out.println("ClassNotFoundException: " +e);
    }

    NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.CANADA);
    getConnection();

    String sql = "SELECT TOP 5 product.productId, productName, productImageURL, productPrice, SUM(quantity) AS totalQty " +
				"FROM orderproduct LEFT JOIN product ON orderproduct.productId = product.productId " +
				"GROUP BY product.productId, productName, productImageURL, productPrice " +
                "ORDER BY totalQty DESC";
	PreparedStatement pstmt = con.prepareStatement(sql);
    ResultSet rst = pstmt.executeQuery();

    %>
<table class="styled-table"; border="1" style="border-collapse:collapse;margin-left:auto;margin-right:auto;font-family: Futura;">
	<thead>
		<tr>
			<th></th>
			<th>Product Id</th>
			<th>Product Name</th>
			<th>Produt Image</th>
            <th>Product Price</th>
			<th>Total Qty Ordered</th>
		</tr>
	</thead>
<%
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
			<td><a href=<%=addCart%>>Add To Cart</a></td>
			<td><%=rst.getInt("productId")%></a></font></td>
			<td><a href=<%=prod%>><%=rst.getString("productName")%></font></td>
			<td><img src=<%=rst.getString("productImageURL")%> alt = "Product Image" width="100" height="70"></td>
            <td><%=currFormat.format(rst.getDouble("productPrice"))%></font></td>
            <td><%=rst.getInt("totalQty")%></font></td>
		</tr>
	<%
}
	
    %>
    </body>
    </html>