<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ include file="jdbc.jsp" %>
<%-- navbar --%>
<%@ include file="navBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Top Dirt</title>
<link rel="stylesheet" type="text/css" href="./style.css" />
<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.2/css/bootstrap.min.css" integrity="sha384-y3tfxAZXuh4HwSYylfB+J125MxIs6mR5FOHamPBG064zB+AFeWH94NdvaCBm8qnd" crossorigin="anonymous">
<link rel="stylesheet" href="./bootstrap.min.css">
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
		height: 300px;
		width: 688px;
		margin: 0 auto;
		margin-bottom: 100px;
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
	.centered {
		display: block;
		margin-left: auto;
		margin-right: 290px;
		width: 60%;
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

String sql = "SELECT TOP 3 product.productId, productName, productImageURL, productPrice, SUM(quantity) AS totalQty " +
			"FROM orderproduct LEFT JOIN product ON orderproduct.productId = product.productId " +
			"GROUP BY product.productId, productName, productImageURL, productPrice " +
			"ORDER BY totalQty DESC";
PreparedStatement pstmt = con.prepareStatement(sql);
ResultSet rst = pstmt.executeQuery();
%>
	<div class="card-deck centered">
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
			<div class="card" style="width: 18rem;" >
				<img src=<%=rst.getString("productImageURL")%>  class="card-img-top" alt="Product Image">
				<div class="card-body">
					<h5 class="card-title"><a href=<%=prod%>><%=rst.getString("productName")%></a></h5>
					<p class="card-text"><%=rst.getInt("totalQty")%>&nbsp items sold!</p>
					<a href=<%=addCart%> class="btn btn-primary">Add To Cart</a>
				</div>
			</div>
		
	<%
}
	%>
		</div>	
	<%
	closeConnection();
    %>
    </body>
    </html>