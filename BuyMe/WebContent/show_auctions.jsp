<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*"%>
    
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="ISO-8859-1">

<title>Show bids</title>
</head>
<body>
	<% if (session.getAttribute("name") == null) {
		response.sendRedirect("index.jsp");
	}%>
<%@ include file="./includes/navbar.jsp" %>
<div class="content">

	<% 
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {   		
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			String username = (session.getAttribute("user")).toString();
			String questionsQuery = "SELECT auction_id, user_email, item_id FROM auction";
			String check = "Awaiting answer from customer representative";
			
			ps = conn.prepareStatement(questionsQuery);
			rs = ps.executeQuery();
			
			if(rs.next()){ %> 
				<h2>Bids:</h2>
				<table> 
					<tr>
						<th>Auction Id</th>
						<th>Email</th>
						<th>Item Id</th>
					</tr>				
					<% do { %>
						<tr>
		    					<td><%= rs.getInt("auction_id") %></td>
		    					<td><%= rs.getString("user_email") %></td>
		    					<td><%= rs.getDouble("item_id") %></td>
		    			</tr>
			<% 		} while(rs.next()); %>
				</table>
			<% 	} else { %>
					<br><h2>No bids are active.</h2>	
			<%	}  %>	
			
		<%
		
		} catch (SQLException e){
			out.print("<p>Error connecting to MYSQL server.</p>");
		    e.printStackTrace();    			
		} finally {
			try { rs.close(); } catch (Exception e) {} 
		}   		
	%>
		
		
	</div>
</body>
</html>