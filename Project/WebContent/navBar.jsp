

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="navbarColor02">

                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">
                            <iconify-icon inline icon="ion:chevron-back-outline"></iconify-icon>
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

                    <li class="d-flex">
                        <%
                            if (session.getAttribute("authenticatedUser") != null) {
                        %>
                        <a class="nav-link text-white-50" href="#"> Signed in as:&nbsp <a class=" nav-link text-white" href="#"><%=session.getAttribute("authenticatedUser")%></a></a>
                        <%
                            }
                        %>
                        <br>
                    </li>
            </div>
        </div>
    </nav>


