<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*" %>
    
<%@ page import="java.io.*, java.text.*, java.util.Date, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales Reports</title>
</head>
<body>
 <% if(session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
       } else {
    	   int is_admin = Integer.parseInt(session.getAttribute("isAdmin").toString());
    	   if (is_admin != 1) {
				response.sendRedirect("index.jsp");
				return;
    	   } 
    	   String reportType = request.getParameter("type");%>	
    	<%@ include file="./includes/navbar.jsp" %>
	<div class="content">
	    <%	
	    	Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			Locale locale = new Locale("en", "US");
			NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
			
			try {
				ApplicationDB db = new ApplicationDB();
				Connection conn = db.getConnection();
				
				String query = null;
		    	if (reportType.equals("totalEarnings")) {
		    		query = "SELECT SUM(amount) FROM (SELECT auction_id, MAX(amount) as amount FROM bids_on GROUP BY auction_id) as x";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Total Earnings</th>
		    				</tr>	
		    		<%	do { %>
		    				<tr>
		    					<td><%= currency.format(rs.getDouble("SUM(amount)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    			</table>
		    			<br><a href="sales_reports.jsp">Click here to generate more sales reports.</a>
		    	<%	}		    		
		    	} else if (reportType.equals("earningsPerItem")) {
		    		query = "SELECT item_id, max(auto_bid_max) as max FROM bids_on b LEFT JOIN auction a on b.auction_id = a.auction_id group by b.auction_id";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Model</th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("item_id") %></td>
		    					<td><%= currency.format(rs.getDouble("max")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="sales_reports.jsp">Click here to generate more sales reports.</a>
		    	<%	}
		    	} else if (reportType.equals("earningsPerItemType")) {
		    		query = "select category_name, sum(maxx) from(select category_name, maxx from (SELECT item_id, max(auto_bid_max) as maxx FROM bids_on b LEFT JOIN auction a on b.auction_id = a.auction_id group by b.auction_id) as t left join item i on i.item_id=t.item_id) as y group by category_name";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Category</th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("category_name") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(maxx)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="sales_reports.jsp">Click here to generate more sales reports.</a>
		    	<%	}
		    	} else if (reportType.equals("earningsPerEndUser")) {
		    		query = "SELECT user_email, max(amount) as max FROM bids_on b LEFT JOIN auction a on b.auction_id = a.auction_id group by b.auction_id ORDER BY max desc";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>User</th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("user_email") %></td>
		    					<td><%= currency.format(rs.getDouble("max")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="sales_reports.jsp">Click here to generate more sales reports.</a>
		    	<%	}
		    	} else if (reportType.equals("bestSelling")) {
		    		query = "SELECT item_id, max(auto_bid_max) as max FROM bids_on b LEFT JOIN auction a on b.auction_id = a.auction_id group by b.auction_id ORDER BY max desc";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Item_ID</th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("item_id") %></td>
		    					<td><%= currency.format(rs.getDouble("max")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="sales_reports.jsp">Click here to generate more sales reports.</a>
		    	<%	}
		    	} else if (reportType.equals("bestBuyers")) {
		    		query = "SELECT email, sum(auto_bid_max) from(SELECT t1.email,t1.auto_bid_max FROM bids_on t1 INNER JOIN ( SELECT `auction_id`, MAX(auto_bid_max) AS max_bid FROM bids_on GROUP BY `auction_id`) t2 ON t1.`auction_id` = t2.`auction_id` AND t1.auto_bid_max = t2.max_bid) as z GROUP BY email ORDER BY sum(auto_bid_max) desc";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Buyer</th>
		    					<th>Total spent</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("email") %></td>
		    					<td><%= currency.format(rs.getDouble("sum(auto_bid_max)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="sales_reports.jsp">Click here to generate more sales reports.</a>
		    	<% }
		    	} else {
		    		// Invalid sales report type
		    		response.sendRedirect("error.jsp");
		    		return;
		    	}
			} catch (SQLException e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
			    e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception e) {}
				try { ps.close(); } catch (Exception e) {}
			}
	    %>	
    	</div>
    <% } %>

</body>
</html>