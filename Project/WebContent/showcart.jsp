<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="navBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
</head>
<body style="background-color:#FFFDD0;">
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

	.topnav a:hover {
		background-color: #ddd;
		color: black;
	}

	.topnav a.active {
		background-color: #04AA6D;
		color: white;
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
</style>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	out.println("<H1>Your don't have any item in the cart</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th><th>Remove</th></tr>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");

		out.print("<td align=\"center\">"+product.get(3)+"</td>");
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		
		String removeCart="removeCart.jsp?id="+product.get(0);

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");
		%><td align=\"right\"><a href=<%=removeCart%>>remove item</a></td></tr><%
		
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	out.println("<h2><a href=\"order.jsp\">Check Out</a></h2>");
}
%>

<style>
.floating {
		position: fixed;
		width: 60px;
		height: 60px;
		bottom: 40px;
		right: 40px;
		background-color: #25d366;
		color: #fff;
		border-radius: 50px;
		text-align: center;
		font-size: 30px;
		box-shadow: 2px 2px 3px #999;
		z-index: 100;
	}

	.fab-icon {
		margin-top: 16px;
	}
</style>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />

<a href="https://wa.me/12508996062?text=Hi I would like to ask about your product!" class="floating" target="_blank">
<i class="fab fa-whatsapp fab-icon"></i>
</a>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html> 

