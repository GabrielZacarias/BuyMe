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
	ApplicationDB db = null;
	try {
		//Get the database connection
		db = new ApplicationDB();	
		Connection con = db.getConnection();		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get the selected radio button from the index.jsp
		String searchOption = request.getParameter("searchOption");
		String whereStmt = "WHERE ";
		String query = "SELECT email, name FROM users WHERE ";
		String queryCount = "SELECT COUNT(*) as c FROM users WHERE ";
		if (searchOption.equals("1")){ // 1 => search by user name
			query += "name like \"%";
			queryCount += "name like \"%";
			
		} else if (searchOption.equals("2")) { // 2 => search by email
			query += "email like \"%";
			queryCount += "email like \"%";
		}
		query += request.getParameter("query") + "%\"";
		queryCount += request.getParameter("query") + "%\"";
		System.out.println(query);
		//Run the query against the database.
	%>
		<h1>Returned 
			<% 
				ResultSet count = stmt.executeQuery(queryCount);
				int numResults = -1;
				if (count.next()){
					numResults = count.getInt("c");
				}
				if (numResults == 1){
					out.print(numResults);
					out.print(" user ");
				} else if (numResults > 1){
					out.print(numResults);
					out.print(" users ");
				} else if (numResults == 0){
					out.print(" no users ");
				}
				out.print("for ");
				if (searchOption.equals("1")) { // 2 => search by user name
					out.print("<u>user name</u> query \"");
				}	
				if (searchOption.equals("2")) { // 2 => search by user email
					out.print("<u>user email</u> query \"");
				}	
				out.print(request.getParameter("query") + "\".");
			%> 
		</h1>
		<% 	ResultSet result = stmt.executeQuery(query); %>
		<table border="10" cellpadding="10" cellspacing="0">
			<tr>  
				<td>Name</td>
				<td>Email</td>
			</tr>
			<% while (result.next()) { %>
				<tr> 
					<td><%= result.getString("name") %></td>
					<td><a class="nav-item nav-link" href="view_user.jsp?email=<%= result.getString("email") %>"><%= result.getString("email") %></a></td>
				</tr>
			<% }
			db.closeConnection(con);
			%>
		</table>	
	<%
	} catch (Exception e) {
		out.print(e);
	}
	%>
	

</body>
</html>