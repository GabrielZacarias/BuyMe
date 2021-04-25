<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="buyMe.*"%>

<%@ page import="java.io.*, java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<style>
	.hidden {
		display: none;
	}
</style>
</head>
<body>
	<%@ include file="./includes/navbar.jsp"%>
	<main class="container padding">
		<%
		String user = (String) session.getAttribute("user");
		if (user == null) response.sendRedirect("index.html");

		// Get win alerts
		Timestamp currTime = new java.sql.Timestamp((new java.util.Date()).getTime());
		Alert.alertWins(user, currTime);
		Alert.checkInterestedItems(user);
		
		ApplicationDB db = null;
		Connection con = null;
		ResultSet res = null;
		try {
			db = new ApplicationDB();
			con = db.getConnection();
			Statement stmt = con.createStatement();
			String s = "select a.*, b.auction_title from alerts a join auction b on (a.auction_id = b.auction_id) where user = \""
			+ user + "\"";
			res = stmt.executeQuery(s);
		%>
		<section class="container alerts border border-light rounded">
			<h4>New Alerts</h4>
			<div class="list-group">
				<% while (res.next()) { %>

				<!--  Print alert -->
				<a href="view_auction.jsp?auctionid=<%=res.getInt("auction_id")%>"
					<% String classList = "list-group-item list-group-item-action flex-column align-items-start"; 
					// if previously read, hide
					if (res.getInt("isRead") == 1) {
						classList += " hidden";
					}%>
					class=<%= "\"" + classList + "\"" %>>
					<div class="d-flex w-100 justify-content-between heading">
						<h5><%=res.getString("auction_title")%></h5>
						<small><%=res.getDate("timestamp")%></small>
					</div>
					<p><%=res.getString("message")%></p> 
					<div class="d-flex w-100 justify-content-between heading">
						<small>Click to go to auction..</small>
						<!--  If unread, add "Mark as Read" button -->
					<% if (res.getInt("isRead") == 0) { %>
						<form action="mark_alert_read.jsp" method="post">
							<input type="hidden" name="alertid"
								<%out.print("value=\"" + res.getInt("alertid") + "\"");%>>
							<button class="btn btn-primary">Mark as read</button>
						</form>
					<% } %>
					</div>
				</a>
				<%
				}
				%>
			</div>
			<button class="btn btn-primary" id="viewAll">View All</button>
		</section>
		<%
			db.closeConnection(con);
		} catch (Exception e) {
			db.closeConnection(con);
			e.printStackTrace();
		}
		%>



	</main>
</body>
<script>
document.querySelector("#viewAll").addEventListener("click", e => {
	const oldAlerts = document.querySelectorAll(".hidden")
	oldAlerts.forEach(alert => alert.classList.remove("hidden"))
})

</script>
</html>