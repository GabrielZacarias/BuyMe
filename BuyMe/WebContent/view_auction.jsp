<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*" %>
    
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>

<!DOCTYPE html>
<html>
<head>
<style>
.error {
	color: red;
}

</style>
<meta charset="UTF-8">
<title>Viewing Auction</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

</head>
<body>
<%@ include file="./includes/navbar.jsp" %>
<main class="container padding">

<%
		// TODO: format double currency
String auctionIDString = request.getParameter("auctionid");
try {
	int auctionID = Integer.parseInt(auctionIDString);
	java.sql.Timestamp currTime = new java.sql.Timestamp((new java.util.Date()).getTime());
	boolean isFinished = false;
		
	String itemSelect = "select a.*, i.*, ( " + "select max(b.amount)" +
			                                     "from bids_on b " +
			                                     "join auction a on a.auction_id = b.auction_id " +
			                                     "where a.auction_id = " + auctionID + 
			                              ") curr_max " +
		                "from auction a " +
		                "join item i on a.item_id = i.item_id " +
		                "where a.auction_id = " + auctionID;
	
	ApplicationDB db = null;
	Connection con = null;
	ResultSet itemRes = null;
	List<Map<String, Object>> specs = null;
	try {
		db = new ApplicationDB();
		con = db.getConnection();
		Statement itemStmt = con.createStatement();
		itemRes = itemStmt.executeQuery(itemSelect);
		
		if (!itemRes.next()) { %>
			<h1>Auction does not exist</h1>
			
		<%} else { 
		 	isFinished = itemRes.getTimestamp("end_time").compareTo(currTime) <= 0;
		%>
			<h1><%= itemRes.getString("auction_title") %></h1>
			<h3><%= itemRes.getString("name") %></h3>
			
			<div class="alert" id="alertMsg" role="alert" style="display: none"></div>
			
			<p>
			<% if (isFinished) { %>
				<b class="error">This auction has ended</b>
			<% } else { %>
				<b>Current Bid: </b><span id="price"><%= itemRes.getDouble("curr_max") == 0 ? "none" : Utils.format(itemRes.getDouble("curr_max")) %></span>
				<b>Auction Ending: </b><span id="close-time"><%= itemRes.getTimestamp("end_time") %></span>
				<b>Seller: </b><span id="seller"><%= itemRes.getString("user_email") %></span>
				

			</p>
			
			<hr>
			
			<%-- Single bid option --%>
			<p><b>Place Single Bid</b></p>
			
			<form action="bid_handle.jsp" method="post">
				<input type="hidden" id="auction_id" name="auctionid" <% out.print("value=\"" + itemRes.getInt("auction_id") + "\""); %>>
				<input type="hidden" id="user_email" name="sellerID" <% out.print("value=\"" + itemRes.getString("user_email") + "\""); %>>
				<input type="hidden" id="curr_max" name="curr_amt" <% out.print("value=\"" + itemRes.getDouble("curr_max") + "\""); %>>
				<input type="hidden" id="strt_price" name="strt_price" <% out.print("value=\"" + itemRes.getDouble("start_price") + "\""); %>>
				<input type="hidden" id="seller_inc" name="seller_inc" <% out.print("value=\"" + itemRes.getDouble("increment") + "\""); %>>
						
				<div class="form-group">
					<input type="text" class="form-control" id="bid-input" name="bid-amount" aria-describedby="bid-help" required>

					<small id="bid-amount" class="form-text text-muted">Enter <span><% out.print(itemRes.getDouble("curr_max") == 0 ? itemRes.getDouble("start_price") : Utils.format((itemRes.getDouble("curr_max") + itemRes.getDouble("increment")))); %></span> or greater</small>

				</div>
				
				<button type="submit" class="btn btn-primary" name="regB" value="0">Place Bid</button>
			</form>
			
			<hr>
			
			<%-- Auto bid option --%>
			<p><b>Place Automatic Bidding</b></p>
			
			<form action="bid_handle.jsp" method="post">
			
				<input type="hidden" id="auction_id" name="auctionid" <% out.print("value=\"" + itemRes.getInt("auction_id") + "\""); %>>
				<input type="hidden" id="user_email" name="sellerID" <% out.print("value=\"" + itemRes.getString("user_email") + "\""); %>>
				<input type="hidden" id="curr_max" name="curr_amt" <% out.print("value=\"" + itemRes.getDouble("curr_max") + "\""); %>>
				<input type="hidden" id="strt_price" name="strt_price" <% out.print("value=\"" + itemRes.getDouble("start_price") + "\""); %>>
				<input type="hidden" id="seller_inc" name="seller_inc" <% out.print("value=\"" + itemRes.getDouble("increment") + "\""); %>>
					
				<label>Initial Bid :</label>

				<input type="number" name="bidAmount" class="form-control" placeholder="Place <% out.print(itemRes.getDouble("curr_max") == 0 ? itemRes.getDouble("start_price") : Utils.format((itemRes.getDouble("curr_max") + itemRes.getDouble("increment")))); %> or greater" min="<% itemRes.getDouble("curr_max"); %>" required>

				<br>
				
				<label>Bid Increment:</label>
				<input type="number" name="bidIncrement" class="form-control" placeholder="Your increment amount" required>
				<br>
				
				<label>Max bid:</label>
				<input type="number" name="auto_bid_max" class="form-control" placeholder="Your max bid" required>
				
				<br>
				<button type="submit" value="auto_bid_btn" class="btn btn-primary">Auto Bid</button>
			</form>
			
			<br>
			<hr>
			<% } %>
			
			
			<h4>Item Description</h4>
			<p><%= itemRes.getString("description") %></p>
			
			<h4>Auction details</h4>
			<p><%= itemRes.getString("auction_description") %></p>
			<%	
				ArrayList<String> headers = new ArrayList<String>();
				String[] specsStrings = {"spec1", "spec2", "spec3", "spec4", "spec5", "spec6", "spec7", "spec8", "spec9", "spec10",
	                "spec11", "spec12", "spec13", "spec14", "spec15", "spec16", "spec17", "spec18", "spec19", "spec20"}; 
				// Getting the spec names for category
				String queryItem =  "select i.*" +
							"from item i, auction a " +
							"where i.item_id = a.item_id and a.auction_id = " + Integer.toString(auctionID);
				Statement stmt = con.createStatement();
				ResultSet result = stmt.executeQuery(queryItem); 
				result.next();
				String category = result.getString("category_name");
				
				ResultSet sub = stmt.executeQuery("SELECT subcategory_of FROM category WHERE name = \"" + category + "\"");
				sub.next();
				
				// If category is a subcategory of some parent category, append parent's spec names to front
				String parentCategory = sub.getString("subcategory_of");
				if (parentCategory != null){
					ResultSet parentSpecs = stmt.executeQuery("SELECT * FROM category WHERE name = \"" + parentCategory + "\"");
					parentSpecs.next();
					for (String spec : specsStrings){
						if (parentSpecs.getString(spec) != null){
							headers.add(parentSpecs.getString(spec));
						}
					}
				}
				ResultSet specNames = stmt.executeQuery("SELECT * FROM category WHERE name = \"" + category + "\"");
				specNames.next();
				for (String spec : specsStrings){
					if (specNames.getString(spec) != null){
						headers.add(specNames.getString(spec));
					}
				}

				
			%>
			<h4>Item specifications</h4>
			<ul>
				<%
					ResultSet result2 = stmt.executeQuery(queryItem); 
					result2.next();
				    for (int i = 0; i < headers.size(); i++){
				    	if (result2.getString(specsStrings[i]) != null){
				    	%>
				    		<li><b><%= headers.get(i) + ": " %></b><%= result2.getString(specsStrings[i]) %></li>
				    	<%
				    	} else{
				    		System.out.println(Integer.toString(i) + " is null");
				    	}
				    }
					%>
			</ul>
			<h4>Similar Auctions</h4>
			<%
			ResultSet queryCurrentAuction = stmt.executeQuery("SELECT item_id FROM auction WHERE auction_id = " + auctionID);
			queryCurrentAuction.next();
			int itemID = queryCurrentAuction.getInt("item_id");
			int[] similarAuctions = SimilarAuctions.getSimilarAuctions(auctionID, itemID);
			%>
			<table border="10" cellpadding="10" cellspacing="0">
			<tr> 
				<td>Auction ID</td>
				<td>Item ID</td>
				<td>Item Name</td>
			<%
			int numSimilarAuctions = 0;
			for (int auction : similarAuctions) {
				ResultSet sims = stmt.executeQuery("SELECT a.item_id, i.name FROM auction a, item i WHERE a.item_id = i.item_id AND a.auction_id = " + auction);
				while(auction != auctionID && sims.next()){
					numSimilarAuctions++;
			%>	
					<tr>
						<td><a class="nav-item nav-link" href="view_auction.jsp?auctionid=<%= auction %>"><%= auction %></a></td>
						<td><%= sims.getInt("item_id") %></td>
						<td><%= sims.getString("name")%></td>
					</tr>
			<%
				}	
			}
			%>
			
<%  }
		
	} catch (Exception e) {
		out.print(e);
	} finally {
		db.closeConnection(con);
	}
} catch (Exception e) {
	e.printStackTrace();%>
	<h1>Error: Invalid auction ID format</h1>
<%} %>
	</main>
	
	<%

		String alertMsg = (String) session.getAttribute("msg");
		String alertType = (String) session.getAttribute("type");
		//String finished = (String) session.getAttribute("finished");
		
		
	%>
	
	<script>
			
			let alertDiv = document.querySelector(".alert");
			
			let msg = "<%=alertMsg%>";
			let type = "<%=alertType%>";
			
			
			
			alertDiv.innerHTML = msg;
			alertDiv.classList.add(type);
			
			switch(type){
				case 'alert-success':
					alertDiv.classList.remove('alert-danger');
					alertDiv.classList.remove('alert-warning');
					alertDiv.style.display="block";
					break;
				case 'alert-warning':
					alertDiv.classList.remove('alert-danger');
					alertDiv.classList.remove('alert-success');
					alertDiv.style.display="block";
					break;
				case 'alert-danger':
					alertDiv.classList.remove('alert-success');
					alertDiv.classList.remove('alert-warning');
					alertDiv.style.display="block";
					break;
				default:
					alertDiv.style.display = 'none';
					alertDiv.classList.remove('alert-success');
					alertDiv.classList.remove('alert-danger');
					alertDiv.classList.remove('alert-warning');
					alertDiv.innerHTML = '';
					break;
			}
			
			
			window.setTimeout("closeDiv();", 4000);
			
			function closeDiv(){
				alertDiv.style.display="none";
			}
			
	</script>
</body>
</html>