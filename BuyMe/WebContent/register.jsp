<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*"%>
    
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<style>

main {
	display: flex;
	flex-direction: column;
	width: 100%;
	height: 100vh;
	justify-content: center;
	align-items: center;
}

.container {
	max-width: 700px;
}
</style>

<title>Registration</title>
</head>
<body>
	<% if (session.getAttribute("name") != null) {
		response.sendRedirect("index.jsp");
	}%>
	<main>
		<div class="container">
			<div class="card mt-5">
				<div class="card-body text-center">
					<h1>Register</h1>
					<form action="process_registration.jsp" method="post">
						<div class="form-group row">
							<label class="col-form-label" for="email"><b>Email</b></label>
				   			<input class="form-control" type="text" placeholder="Email..." name="email" id="email" required>
						</div>
						<div class="form-group row">
				    		<label class="col-form-label" for="pass"><b>Password</b></label>
				    		<input class="form-control" type="password" placeholder="Password.." name="pass" id="pass" required>
						</div>
						<div class="form-group row">
				    		<label class="col-form-label" for="name"><b>Name</b></label>
				    		<input class="form-control" type="text" placeholder="Name.." name="name" id="name" required>
						</div>
						<div class="form-group row">
				    		<label class="col-form-label" for="address"><b>Address</b></label>
				    		<input class="form-control" type="text" placeholder="Address.." name="address" id="address" required>
						</div>
						<button class="btn btn-primary" type="submit">Register</button>
					</form>
				</div>
			</div>
		</div>
	</main>
</body>
</html>