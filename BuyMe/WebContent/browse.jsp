<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ include file="./includes/navbar.jsp" %>
	<h1>What would you like to browse, <%= session.getAttribute("name") == null ? session.getAttribute("user") : session.getAttribute("name") %>?</h1>

	<form method="get" action="process_browse.jsp">
		<div>
			<input type="radio" id="auctions" name="searchType" value=1>
			<label for='auctions'>Auctions</label>		
		</div>  
		<div>
			<input type="radio" id="users" name="searchType" value=2>
			<label for='users'>Other Users</label>
		</div>
		<div>
			<input type="radio" id="items" name="searchType" value=3>
			<label for='items'>Items</label>
		</div>
		<input type="submit" value="Submit">
	</form>
</body>
</html>