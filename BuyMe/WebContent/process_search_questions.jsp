<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*"%>
    
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Search Reports</title>
</head>
<body>
<% if(session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
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
				String keyword = request.getParameter("keyword");
				String keyword_2 = "%"+keyword+"%";
				
				String query = null;
		    	if (session.getAttribute("user") != null) {
		    		query = "SELECT * FROM questions WHERE question LIKE ? ";
		    		ps = conn.prepareStatement(query);
		    		ps.setString(1, keyword_2);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Search Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Question ID</th>
		    					<th>Email</th>
		    					<th>Question</th>
		    					<th>Answer</th>
		    				</tr>	
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getInt("questionId") %></td>
		    					<td><%= rs.getString("email") %></td>
		    					<td><%= rs.getString("question") %></td>
		    					<td><%= rs.getString("answer") %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    			</table>
		    			<br><a href="searchQuestions.jsp">Click here to search for more terms by keyword.</a>
		    	<%	}		    		
		    	} else {
		    		// Invalid sales report type
		    		response.sendRedirect("error.jsp");
		    		return;
		    	}
			} catch (SQLException e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
			    e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception e) {}
				try { ps.close(); } catch (Exception e) {}
			}
	    %>	
    	</div>

</body>
</html>