<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>
<html>
<head>
<title>update inventory</title>
</head>
<body>
        
<%
    int productId = Integer.parseInt(request.getParameter("pID"));
    int quantity = Integer.parseInt(request.getParameter("quant"));

    // if productid and quantity are null, then redirect to inventory page

    if (productId == 0 || quantity == 0) {
        response.sendRedirect("inventory.jsp");
    }

    try 
    {
        getConnection();
		String sql3 = String.format("UPDATE productinventory SET quantity = %d WHERE productId = %d", quantity, productId);
		PreparedStatement pstmt3 = con.prepareStatement(sql3);
		pstmt3.executeUpdate();
		out.println("<h2><a href=index.jsp>Back to Main Page</a></h2>");
        closeConnection();
        response.sendRedirect("inventory.jsp");
    } 
    catch (SQLException ex) {
        out.println(ex);
    }
    finally
    {
        closeConnection();
    }
%>                       				

</body>
</html>
