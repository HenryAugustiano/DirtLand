<%@ include file="navBar.jsp" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./style.css" />
<script src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body style="background-color:#FFFDD0">
<script type="text/javascript">
    google.charts.load("current", {packages:['corechart']});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ["Order Date", "Amount", { role: "style" } ],
        ["2019-10-13", 532, "gold"],
        ["2019-10-14", 105, "gold"],
        ["2019-10-15", 221, "gold"]
      ]);

      var view = new google.visualization.DataView(data);
      view.setColumns([0, 1,
                       { calc: "stringify",
                         sourceColumn: 1,
                         type: "string",
                         role: "annotation" },
                       2]);

      var options = {
        title: "Sales Report For Administrator",
        width: 600,
        height: 400,
        bar: {groupWidth: "95%"},
        legend: { position: "none" },
      };
      var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
      chart.draw(view, options);
  }
  </script>

<div class = "text-c">
<h2>Administrator Sales Report by Day</h2>
<font face="Arial" size="5">
  <table class="styled-table"; border="1" style="border-collapse:collapse;margin-left:auto;margin-right:auto;font-family: Futura;">
    <thead>
      <tr>
        <th>Order Date</th>
        <th>Total Order Amount</th>
      </tr>
    </thead>

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
<div id="columnchart_values" style="width: 900px; height: 300px;"></div>
</div>
</body>
</html>
