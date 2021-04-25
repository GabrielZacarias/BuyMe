<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*"%>

<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>
		
	<% 
		Connection con = null;
		PreparedStatement ps = null;
			
		try {
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			
			String username = (session.getAttribute("user")).toString();
			String question = request.getParameter("Question");
			if(username != null && !username.isEmpty() && question != null && !question.isEmpty()){
				
				String insert = "INSERT INTO Questions (email, question, answer)" + "VALUES (?, ?, ?)";
				
				ps = conn.prepareStatement(insert);
				
				ps.setString(1, username);
				ps.setString(2, question);
				ps.setString(3, "Awaiting answer from customer representative");
				
				int result = 0;
		        result = ps.executeUpdate();
		        if (result < 1) {
		        	out.println("Error: Question failed.");
		        } else {
		        	response.sendRedirect("questions.jsp?submit=success");
		        	return;
		        }
			} else {
				response.sendRedirect("question_error.jsp");
				return;
			}    
		} catch(Exception e) {
	        out.print("<p>Error connecting to MYSQL server.</p>" + e);
	        e.printStackTrace();
	    } finally {
	        try { ps.close(); } catch (Exception e) {}
	    }
		        
		        
	%>