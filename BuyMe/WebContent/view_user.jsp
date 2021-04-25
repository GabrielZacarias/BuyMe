<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*" %>
    
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

</head>
<body>
	<%@ include file="./includes/navbar.jsp" %>
	<% 
	try {
	%>
		<div style="text-align:center;">
			<h1>User: <%= request.getParameter("email")%></h1>
		</div>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//ResultSet bids = stmt.executeQuery(queryBids);
		Statement stmt = con.createStatement();
		Statement stmt2 = con.createStatement();
		String userEmail = request.getParameter("email");
		String bidCountquery = "SELECT COUNT(*) as c FROM bids_on WHERE email = \"" + userEmail + "\"";
		String queryBids = "SELECT b.auction_id, a.item_id, b.time_stamp FROM bids_on b, auction a WHERE b.auction_id = a.auction_id and b.email = \"" + userEmail + "\"";
		String aucCountquery = "SELECT COUNT(*) as c FROM auction WHERE user_email = \"" + userEmail + "\"";
		String queryAuctions = "SELECT auction_id, item_id FROM auction WHERE user_email = \"" + userEmail + "\"";
		System.out.println(queryAuctions);
		System.out.println(queryBids);
	%>
	<h2>
		Found
		<% 
			ResultSet aucCount = stmt.executeQuery(aucCountquery);
			int numAuctions = -1;
			if (aucCount.next()){
				numAuctions = aucCount.getInt("c");
			}
			if (numAuctions == 1){
				out.print("<u>" + numAuctions + " auction</u> ");
			} else if (numAuctions > 1){
				out.print("<u>" + numAuctions + " auctions</u> ");
			} else if (numAuctions == 0){
				out.print("<u>no auctions</u>");
			}
		%> 
		and 
		<% 
			ResultSet bidCount = stmt.executeQuery(bidCountquery);
			int numBids = -1;
			if (bidCount.next()){
				numBids = bidCount.getInt("c");
			}
			if (numBids == 1){
				out.print("<u>" + numBids + " bid</u> ");
			} else if (numBids > 1){
				out.print("<u>" + numBids + " bids</u> ");
			} else if (numBids == 0){
				out.print("<u>no bids</u>");
			}
		%> 
	</h2>
	
	
	<% 	ResultSet auctions = stmt.executeQuery(queryAuctions); %>
	<% 	ResultSet bids = stmt2.executeQuery(queryBids); %>
		<table border="10" cellpadding="10" cellspacing="0">
			<tr>
				<td colspan=2>Posted Auctions</td>
				<td></td>
				<td colspan=3>Bids</td>
			</tr>
			<tr>  
				<td>Auction ID#</td>
				<td>Item ID#</td>
				<td></td>
				<td>Auction ID#</td>
				<td>Item ID#</td>
				<td>Timestamp</td>
			</tr>
			<% 
			Boolean rowsLeft = true;
			while (rowsLeft == true) { 
				out.print("<tr>");
				Boolean printedAuction = false;
				Boolean printedBid = false;
				if (auctions.next()){
					out.print("<td><a class=\"nav-item nav-link\" href=\"view_auction.jsp?auctionid=" + auctions.getString("auction_id") + "\">" + auctions.getString("auction_id") + "</a></td>");
					out.print("<td>" + auctions.getString("item_id") + "</td>");
					printedAuction = true;
					out.print("<td></td>");
				} 
				if (bids.next()){
					if (printedAuction == false){
						out.print("<td></td>");
						out.print("<td></td>");
						out.print("<td></td>");
					}	
					out.print("<td><a class=\"nav-item nav-link\" href=\"view_auction.jsp?auctionid=" + bids.getString("auction_id") + "\">" + bids.getString("auction_id") + "</a></td>");
					out.print("<td>" + bids.getString("item_id") + "</td>");
					out.print("<td>" + bids.getString("time_stamp") + "</td>");
					printedBid = true;
				}
				if (printedAuction == true && printedBid == false){
					out.print("<td></td>");
					out.print("<td></td>");
					out.print("<td></td>");
				} else if (printedAuction == false && printedBid == false){
					rowsLeft = false;
				}
				out.print("</tr>");
			}
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