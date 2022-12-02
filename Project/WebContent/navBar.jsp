<div class="topnav">
  <a href="index.jsp">Homepage</a>
  <a href="listorder.jsp">Order List</a>
  <a href="topprod.jsp">Top Products</a>
  <div class="topnav-right">
  <a href="showcart.jsp">Cart</a>
  </div>
  <%
 if(session.getAttribute("authenticatedUser") != null){
        %>
         <p>  Signed in as: <%=session.getAttribute("authenticatedUser")%> </p>
        <%
	}
   %>

</div>
