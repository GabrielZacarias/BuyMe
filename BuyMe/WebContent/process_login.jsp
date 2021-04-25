<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*"%>
    
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<style>
main {
	height: 100vh;
	min-height: 100vh;
}

.container {
	max-width: 700px;
}

.alert {
	position: fixed;
	top: 0;
	width: 100%;
}
</style>
<meta charset="UTF-8">
<title>Processing Login</title>
</head>
<body>
<%
	ApplicationDB db = null;
	Connection con = null;
	ResultSet res = null;
	String name = "";
	String email = "";
	try {
		db = new ApplicationDB();
		con = db.getConnection();
		Statement stmt = con.createStatement();
		email = request.getParameter("email");
		String pass = request.getParameter("pass");
		//String s = "SELECT * FROM users WHERE email = '" + email + "'";
		String s = "select * from users where email='" + email + "' and password='" + pass + "'";
		res = stmt.executeQuery(s);
		String user_password = "";
		
	} catch (Exception e) {
		db.closeConnection(con);
		e.printStackTrace();
	}
%>

<% if (res.next()) { 
	session.setAttribute("user", email);
	session.setAttribute("isAdmin", res.getInt("isAdmin"));
	session.setAttribute("isRep", res.getInt("isRep"));
	session.setAttribute("name", res.getString("name"));
	%>
	<div class="alert alert-success" role="alert">Login successful!</div>
	<main class="container padding d-flex flex-column justify-content-center align-items-center">
		<div class='d-flex flex-column container'>
			<div class="card text-center mt-5">
				<div class="card-body">
					<h1>Welcome, <%= res.getString("name") == null ? email : res.getString("name") %>!</h1>
					<a href="index.jsp">Home</a>
					<br>
					<a href="post_auction.jsp">List a new auction</a>
					<br>
					<a href="logout.jsp">Logout</a>
				</div>
			</div>
		</div> 
	</main>
<%} else { %>
	<div class="alert alert-danger" role="alert">Invalid Username or password...</div>
	<main>
		<div class="d-flex flex-column container">
			<div class="card text-center mt-5">
				<div class="card-body">
					<h1>Sorry!</h1>
					<p><a href="login.jsp">Try again</a>
				</div>
			</div>
		</div>
	</main>
<%} %>

<% db.closeConnection(con); %>

</body>
</html>