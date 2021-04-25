<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error!</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
</head>
<body>
	<%@ include file="./includes/navbar.jsp"%>
	<main class="container">
		<%
		String forwardURL = request.getParameter("forwardURL");
		String forwardMessage = request.getParameter("forwardMessage");
		String errorMessage = request.getParameter("errorMessage");
		if (errorMessage == null)
			errorMessage = "There was an error processing your request... please try again";
		%>
		<div class="alert alert-danger" role="alert">
			<%=errorMessage%>
		</div>
		<div class="forwardLink">
			<% if (forwardURL != null && forwardMessage != null) { %>
			<a class="btn btn-primary" href="<%=forwardURL%>"><%=forwardMessage%></a>
			<% } %>
		</div>
	</main>
</body>
</html>