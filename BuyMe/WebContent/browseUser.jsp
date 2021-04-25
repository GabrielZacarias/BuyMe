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
	<form method="get" action="searchUsers.jsp">
		<h1>Search User By:</h1>
		<select name="searchOption">
			<option id="email" value="1">User Name</option>
			<option id="name" value="2">User Email</option>
		</select>
		<div>
			<br>
			Search users list:
			<input type="text" name="query">
		</div>
		<br>
		<input type="submit" value="Submit">
	</form>
</body>
</html>