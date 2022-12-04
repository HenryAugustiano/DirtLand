<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/homeStyle.css">
    <title>Dirt Land Inventory &#127981;</title>

    <!-- Bootstrap core CSS -->
    <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css'>
    <link rel="stylesheet" href="./bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="./style.css" />
    <!--styles-->
    <style>
        table, th, td {
            margin-left: auto;
            margin-right: auto;
            border-collapse: collapse;
            width: 500px;
            text-align: center;
            font-size: 20px;
        }

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

<body style="background-color:#FFFDD0">
<%-- admin navbar --%>
<div class="topnav">
  <a href="admin.jsp">Sales Report</a>
  <a href="inventory.jsp">Inventory</a>
  <a href="adminListCust.jsp">Customer List</a>
  <div class="topnav-right">
  <a href="index.jsp">Homepage</a>
  </div>
</div>

<div style="margin:10px;padding:10px">

    <h5 class="main">Here's your most recent inventory details:</h5>
    <div class="main left">
        <%
            try {

                String sql = " SELECT * FROM productinventory";
                getConnection();
                Statement stmt = con.createStatement();
                ResultSet rst = stmt.executeQuery(sql);


                out.println(
                        "<table class=\"table table-hover table-primary\"" +
                                "<tr><th scope=\"col\">Product ID</th>" +
                                "<th scope=\"col\">Warehouse ID</th>" +
                                "<th scope=\"col\">Quantity</th>" +
                                "<th scope=\"col\">Price</th></tr>");
                while (rst.next()) {
                    out.println(
                            "<tr class=\"table-secondary\"><td>" + rst.getString(1) +
                                    "</td><td>" + rst.getString(2) +
                                    "</td><<td>" + rst.getString(3) +
                                    "</td><<td>" + rst.getString(4) +
                                    "</td></tr>");
                }
                out.println("</table>");


            } catch (SQLException ex) {
                out.println(ex);
            } finally {
                closeConnection();
            }

        %>
    </div>
    <form name="MyForm" method=post action="editInventory.jsp" class="right center">
        <table style="display:inline">
            <tr>
                <td>
                    <div class="form-group" align="left">Product ID:</div>
                </td>
                <td><input class="form-control" placeholder="Enter your product id" type="text" name="pID" size=10
                           maxlength=10 required></td>
            </tr>
            <tr>
                <td>
                    <div class="form-group" align="left">New Quantity:</font>
                    </div>
                </td>
                <td><input class="form-control" placeholder="Enter your new quantity" type="text" name="quant" size=10
                           maxlength=10 required></td>
            </tr>
            <tr>
                <td><br></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input class="submit btn btn-lg btn-primary left" type="submit" name="Submit"
                           value="Update Inventory" style="width:100%; ">
                </td>
            </tr>
        </table>
        <br/>
    </form>

</div>
</body>
</html>

