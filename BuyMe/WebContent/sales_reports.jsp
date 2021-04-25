<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Sales Reports</title>
</head>
<body>
 <% if(session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
       } else {
    	   int is_admin = Integer.parseInt(session.getAttribute("isAdmin").toString());
    	   if (is_admin != 1) {
				response.sendRedirect("index.jsp");
				return;
    	   } %>	
    	<%@ include file="./includes/navbar.jsp" %>
	<div class="content">
	    	<h2>Select a sales report to generate</h2>
	    	<ul>
	            <li><a href="process_sales_reports.jsp?type=totalEarnings">Total Earnings</a></li>
	            <li><a href="process_sales_reports.jsp?type=earningsPerItem">Earnings per item</a></li>
	            <li><a href="process_sales_reports.jsp?type=earningsPerItemType">Earnings per item type</a></li>
	            <li><a href="process_sales_reports.jsp?type=earningsPerEndUser">Earnings per end-user</a></li>
	            <li><a href="process_sales_reports.jsp?type=bestSelling">Best-selling items</a></li>
	            <li><a href="process_sales_reports.jsp?type=bestBuyers">Best buyers</a></li>	            
	    	</ul>
    	</div>
    <% } %>
</body>
</html>