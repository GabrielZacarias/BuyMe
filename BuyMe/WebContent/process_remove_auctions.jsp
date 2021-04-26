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
		String user_email = request.getParameter("user_email");
		String item_id = request.getParameter("item_id");
		String yourPassword = request.getParameter("your_password");
		String confirmYourPassword = request.getParameter("confirm_your_password");
			
		
 %>
	
	<%	
	
		String query = "DELETE FROM auction WHERE auction_id=? AND user_email=? AND item_id=?";
		ps = conn.prepareStatement(query);
		int updateResult = 0;
		ps.setString(1, auction_id);
		ps.setString(2, user_email);
		ps.setString(3, item_id);
		updateResult = ps.executeUpdate();
		if (updateResult < 1) {
			// Failed to execute the update statement
			response.sendRedirect("error.jsp");
			return;
		} else { 
	%>
			<jsp:include page="remove_auctions.jsp" flush="true"/>
			<div class="content center">
				<h1>Successfully deleted user's auction.</h1>
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