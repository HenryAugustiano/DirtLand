<html>
<head>
    <title>Add Product</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://code.iconify.design/iconify-icon/1.0.2/iconify-icon.min.js"></script>

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
<body>

<div class="row padding">

    <div class="column center">
        <h1><b>Add Product Form</b></h1>
    </div>


    <div class="column card bg-light mb-3" style="max-width: 40rem;">
        <form class="align-items-md-center " name="updateForm" method=POST action="addProductBackend.jsp">

            <div class="form-group">

                <div class="form-group">
                    <label for="name" class="form-label mt-4">Product Name</label>
                    <input type="text" class="form-control" id="name" name="name">
                </div>

                <div class="form-group">
                    <label for="price" class="form-label mt-4">Price($)</label>
                    <input type="number" class="form-control" id="price" name="price">
                </div>

                <div class="form-group">
                    <label for="url" class="form-label mt-4">Image URL</label>
                    <input type="text" class="form-control" id="url" name="url">
                    <small id="emailHelp" class="form-text text-muted">Enter your product photo path located under the
                        program
                        folder</small>
                </div>

                <div class="form-group">
                    <label for="desc" class="form-label mt-4">Product Description</label>
                    <textarea class="form-control" id="desc" name="desc" rows="3"></textarea>
                </div>

                <div class="form-group">
                    <fieldset>
                        <label for="catId" class="form-label mt-4">Category ID</label>
                        <input class="form-control" id="catId" name="categoryId" type="number">
                    </fieldset>
                </div>
                <br>
                <div class="d-grid gap-2">
                    <input class="btn btn-lg btn-primary" type="submit" id="Add" value="Add Product">
                </div>
        </form>
    </div>

</div>
</body>

</html>