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

<title>Questions</title>
</head>
<body>
	<% if (session.getAttribute("name") == null) {
		response.sendRedirect("index.jsp");
	}%>
<%@ include file="./includes/navbar.jsp" %>
<div class="content">
	<%	if (request.getParameter("submit") != null && (request.getParameter("submit")).toString().equals("success")) { %>
			<h1>Your question has been submitted successfully.</h1>
	<%	} %>
	
		<h1>Submit a new question:</h1>
		<form action="process_questions.jsp" method="post">
			<textarea style="font-size: 18pt" rows="1" cols="90" maxlength="250" id="msg" name="Question"></textarea> <br>
			<input type="submit" value="Submit">					
		</form>	
	<% 
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {   		
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			String username = (session.getAttribute("user")).toString();
			String questionsQuery = "SELECT * FROM questions";
			String check = "Awaiting answer from customer representative";
			
			ps = conn.prepareStatement(questionsQuery);
			rs = ps.executeQuery();
			
			if(rs.next()){ %> 
				<h1> Question Results: </h1>
				<p style="font-size: 8pt;">
					**Please note that all questions may not be answered until a customer representative gets a chance to answer them** 
				</p>
				<table> 
					<tr>
						<th>Question</th>
						<th>Answer</th>
					</tr>				
					<% do { %>
						<tr>
							<td><%= rs.getString("question") %> </td>
							<% if (check.equals(rs.getString("answer"))
									&& (Integer.parseInt(session.getAttribute("isRep").toString()) == 1)) { %>
								<form action="process_answer.jsp?questionId=<%= rs.getInt("questionId") %>" method="POST">
									<td>
										<textarea type="textarea" name="Answer"></textarea>
										<input type="submit" value="Answer">
									</td>
								</form>
							<% } else { %>
							<td><%= rs.getString("answer") %> </td>
							<% } %>
						</tr>
			<% 		} while(rs.next()); %>
				</table>
			<% 	} else { %>
					<br><h2>No questions have been asked.</h2>	
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