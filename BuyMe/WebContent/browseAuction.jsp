<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ include file="./includes/navbar.jsp" %>
	<form method="get" action="searchAuctions.jsp">
		<h1>Search Auctions By:</h1>
		<select name="searchOption">
			<option id="itemName" value="1">Item Name</option>
			<option id="auctionTitle" value="2">Auction Title</option>
			<option id="userName" value="3">User Name</option>
		</select>
		<div>
			<br>
			Search auctions list:
			<input type="text" name="query">
		</div>
		<h1>Choose sorting criteria:</h1>
		<div>
			<input type="radio" id="highLowBidPrice" name="sortOption" value=1 checked>
			<label for='highLowBidPrice'>Highest to Lowest Current Bid</label>
		</div>
		<div>
			<input type="radio" id="lowHighbidPrice" name="sortOption" value=2>
			<label for='lowHighBidPrice'>Lowest to Highest Current Bid</label>
		</div>
		<div>
			<input type="radio" id="itemID" name="sortOption" value=3>
			<label for='AZ'>Item ID</label>
		</div>
			<div>
			<input type="radio" id="azAuction" name="sortOption" value=4>
			<label for='ZA'>A-Z Auction Title</label>
		</div>
		<input type="submit" value="Submit">
	</form>
</body>
</html>