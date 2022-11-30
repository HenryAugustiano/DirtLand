<%
	// logout user from the session 
	session.setAttribute("authenticatedUser",null);
	response.sendRedirect("index.jsp");		// go to main page
%>

