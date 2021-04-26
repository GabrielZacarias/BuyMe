<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*"%>
    
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>


<%
	
	Connection con = null;		
	PreparedStatement ps = null;
	PreparedStatement pwPs = null;
	ResultSet rs = null;
	try {
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		
		String user = (session.getAttribute("user")).toString();
		String auction_id = request.getParameter("auction_id");
		String email = request.getParameter("email");
		String amount = request.getParameter("amount");
		String yourPassword = request.getParameter("your_password");
		String confirmYourPassword = request.getParameter("confirm_your_password");
			
		
 %>
	
	<%	
	
		String query = "DELETE FROM bids_on WHERE auction_id=? AND email=? AND amount=?";
		ps = conn.prepareStatement(query);
		int updateResult = 0;
		ps.setString(1, auction_id);
		ps.setString(2, email);
		ps.setString(3, amount);
		updateResult = ps.executeUpdate();
		if (updateResult < 1) {
			// Failed to execute the update statement
			response.sendRedirect("error.jsp");
			return;
		} else { 
	%>
			<jsp:include page="remove_bids.jsp" flush="true"/>
			<div class="content center">
				<h1>Successfully deleted user's bid.</h1>
			</div>
	<% 	}
		
		
	} catch(Exception e) {
		out.print("<p>Error connecting to MYSQL server.</p>");
	    e.printStackTrace();
	} finally {
		try { rs.close(); } catch (Exception e) {}
		try { ps.close(); } catch (Exception e) {}
		try { pwPs.close(); } catch (Exception e) {}
	}
%>