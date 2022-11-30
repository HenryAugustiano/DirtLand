<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>

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
