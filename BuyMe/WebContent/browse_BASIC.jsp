<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*" %>
    
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Browse</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

</head>
<body>
<%@ include file="./includes/navbar.jsp" %>
<main class="container padding">

<%
ApplicationDB db = null;
Connection con = null;
ResultSet res = null;
try {
	db = new ApplicationDB();
	con = db.getConnection();
	Statement stmt = con.createStatement();
	String auctionSelect = "select a.*, i.category_name, i.name, (select max(b.amount) as curr_max from bids_on b join auction a2 on a2.auction_id = b.auction_id where a2.auction_id = a.auction_id) curr_max from auction a join item i on a.item_id = i.item_id";
	res = stmt.executeQuery(auctionSelect); %>
	<div class="list-group">
	<% 
	java.sql.Timestamp currTime = new java.sql.Timestamp((new java.util.Date()).getTime());
	while (res.next()) { 
		if (res.getTimestamp("end_time").compareTo(currTime) > 0) { %>
		<a href="view_auction.jsp?auctionid=<%= res.getInt("auction_id") %>" class="list-group-item list-group-item-action flex-column align-items-start">
			<div class="d-flex w-100 justify-content-between heading">
				<h5><%= res.getString("auction_title") %></h5>
				<small>Ending: <%= res.getDate("end_time") %></small>
			</div>
			<p>
			<%= res.getString("name") %>
			<br>
			<b>Category: </b><%= res.getString("category_name") %>
			<br>
			<b>Seller: </b><%= res.getString("user_email") %>
			<br>
			<b>Current Price: </b><%= res.getDouble("curr_max") == 0 ? "$" + res.getDouble("start_price") : "$" + res.getDouble("curr_max") %>
			</p>
		</a>
	<% }
	}
	
} catch (Exception e) {
	db.closeConnection(con);
	e.printStackTrace();
}
%>
</main>
</body>
</html>