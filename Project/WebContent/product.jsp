<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="navBar.jsp" %>
<%-- <%@ include file='listReview.jsp' %> --%>
<html>
<head>
<title>Dirt Land - Product Information</title>
<link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="./style.css" />
<!-- Bootstrap core CSS -->
<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css'>
<link rel="stylesheet" href="./bootstrap.min.css">
</head>
<body style="background-color:#FFFDD0;">
<link rel="stylesheet"
 href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
 <a href="https://wa.me/12508996062?text=Hi I would like to ask about your product!" class="floating" target="_blank">
 <i class="fab fa-whatsapp fab-icon"></i>
 </div>
 </a>
<%
getConnection();
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.CANADA);
// Get product name to search for
// TODO: Retrieve and display info for the product
String p = request.getParameter("id");
int prodId = Integer.parseInt(p);

String sql = "SELECT productId, productName, productPrice, productImageURL, productDesc " +
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
     <img src=<%=imagePath%> alt = "Product Image" width="500" height="350">
<%
}
%><br><%	
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
String displayImgDatabase = "displayImage.jsp?id=" + prodId;
%>
<img src="<%=displayImgDatabase%>" onerror="this.remove();"  style="margin-left:auto; margin-right:auto; display:block; border:3px solid black; ">
<b><font size="4.5px">Id: </b>
<%=p%><br>
<b>Price: </b>
<%=currFormat.format(rst.getDouble("productPrice"))%>
 <br><br><br>
 <b>Description: </b><br>
 <p><%=rst.getString("productDesc")%></font></p>     
 <br><br>  
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

//list review for corresponding product
String sqlreview = "SELECT reviewRating, reviewComment FROM review WHERE productId = ?";
PreparedStatement pstmtReview = con.prepareStatement(sqlreview);
pstmtReview.setInt(1,prodId);
ResultSet rstReview = pstmtReview.executeQuery();
if(!rstReview.next()){
	out.println("There's no review for this product right now.");
}else{
		%>
			<table class="styled-table"; border="1" style="border-collapse:collapse;margin-left:auto;margin-right:auto;font-family: Futura;">
			<thead>
				<tr>
					<th>Rating</th>
					<th>Comment</th>
				</tr>
			</thead>			
		<%
		do{
		%>
			<tr>
			<td><%=rstReview.getInt("reviewRating")%></td>
			<td><%=rstReview.getString("reviewComment")%></td>
			</tr>
		<%
		}while(rstReview.next());
	}

%>
</table>
<h2><a href=<%=addcartVal%>>Add To Cart</a></h2>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
<% 
String addreview = "addReview.jsp?id=" + prodId;
%>
<%-- for review form --%>
<a href= <%=addreview %>>
<button>Review this product! </button>
</a>
<%
closeConnection();
%>
</div>
</body>
</html>

