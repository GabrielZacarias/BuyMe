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
<title>Change a user's account info</title>
</head>
<body>
<% if(session.getAttribute("user") == null) { 
    		response.sendRedirect("login.jsp");
       } else { %>
       
<%@ include file="./includes/navbar.jsp" %>
       
    	<div class="content">
    		<form action="process_change_users.jsp" method="POST">
    			<label>Email of account to be changed</label>
           		<input type="text" name="email" placeholder="Email" required> <br>
            	
            	<label>Enter Your Password</label>
            	<input type="password" name="your_password" placeholder="Enter Password" required> <br>
            	
            	<label>Confirm Your Password</label>
            	<input type="password" name="confirm_your_password" placeholder="Confirm Password" required> <br>
            	
            	<label>New Password</label>
            	<input type="password" name="new_password" placeholder="Confirm Password" required> <br>
    			
    			<label>Name you want to add to account</label>
           		<input type="text" name="new_name" placeholder="Name" required> <br>
           		
           		<label>Address you want to add to account</label>
           		<input type="text" name="new_address" placeholder="Adress" required> <br>
    			
    			<input type="submit" value="Change User's Account Information">
    		</form>
    		
    	</div>
    <% } %>
</body>
</html>