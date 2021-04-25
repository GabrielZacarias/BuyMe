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
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		

		Statement stmt = con.createStatement();
		String auctionIDString = request.getParameter("auctionid");
		int auctionID = Integer.parseInt(auctionIDString);
		String queryCount = "SELECT COUNT(*) as c FROM bids_on WHERE auction_id = " + auctionIDString;
		String query = "SELECT email, time_stamp, amount FROM bids_on WHERE auction_id = " + auctionIDString;
	%>
		<h1>
		Viewing 
			<%			
			ResultSet count = stmt.executeQuery(queryCount);
			int numResults = -1;
			if (count.next()){
				numResults = count.getInt("c");
			}
			if (numResults == 1){
				out.print("<u>" + numResults);
				out.print(" bid</u> ");
			} else if (numResults > 1){
				out.print("<u>" + numResults);
				out.print(" bids</u> ");
			} else if (numResults == 0){
				out.print("<u>no bids</u>");
			} 
			%>
		for Auction #<u><%= auctionIDString %></u>
		</h1>
		<% 	ResultSet result = stmt.executeQuery(query); %>
		<table border="10" cellpadding="10" cellspacing="0">
			<tr>  
				<td>Bidder Email</td>
				<td>Bid Date</td>
				<td>Bid Amount</td> 
			</tr>
		<% while (result.next()) { %>
			<tr> 
				<td><%= result.getString("email") %></td>
				<td><%= result.getString("time_stamp") %></td>
				<td><%= result.getString("amount") %></td>
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