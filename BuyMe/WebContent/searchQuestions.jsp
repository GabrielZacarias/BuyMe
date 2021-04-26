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
<title>Search a question by keyword</title>
</head>
<body>
<% if(session.getAttribute("user") == null) { 
    		response.sendRedirect("login.jsp");
       } else { %>
       
<%@ include file="./includes/navbar.jsp" %>
       
    	<div class="content">
    		<form action="process_search_questions.jsp" method="POST">
    			<label>Search questions by keyword through entering a keyword</label>
           		<input type="text" name="keyword" placeholder="keyword" required> <br>
            	
    			
    			<input type="submit" value="Search">
    		</form>
    		
    	</div>
    <% } %>
</body>
</html>