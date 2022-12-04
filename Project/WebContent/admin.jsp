<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="navbarAM.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./style.css" />
<script src="https://www.gstatic.com/charts/loader.js"></script>
<!-- Bootstrap core CSS -->
<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css'>
<link rel="stylesheet" href="./bootstrap.min.css">
<style>
  .center {
      margin: auto;
      width: 50%;
      padding: 10px;
  }

  .right {
      float: right;
      width: 50%;
      padding-left: 30px;
      padding-right: 10px;
  }

  .left {
      float: left;
      width: 50%;

  }
 </style>
</head>

<body style="background-color:#C4DEDC">
<div class="left" style="margin:10px;padding:10px;width: 500px">
    <h3><b>Administrator Sales Report by Day</b></h3>
    <br>
    <table class="table table-hover card" style="width: 500px">
        <thead>
        <tr class="table-info">
            <th scope="col" style="width: 200px;text-align: center">Order Date</th>
            <th scope="col" style="width: 300px;text-align: center">Total Order Amount</th>
      </tr>
    </thead>

    <%
        ArrayList<List<String>> list = new ArrayList<>();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        getConnection();
        String sql = "SELECT CONVERT(date,orderDate), sum(totalAmount) FROM ordersummary GROUP BY CONVERT(date, orderDate) ";
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rst = pstmt.executeQuery();
        while (rst.next()) {
    %>
    <tr>
        <td style="width: 200px;text-align: center"><%=rst.getDate(1)%>
        </td>
        <td style="width: 300px;text-align: center"><%=rst.getDouble(2)%>
        </td>
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
         width: 500,
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
<form name="MyForm" method=post action="editProduct.jsp" class="right">
        <br>
        <h3><b>Manage Products</b></h3>
        <br>
        <table>
            <tr>
                <td>
                    <div class="form-group" align="left"><b>Product ID:</b></div>
                </td>
                <td><br></td>
                <td><input class="form-control" placeholder="Enter your product id" type="text" name="id" size=30
                           maxlength=30 required></td>
            </tr>
            <tr>
                <td><br></td>
            </tr>
            <tr>
                <td colspan="3">
                    <input class="submit btn btn-lg btn-primary left" type="submit" name="Submit"
                           value="Update Inventory" style="width:100%; ">
                </td>
            </tr>
        </table>
        <br/>
    </form>
</body>
</html>
