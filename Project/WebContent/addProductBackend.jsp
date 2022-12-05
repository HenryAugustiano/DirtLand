<%@ page language="java" import="java.io.*,java.sql.*,java.util.ArrayList" %>
<%@ include file="jdbc.jsp" %>
<html>
<head>
    <title>Add Product</title>
    <link rel="stylesheet" type="text/css" href="./style.css" />
</head>
<body>
<style>

        body {
            background-color: #C4DEDC;
        }
</style>
<%

    //Note: Forces loading of SQL Server driver
    try
    {	// Load driver class
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    }
    catch (java.lang.ClassNotFoundException e)
    {
        out.println("ClassNotFoundException: " +e);
    }

    String pName = request.getParameter("name");
    String pPrice = request.getParameter("price");
    String pUrl = request.getParameter("url");
    String pDesc = request.getParameter("desc");
    String pCatId = request.getParameter("categoryId");

    if(pName.equals("") || pPrice.equals("") || pDesc.equals("") || pCatId.equals("") || pUrl.equals("")) {
        %>
        <div class = "text-c">
        <h2>Please fill the form completely.</h2><br> 
        <h3><a href="addProduct.jsp">Back to Add Product Form</a></h3><br><br><br>
        </div>
        <%
    }else{
    try{
        getConnection();

        String sql = "INSERT product(productName, categoryId, productPrice, productImageURL, productDesc) VALUES (?,?,?,?,?)";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, pName);
        pstmt.setString(2, pCatId);
        pstmt.setString(3, pPrice);
        pstmt.setString(4, pUrl);
        pstmt.setString(5, pDesc);
        pstmt.executeUpdate();
    }catch (Exception e){
        out.print(e);
    }finally{	
        closeConnection();	
    }
    %>
        <div class = "text-c">
        <h2>Added Product Successfully</h2><br> 
        <h3><a href="admin.jsp">Back to Admin Page</a></h3><br><br><br>
        </div>
    <%
}
%>
</body>
</html>