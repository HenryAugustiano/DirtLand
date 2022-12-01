<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// if success
	else
		response.sendRedirect("login.jsp");		// if fail, login again.
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;
		String pwd = null;
		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;

		try
		{
			getConnection();

			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
			String sql = "SELECT userid, password FROM customer WHERE userid = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1,username);

			ResultSet rst = pstmt.executeQuery();
			rst.next();
			String userid = rst.getString(1);
			String pass = rst.getString(2);


			if (pass.equals(password) && userid.equals(username)) {
				retStr = username;
				pwd = pass;
			}
			else {
				retStr = null;
			}
		}
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{	
			try{
			closeConnection();
			}
			catch(SQLException e){

			}
		}

		if(retStr != null)
		{	session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",username);
			session.setAttribute("password",pwd);
		}
		else
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");

		return retStr;
	}
%>
