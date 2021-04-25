<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	<%
		if ((session.getAttribute("user") != null) && (Integer.parseInt(session.getAttribute("isAdmin").toString()) == 1))
		{
	%>
			<a class="nav-item nav-link" href="index.jsp">Admin_Home</a>
			<a class="nav-item nav-link" href="create_rep.jsp">Create a customer rep account</a>
			<a class="nav-item nav-link" href="sales_reports.jsp">Generate Sales Reports</a>
			<a class="nav-item nav-link" href="logout.jsp">Logout</a>
	<%
		} else if ((session.getAttribute("user") != null) && (Integer.parseInt(session.getAttribute("isRep").toString()) == 1)) {
	%>
			<a class="nav-item nav-link" href="index.jsp">REP_Home</a>
			<a class="nav-item nav-link" href="questions.jsp">Answer questions</a>
			<a class="nav-item nav-link" href="edit_users.jsp">Delete user accounts</a>
			<a class="nav-item nav-link" href="change_users.jsp">Edit a user's accounts</a>
			<a class="nav-item nav-link" href="remove_bids.jsp">Remove a user's bid</a>
			<a class="nav-item nav-link" href="remove_auctions.jsp">Remove an auction</a>
			<a class="nav-item nav-link" href="logout.jsp">Logout</a>
	<%
		} else if (session.getAttribute("user") != null) {
	%>
			<a class="nav-item nav-link" href="index.jsp">Home</a>
			<a class="nav-item nav-link" href="browse.jsp">Browse</a>
			<a class="nav-item nav-link" href="post_auction.jsp">List a new auction</a>
			<a class="nav-item nav-link" href="user_dashboard.jsp">Dashboard</a>
			<a class="nav-item nav-link" href="item_Interests.jsp">Item Interests</a>
			<a class="nav-item nav-link" href="questions.jsp">Ask questions</a>
			<a class="nav-item nav-link" href="logout.jsp">Logout</a>
	<%
		} else { %>
			<a class="nav-item nav-link" href="login.jsp">Login</a>
			<a class="nav-item nav-link" href="register.jsp">Register</a>
	<%	}
	%>
</nav>
