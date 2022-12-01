<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
// remember to include jdbc.jsp before using this file!
String adminId = request.getParameter("username");
String password = request.getParameter("password"); //adminname
	try
	{
		getConnection();
		PreparedStatement pstmt = con.prepareStatement("SELECT adminID FROM admin WHERE adminName = ?");
		pstmt.setString(1, password);
		ResultSet rs = pstmt.executeQuery();
		if(!rs.next())
		{
			String loginMessage = "You have not been authorized to access the URL "+request.getRequestURL().toString();
			session.setAttribute("loginMessage",loginMessage);        
			response.sendRedirect("adminLogin.jsp");
		}
		else
			response.sendRedirect("admin.jsp");
	}
	catch(SQLException e){
		out.println(e);
	}
	finally{
		closeConnection();
	}
%>