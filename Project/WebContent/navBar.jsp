<style>
.logo{
    width: 20%;
    height: 30%;
    margin: 0px;
}
</style>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="navbarColor02">
                
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">
                        <img src="img/logo.png" width="30" height="30" class="d-inline-block align-top"alt="logo">
                            Homepage
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="listprod.jsp">Product List
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="listorder.jsp">Order List</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="topprod.jsp">Top Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="showcart.jsp">Cart</a>
                    </li>
                </ul>

                    <%-- <li class="d-flex">
                        <%
                            if (session.getAttribute("authenticatedUser") != null) {
                        %>
                        <a class="nav-link text-white-50" href="#"> Signed in as:&nbsp <a class=" nav-link text-white" href="#"><%=session.getAttribute("authenticatedUser")%></a></a>
                        <%
                            }
                        %>
                        <br>
                    </li> --%>
                <ul class="navbar-nav navbar-right">
                     <li class="nav-item dropdown">
                        <%
                            if (session.getAttribute("authenticatedUser") != null) {
                        %>
                        <a class="nav-link dropdown-toggle"  id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Signed in as:&nbsp <%=session.getAttribute("authenticatedUser")%>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="logout.jsp">Sign Out</a>
                            <a class="dropdown-item" href="tel:1234567">Call Support</a>
                        </div>
                        <%
                            }else{
                        %>
                             <li class="nav-item">
                                <a class="nav-link" href="login.jsp">Sign In</a>
                            </li>
                        <%
                            }
                        %>
                    </li>
                </ul>
            </div>
        </div>
    </nav>


