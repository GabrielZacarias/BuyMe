<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>
    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Home</title>
<style>
main {
	height: 100vh;
	min-height: 100vh;
}

.container {
	max-width: 700px;
}

}
</style>
</head>
<body>
<%@ include file="./includes/navbar.jsp" %>
<% if (session.getAttribute("user") != null) {
					%>
	
	<div class="layout-content">
	<% } %>
	<main class="d-flex flex-column container justify-content-center align-items-center">
		<div class="card text-center mt-5">
			<div class="card-body">
				<% if (session.getAttribute("user") == null) {
					%>
					<h1>Welcome!</h1>
					<p><a href="register.jsp">Register here</a></p>
					<p><a href="login.jsp">Login here</a></p>
				<% } else { %>
					<h1>Hello <%= session.getAttribute("name") == null ? session.getAttribute("user") : session.getAttribute("name") %></h1>
					<h4>Role: 
					<%
						if (Integer.parseInt(session.getAttribute("isAdmin").toString()) == 1) {
							out.print("Admin");
						} else if (Integer.parseInt(session.getAttribute("isRep").toString()) == 1) {
							out.print("Customer Representative");
						} else {
							out.print("User");
						}
					%>
					</h4>
					<p><a href="logout.jsp">Logout</a>
				<%} %>
				
				
			</div>
		</div>
	</main>
	</div>
</body>
</html>