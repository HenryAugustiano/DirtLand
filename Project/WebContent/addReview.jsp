<%@ include file="navBar.jsp" %>
<%@ include file="auth.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Dirt Land Order List</title>
<link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="./style.css" />
<!-- Bootstrap core CSS -->
<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css'>
<link rel="stylesheet" href="./bootstrap.min.css">
<style>

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
	
	.topnav p {
		float: right;
		color: #f2f2f2;
		text-align: center;
		padding: 10px 10px;
		text-decoration: none;
		font-size: 17px;
		margin:0;
	}

	.topnav a:hover {
		background-color: #ddd;
		color: black;
	}

	.topnav a.active {
		background-color: #04AA6D;
		color: white;
	}	
    body{
        text-align: center;
    }
</style>

</head>
<body style="background-color:#FFFDD0">
<%
int prodId = Integer.parseInt(request.getParameter("id"));
%>
<h2> reviewing product as : <%=session.getAttribute("authenticatedUser")%></h2>
<%-- form to get review --%>
<form method="get" action="addReviewDb.jsp">
    <label for="rating">rating (1-5)</label>
    <input type="number" name="rating" min="1" max="5"><br>
    <label for="desc">comment: </label>
    <input type="text" name="desc"><br>
    <input type=hidden name="prodId" value=<%=prodId%>>
    <input type="submit">
   
</form>
</body>
</html>