<html>
<head>
    <title>Edit Product</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://code.iconify.design/iconify-icon/1.0.2/iconify-icon.min.js"></script>

    <script>
        const inputs = new Array();
        //waits for document to fully load
        $(document).ready(function () {
            //If the change button is clicked this function is executed
            $("#Change").click(function (e) {
                //prevents redirect and regurlar submission
                e.preventDefault();
                inputs[0] = (document.getElementById("name").value);
                //Changes so spaces can be within the name
                inputs[0] = inputs[0].replaceAll(' ', '%27');
                inputs[1] = (document.getElementById("price").value);
                inputs[2] = (document.getElementById("url").value);
                inputs[3] = (document.getElementById("desc").value);
                inputs[3] = inputs[3].replaceAll(' ', '%27');
                inputs[4] = (document.getElementById("catId").value);
                inputs[5] = (document.getElementById("id").value);
                //Any out.print will be printed to form-msg and async redirects to the backend to update
                $("#form-msg").load("editProductBackend.jsp?id=" + inputs[5] + "&name=" + inputs[0] + "&price=" + inputs[1] + "&url=" + inputs[2] + "&desc=" + inputs[3] + "&catId=" + inputs[4] + "&requests=0");
            });

            $("#Delete").click(function (e) {
                e.preventDefault();
                inputs[0] = (document.getElementById("name").value);
                inputs[0] = inputs[0].replaceAll(' ', '%27');
                inputs[1] = (document.getElementById("price").value);
                inputs[2] = (document.getElementById("url").value);
                inputs[3] = (document.getElementById("desc").value);
                inputs[3] = inputs[3].replaceAll(' ', '%27');
                inputs[4] = (document.getElementById("catId").value);
                inputs[5] = (document.getElementById("id").value);
                $("#form-msg").load("editProductBackend.jsp?id=" + inputs[5] + "&name=" + inputs[0] + "&price=" + inputs[1] + "&url=" + inputs[2] + "&desc=" + inputs[3] + "&catId=" + inputs[4] + "&requests=1");
            });
        });
    </script>

    <style>

        body {
            background-color: #C4DEDC;
        }

        .center {
            max-width: 500px;
            margin: auto;
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

        .row {
            background-color: #C4DEDC;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .column {
            flex: 50%;
            align-items: center;
            justify-content: center;
        }

        .padding {
            padding: 20px;
        }


    </style>

    <!-- Bootstrap core CSS -->
    <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css'>
    <link rel="stylesheet" href="./bootstrap.min.css">
</head>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="navbarColor02">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="admin.jsp">
                        <iconify-icon inline icon="ion:chevron-back-outline"></iconify-icon>
                        Back to Admin
                        <span class="visually-hidden">(current)</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<%@ page language="java" import="java.io.*,java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%
    String firstId = request.getParameter("id");
    int id = Integer.parseInt(firstId);

    Connection con = DriverManager.getConnection(url, uid, pw);

    String sql = "Select * From product Where productId = " + id;
    Statement stmt = con.createStatement();
    ResultSet rst = stmt.executeQuery(sql);

    rst.next();
    id = rst.getInt(1);
    String name = rst.getString(2);
    double price = rst.getDouble(3);
    String picURL = rst.getString(4);
    String image = rst.getString(5);
    String productDesc = rst.getString(6);
    int categoryId = rst.getInt(7);

%>

<body>

<div class="row padding">

    <div class="column center">
        <h1><b>Edit Product Info</b></h1>
        <h5 class="text-muted"> Update your item details here, once ready, click update product to update or
            delete
            current item.</h5>
    </div>


    <div class="column card bg-light mb-3" style="max-width: 40rem;">
        <form class="align-items-md-center " name="updateForm" method=POST action="editProductBackend.jsp">

            <div class="form-group">

                <div class="form-group">
                    <label for="name" class="form-label mt-4">Product Name</label>
                    <input type="text" class="form-control" id="name" name="Product Name"
                           value='<%out.print(String.format("%s",name));%>'>
                </div>

                <div class="form-group">
                    <label for="price" class="form-label mt-4">Price($)</label>
                    <input type="number" class="form-control" id="price" name="price"
                           value=<%out.print(String.format("%s",price));%>>
                </div>

                <div class="form-group">
                    <label for="url" class="form-label mt-4">Image URL</label>
                    <input type="text" class="form-control" id="url" name="url"
                           value='<%out.print(String.format("%s",picURL));%>'>
                    <small id="emailHelp" class="form-text text-muted">Enter your product photo path located under the
                        program
                        folder</small>
                </div>

                <div class="form-group">
                    <label for="desc" class="form-label mt-4">Product Description</label>
                    <textarea class="form-control" id="desc" name="Description" rows="3"
                              value='<%out.print(String.format("%s",productDesc));%>'></textarea>
                </div>

                <div class="form-group">
                    <fieldset>
                        <label for="catId" class="form-label mt-4">Category ID</label>
                        <input class="form-control" id="catId" name="address"
                               value=<%out.print(String.format("%d",categoryId));%> type="number">
                    </fieldset>
                </div>

                <div class="form-group">
                    <fieldset>
                        <label for="catId" class="form-label mt-4">Product ID</label>
                        <input class="form-control" id="id" name="productId"
                               value=<%out.print(String.format("%d",id));%> type="number">
                    </fieldset>
                </div>
                <br>
                <div class="d-grid gap-2">
                    <input class="btn btn-lg btn-primary" type="submit" name="Change" id="Change"
                           value="Update Product">
                    <input class="btn btn-lg btn-danger" type="submit" name="Delete" id="Delete" value="Delete Product">
                </div>

                <p id="form-msg"></p>

            </div>
        </form>
    </div>

</div>
</body>

</html>