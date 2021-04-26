<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*"%>
    
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Delete a user's auction</title>
</head>
<body>
<% if(session.getAttribute("user") == null) { 
    		response.sendRedirect("login.jsp");
       } else { %>
       
<%@ include file="./includes/navbar.jsp" %>
       
    	<div class="content">
    		<form action="process_remove_auctions.jsp" method="POST">
    			<label>Auction Id of auction to be removed</label>
           		<input type="text" name="auction_id" placeholder="Enter Auction Id" required> <br>
            	
            	<label>Enter the email of the auction owner</label>
            	<input type="text" name="user_email" placeholder="Enter Email" required> <br>
            	
            	<label>Enter the item id of the auction to be removed </label>
            	<input type="text" name="item_id" placeholder="Enter item id" required> <br>
    			
    			<input type="submit" value="Remove Bid">
    		</form>
    		
    	</div>
    <% } %>
</body>
</html>