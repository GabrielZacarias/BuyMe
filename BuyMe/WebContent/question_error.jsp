<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*"%>

<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Question - Error</title>
</head>
<body>
<% if(session.getAttribute("user") == null) { 
    		response.sendRedirect("login.jsp");
       } else { %>
    	<%@ include file="./includes/navbar.jsp" %>
    	<div class="content">
    		<h2>Please input a question </h2>
    		<p><%=session.getAttribute("user")%>, <a href="questions.jsp">Ask a question.</a></p>
    		<p> Otherwise, <a href="index.jsp">Return to home page.</a></p>
    	</div>
    <% } %>
</body>
</html>