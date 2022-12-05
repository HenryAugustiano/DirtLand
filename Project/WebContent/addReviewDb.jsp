<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title> inserting review to db</title>
<link rel="stylesheet" type="text/css" href="./style.css" />
<!-- Bootstrap core CSS -->
<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css'>
<link rel="stylesheet" href="./bootstrap.min.css">
</head>

<body style="background-color:#FFFDD0">
<%
String uname = (String)session.getAttribute("authenticatedUser");
int rating = Integer.parseInt(request.getParameter("rating"));
if(rating == 0)
    rating = -1;
String comment = request.getParameter("desc");
if(comment == null)
    comment = "broken addreview.db";
int prodId = Integer.parseInt(request.getParameter("prodId"));

getConnection();
//get uid cid first
String cidSQL = "SELECT customerId FROM customer WHERE userid = ?";
PreparedStatement pstmtCid = con.prepareStatement(cidSQL);
pstmtCid.setString(1,uname);
ResultSet rst1 = pstmtCid.executeQuery();
rst1.next();
int cid = rst1.getInt("customerId");


//add review to db
String SQL = "INSERT INTO review (reviewRating, customerId, productId, reviewComment) VALUES (?,?,?,?)";
PreparedStatement pstmt = con.prepareStatement(SQL);

pstmt.setInt(1,rating);
pstmt.setInt(2,cid);
pstmt.setInt(3,prodId);
pstmt.setString(4,comment);

pstmt.executeUpdate();
%>
<h3>Success add review</h3>
</body>
</html>
