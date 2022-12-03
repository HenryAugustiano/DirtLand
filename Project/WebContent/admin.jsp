<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./style.css" />
<script src="https://www.gstatic.com/charts/loader.js"></script>
<style>
 .centered {
           display: fixed;
           margin-left: auto;
           margin-right: auto;
           width: 55%;
         }
 </style>
</head>
<%-- admin navbar --%>
<div class="topnav">
  <a href="admin.jsp">Sales Report</a>
  <a href="inventory.jsp">Inventory</a>
  <div class="topnav-right">
  <a href="index.jsp">Homepage</a>
  </div>
</div>

<body style="background-color:#FFFDD0">
<div class = "text-c">
<h2>Administrator Sales Report by Day</h2>
<font face="Arial" size="5">
  <table class="styled-table"; border="1" style="border-collapse:collapse;margin-left:auto;margin-right:auto;">
    <thead>
      <tr>
        <th>Order Date</th>
        <th>Total Order Amount</th>
      </tr>
    </thead>

<%
ArrayList<List<String>> list = new ArrayList<>();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
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
 java.util.Date jDate = new java.util.Date(rst.getDate(1).getTime());
  String[] temp = new String[2];
  temp[0] = formatter.format(jDate);
  temp[1] = Double.toString(rst.getDouble(2));
  list.add(Arrays.asList(temp));
}
closeConnection();
%>
    </tbody>
  </table>
  <script type="text/javascript">
     google.charts.load("current", {packages:['corechart']});
     google.charts.setOnLoadCallback(drawChart);
     var arry = [];
     arry.push(["Order Date", "Amount"]);
     let one;
     var two;
     <%
         for(int i = 0; i < list.size(); i++){
             %>
             one ="<%=list.get(i).get(0)%>";
             two =<%=list.get(i).get(1)%>
             arry.push([one, two])
             <%
             }
             %>

     function drawChart() {
       var data = google.visualization.arrayToDataTable(arry);
       var view = new google.visualization.DataView(data);

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
</font>
<div id="columnchart_values" style="width: 900px; height: 300px;margin-left:auto;margin-right:auto;"></div>
</div>
</body>
</html>
