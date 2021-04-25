<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*" %>
        
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
	<form method="get" action="searchItems.jsp">
		<h1>Search Items List:</h1>
		<div>
			<h2>Select an item category:</h2>
			<select id="categoryList" name="category">
			<% 
				try {
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();		
			
					Statement stmt = con.createStatement();
					String query = "SELECT name FROM category";
					ResultSet categories = stmt.executeQuery("SELECT name FROM category"); 
					while (categories.next()){
						out.print("<option value=\"" + categories.getString("name") + "\">" + categories.getString("name") + "</option>"); 
					}
					db.closeConnection(con);
				} catch (Exception e) {
					out.print(e);
				}
			%>
			</select>
		</div>
		<br>
		<div>
			<h2>Enter a keyword(s) for the item name:</h2>
			<input type="text" name="query">
		</div>
		<br>
		<input type="submit" value="Submit">
	</form>
</body>
</html>