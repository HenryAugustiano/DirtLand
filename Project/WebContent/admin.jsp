<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="jdbc.jsp" %>
<%@ include file="navBar.jsp" %>

<style> 
	.styled-table {
		border-collapse: collapse;
		margin: 25px 0;
		font-size: 0.9em;
		font-family: sans-serif;
		min-width: 400px;
		box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
	}

	.styled-table thead tr {
		background-color: #009879;
		color: #ffffff;
		text-align: center;
	}

	.styled-table th,
	.styled-table td {
    	padding: 12px 15px;	
	}
	.styled-table tbody tr {
		border-bottom: 1px solid #dddddd;
	}

	.styled-table tbody tr:nth-of-type(even) {
		background-color: #f3f3f3;
	}

	.styled-table tbody tr:last-of-type {
		border-bottom: 2px solid #009879;
	}

	.styled-table tbody tr.active-row {
		font-weight: bold;
		color: #009879;
	}

	.topnav {
			background-color: #333;
			overflow: hidden;
	}

	.topnav a {
		float: left;
		color: #f2f2f2;
		text-align: center;
		padding: 14px 16px;
		text-decoration: none;
		font-size: 17px;
	}

	.topnav a:hover {
		background-color: #ddd;
		color: black;
	}

	.topnav a.active {
		background-color: #04AA6D;
		color: white;
	}
	
	.topnav p {
		float: right;
		color: #f2f2f2;
		text-align: center;
		padding: 10px 10px;
		text-decoration: none;
		font-size: 17px;
		margin:0;
	}
</style>
<h3>Administrator Sales Report by Day</h3>
<font face="Arial" size="5">
  <table class="table" border="1">
    <tbody>
      <tr>
        <th>Order Date</th>
        <th>Total Order Amount</th>
      </tr>

<%
getConnection();
String sql = "SELECT CONVERT(date,orderDate), sum(totalAmount) FROM ordersummary GROUP BY CONVERT(date, orderDate) ";
PreparedStatement pstmt = con.prepareStatement(sql);
ResultSet rst = pstmt.executeQuery();
while(rst.next()) {
%>
      <tr>
        <td><%=rst.getDate(1)%></td>
        <td><%=rst.getDouble(2)%></td>
      </tr>
<%
}
closeConnection();
%>
    </tbody>
  </table>
</font>

</body>
</html>
