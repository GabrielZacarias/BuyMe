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
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		

		Statement stmt = con.createStatement();

		String searchOption = request.getParameter("searchOption");
		String sortOption = request.getParameter("sortOption");
		// Building the SQL Query statement
		String query = "SELECT a.* FROM auction a, item i, users u WHERE a.item_id = i.item_id and a.user_email = u.email";
		String queryCount = "SELECT COUNT(*) as c FROM auction a, item i, users u WHERE a.item_id = i.item_id and a.user_email = u.email";
		
		if (searchOption.equals("1")) { 
			// 1 => search by item name
			query += " and i.name like \"%";
			queryCount += " and i.name like \"%";
		} else if (searchOption.equals("2")) { 
			// 2 => search by auction title
			query += " and a.auction_title like \"%";
			queryCount += " and a.auction_title like \"%";
		} else if (searchOption.equals("3")) { 
			// 3 => search by user name
			query += " and u.name like \"%";
			queryCount += " and u.name like \"%";
		}
		query += request.getParameter("query") + "%\" ";
		if (sortOption.equals("1")){
			query += "ORDER BY start_price DESC";
		} else if (sortOption.equals("2")){
			query += "ORDER BY start_price ASC";
		} else if (sortOption.equals("3")){
			query += "ORDER BY item_id ASC";
		} else if (sortOption.equals("4")){
			query += "ORDER BY auction_title ASC";
		}
		queryCount += request.getParameter("query") + "%\"";
		System.out.println(query);
		//
	%>
		<h1>Returned 
		<% 
			ResultSet count = stmt.executeQuery(queryCount);
			int numResults = -1;
			if (count.next()){
				numResults = count.getInt("c");
			}
			if (numResults == 1){
				out.print("<u>" + numResults);
				out.print(" auction</u> ");
			} else if (numResults > 1){
				out.print("<u>" + numResults);
				out.print(" auctions</u> ");
			} else if (numResults == 0){
				out.print("<u>no auctions</u>");
			}
			out.print("for ");
			if (searchOption.equals("1")){ // 1 => search by item name
				out.print("<u>item name</u> query \"");
			} else if (searchOption.equals("2")) { // 2 => search by auction title
				out.print("<u>auction title</u> query \"");
			} else if (searchOption.equals("3")) { // 3 => search by user name
				out.print("<u>seller name</u> query \"");
			}	
			out.print(request.getParameter("query") + "\".");
		%> 
		</h1>
		Click on the Auction ID# to view auction details.
		<% 	ResultSet result = stmt.executeQuery(query); %>
		<table border="10" cellpadding="10" cellspacing="0">
			<tr>  
				<td>Auction ID#</td>
				<td>Auction Title</td>
				<td>Seller Email</td>
				<td>End Date</td>
				<td>Starting Price</td>
				<td>Item ID#</td>
				<td>List of Auction Bids</td> 
			</tr>
			<% while (result.next()) { %>
				<tr> 
					<td><a class="nav-item nav-link" href="view_auction.jsp?auctionid=<%= result.getString("auction_id") %>"><%= result.getString("auction_id") %></a></td>
					<td><%= result.getString("auction_title") %></td>
					<td><%= result.getString("user_email") %></td>
					<td><%= result.getString("end_time") %></td>
					<td><%= result.getString("start_price") %></td>
					<td><%= result.getString("item_id") %></td>
					<td>
						<form method="get" action="view_bids.jsp">
							<input type="hidden" name="auctionid" value="<%= result.getString("auction_id") %>">
							<input type="submit" value="View Auction #<%= result.getString("auction_id") %> Bids">
						</form>
					</td>
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