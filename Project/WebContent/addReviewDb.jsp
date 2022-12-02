<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title> inserting review to db</title>
</head>

<body style="background-color:#FFFDD0">
<%
String uname = (String)session.getAttribute("authenticatedUser");
int rating = Integer.parseInt(request.getParameter("rating"));
if(rating == 0)
    rating = -1;
String comment = request.getParameter("comment");
if(comment == null)
    comment = "";
int prodId = Integer.parseInt(request.getParameter("prodId"));

getConnection();
//get uid cid first
String cidSQL = "SELECT customerId FROM customer WHERE userid = ?";
PreparedStatement pstmtCid = con.prepareStatement(cidSQL);
pstmtCid.setString(1,uname);
ResultSet rst1 = pstmt.executeQuery();
rst.next();
String cid = rst1.getString("customerId");

//add review to db
String SQL = "INSERT INTO review (reviewRating, customerId, productId, reviewComment) VALUES (?,?,?,?)";
PreparedStatement pstmt = con.prepareStatement(SQL);

pstmt.setInt(1,rating);
pstmt.setInt(2,cid);
pstmt.setInt(3,prodId);
pstmt.setString(4,comment);

pstmt.executeUpdate();
%>

<h3>success add review</h3>
</body>
</html>
