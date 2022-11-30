<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Jo's Grocery Shipment Processing</title>
</head>
<body style="background-color:#FFFDD0;">

<style>
    .text-c {
		text-align: center;
	}
</style>
<div class = "text-c">
<%
	// TODO: Get order id
	String orderId= request.getParameter("orderId");
	

	// make connection
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "YourStrong@Passw0rd";
    Connection con = DriverManager.getConnection(url, uid, pw);
	con.setAutoCommit(false);

          
	// TODO: Check if valid order id
	try{
		int testId =Integer.parseInt(orderId);
		String orderIdCheck = "SELECT o.orderId "
		+"FROM orderproduct o "
		+"WHERE o.orderId = ?";
		PreparedStatement testOrder = con.prepareStatement(orderIdCheck);
	    testOrder.setInt(1,testId);
	    ResultSet testOrderId = testOrder.executeQuery();
		
		testOrderId.next();
		if(testId!=testOrderId.getInt(1)){
			%>
		<h1 style="text-align: center;">Order ID not found</h1>
		<h2 style="text-align: center;"><a href="header.jsp">Try Again</a></h2>
		<h2 style="text-align: center;"><a href="shop.html">Return To Jo&#39s Homepage</a></h2>
		<%
		

		}else{
			String sql ="SELECT o.orderId, o.productId,o.quantity,pi.quantity "
			+"FROM orderproduct o LEFT JOIN productinventory pi ON o.productId = pi.productId "
			+"WHERE o.orderId = ?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setInt(1,testId);
			ResultSet rs =stmt.executeQuery();
			int notDone=0;
		

			while(rs.next()){
				if(rs.getInt(3)>rs.getInt(4)){
				%>
				<br>
				<h1>Shipment not done. Insufficient inventory for product id: <%=rs.getInt(2)%></h1>

				<%
				notDone=1;
				break;
				}else{
					%>
				<br>
				
				<h2>Ordered product: <%=rs.getInt(2)%> Qty: <%=rs.getInt(3)%> Previous inventory: <%=rs.getInt(4)%> New inventory: <%=(rs.getInt(4)-rs.getInt(3))%></h2>
				<br>
                
				<%
				String update="UPDATE productinventory SET quantity=? WHERE productId=? ";
				PreparedStatement pstmt = con.prepareStatement(update);
				pstmt.setInt(1,(rs.getInt(4)-rs.getInt(3)));
				pstmt.setInt(2,rs.getInt(2));
				int updt= pstmt.executeUpdate();
				con.commit();
				}
			}
			if(notDone==0){
				%>
				<br>
				<h1>Shipment successfully processed.</h1>
				<%

			}
			
		}

	
	}catch(Exception ex) {
		%>
	<h1>order ID Is Invalid</h1>
		<h2><a href="header.jsp">Try Again</a></h2>
		<h2><a href="shop.html">Return To Jo&#39s Homepage</a></h2>
	<%
		con.rollback();
	}
	
	// TODO: Start a transaction (turn-off auto-commit)
	
	// TODO: Retrieve all items in order with given id
	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
	con.setAutoCommit(true);
%>                       				

<h2><a href="index.jsp">Back to Main Page</a></h2>
</div>
</body>
</html>
