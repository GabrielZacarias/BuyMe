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

.alert {
	position: fixed;
	top: 0;
	width: 100%;
}
</style>
<meta charset="UTF-8">
<title>Registration Processing</title>
</head>
<body>
<%
	boolean success = false;
	String email = request.getParameter("email");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	int status = 0;
	
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		PreparedStatement ps = con.prepareStatement("INSERT INTO users values(?,?,?,?,0,1)");
		ps.setString(1, email);
		ps.setString(2, pass);
		ps.setString(3, name);
		ps.setString(4,  address);
		status = ps.executeUpdate();
		db.closeConnection(con);
		success = true;
	} catch (SQLIntegrityConstraintViolationException e) {
		e.printStackTrace();

	} catch (Exception e) {
		e.printStackTrace();
	}
%>

<% if (success) { %>
	
	<div class="alert alert-success" role="alert">Rep Registration successful!</div>
	<main>
	<%@ include file="./includes/navbar.jsp" %>
		<div class="d-flex flex-column container">
			<div class="card text-center mt-5">
				<div class="card-body">
					<h1>Thanks, <%= name %>!</h1>
					<h4>You've registered a rep account: <%= email %>!</h4>
					<p><a href="index.jsp">Return to admin home</a>
			</div>
		</div>
	</div>
	</main>
	
<%} else { %>
	<div class="alert alert-warning" role="alert">email already registered</div>"
	<main>
	<%@ include file="./includes/navbar.jsp" %>
		<div class="d-flex flex-column container">
			<div class="card text-center mt-5">
				<div class="card-body">
					<h1>Sorry!</h1>
					<p><a href="create_rep.jsp">Try again</a>
			</div>
		</div>
	</div>
	</main>
<%}%>

</body>
</html>