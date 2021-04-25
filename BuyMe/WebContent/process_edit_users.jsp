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
		String email = request.getParameter("email");
		String yourPassword = request.getParameter("your_password");
		String confirmYourPassword = request.getParameter("confirm_your_password");
	
		// Get the user's row from Account table
		String validation = "SELECT password FROM users WHERE email=?";
		pwPs = conn.prepareStatement(validation);
		pwPs.setString(1, user);
		rs = pwPs.executeQuery();
		
		// Make sure the user entered the correct current password
		if (rs.next()) {
			String db_password = rs.getString("password");
			if (!yourPassword.equals(db_password)) { %>
				<jsp:include page="edit_users.jsp" flush="true"/>
				<div class="content center">
					<h1>
						<br>Error: Current password is incorrect.<br>
						You must enter your correct password to make these changes.
					</h1>
				</div>
	    <%    	return;
			}
		} else {
			// No account found with the current user's username
			// Should never happen
			response.sendRedirect("error.jsp");
			return;
		}
		
		// Make sure the new password is entered correctly in the confirm box
		if (!yourPassword.equals(confirmYourPassword)) { %>
			<jsp:include page="edit_users.jsp" flush="true"/>
			<div class="content center">
				<h1>Error: Failed to confirm new password. <br> Make sure you enter it correctly in both fields.</h1>
			</div>
	<%		return;
		} %>
	
	<%	
	
		String query = "DELETE FROM users WHERE email=?";
		ps = conn.prepareStatement(query);
		int updateResult = 0;
		ps.setString(1, email);
		updateResult = ps.executeUpdate();
		if (updateResult < 1) {
			// Failed to execute the update statement
			response.sendRedirect("error.jsp");
			return;
		} else { 
	%>
			<jsp:include page="edit_users.jsp" flush="true"/>
			<div class="content center">
				<h1>Successfully deleted user's account.</h1>
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