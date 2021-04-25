<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*"%>
    
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>
    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ include file="./includes/navbar.jsp" %>
	<%
	String user = (String) session.getAttribute("user");
	if (user == null) response.sendRedirect("index.html");
	ApplicationDB db = null;
	Connection con = null;
	try {
		db = new ApplicationDB();
		con = db.getConnection();
		Statement stmt = con.createStatement();
		ResultSet result = stmt.executeQuery("SELECT w.*, i.name FROM interested_in w, item i WHERE w.item_id = i.item_id and w.email = \"" + user + "\"");
	
	%>	
		<h1>Your Item Interests</h1>
		<br>
		<table border="10" cellpadding="10" cellspacing="0">
			<tr>  
				<td>Item ID</td>
				<td>Item Name</td>
			<tr>
		<% while (result.next()) { %>
			<tr> 
				<td><%= result.getInt("item_id") %></td>
				<td><%= result.getString("name") %></td>
			</tr>
	<%
			}
	} catch(Exception e){
		out.print(e);
	} finally {
		db.closeConnection(con);
	}
	%>
</body>
</html>