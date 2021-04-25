<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*" %>
    
<%@ page import="java.io.*, java.text.SimpleDateFormat, java.util.Date, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String user = (String)session.getAttribute("user");
		String categoryName = request.getParameter("category");
		String subcategoryName = request.getParameter("subcategory");
		String itemName = request.getParameter("item-name");
		String itemDescription = request.getParameter("item-description");
		
		System.out.println("category : " + categoryName + " subcategory: " + subcategoryName + " item name: " + itemName + " descrip: " + itemDescription);
		
		
		String auctionTitle = request.getParameter("auction-title");
		String auctionDescription = request.getParameter("auction-description");
		// TODO: validate time
		String auctionClose = request.getParameter("auction-close");
		String[] parts = auctionClose.split("T");
		auctionClose = parts[0] + " " + parts[1] + ":00";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = sdf.parse(auctionClose);
		Object closeTime = new java.sql.Timestamp(date.getTime());
		
		Object startTime = new java.sql.Timestamp((new java.util.Date()).getTime());
		System.out.println("Currtime: " + startTime + " close: " + closeTime);
		
		String reserveString = request.getParameter("reserve");
		String initPriceString = request.getParameter("start-price");
		String incrementString = request.getParameter("increment");
		
		System.out.println("auction title: " + auctionTitle + " descript: " + auctionDescription + " auction close: " + auctionClose + " reserve: " + reserveString);
		System.out.println("Start: " + initPriceString + " increment: " + incrementString);
		
		List<String> specs = new ArrayList<String>();
		for (int i = 1; i <= 20; i++) {
			String spec = request.getParameter("spec-" + i);
			if (spec != null && spec.trim() == "") spec = null;
			specs.add(spec);
		}
		System.out.println(specs);
		
		// Convert types - need more validation
		double initPrice = -1;
		double increment = -1;
		double reserve = -1;
		try {
			// TODO: truncate floating points to 2
			initPrice = Utils.parseDouble(initPriceString);
			increment = Utils.parseDouble(incrementString);
			reserve = Utils.parseDouble(reserveString);
			System.out.println("init: " + initPrice + " increment: " + increment + " reserve: " + reserve);
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		}
		
		
		
		// Create item entry
		// Create Auction entry
		ApplicationDB db = null;
		Connection con = null;
		try {
			db = new ApplicationDB();
			con = db.getConnection();
			// Insert Item
			String insertItem = "INSERT INTO item (name, description, category_name, spec1, spec2, spec3, spec4, spec5, spec6, spec7, spec8, spec9, spec10, spec11, spec12, spec13, spec14, spec15, spec16, spec17, spec18, spec19, spec20) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(insertItem, Statement.RETURN_GENERATED_KEYS);
			String insertAuction = "";
			ps.setString(1, itemName);
			ps.setString(2, itemDescription);
			ps.setString(3, subcategoryName != null ? subcategoryName : categoryName);
			for (int i = 0; i < 20; i++) {
				ps.setString(i+4, i < specs.size() ? specs.get(i) : null);
			}
			System.out.println(ps.toString());
			ps.executeUpdate();
			ResultSet rs = ps.getGeneratedKeys();
			// Gets the generated ID.. do I need to catch an exception here?
			rs.next();
			int itemID = rs.getInt(1);
			
			// Insert auction
			String insertBid = "INSERT INTO auction (item_id, user_email, auction_title, start_time, end_time, start_price, increment, auction_description, min_sale_price) VALUES (?,?,?,?,?,?,?,?,?)";
			ps = con.prepareStatement(insertBid, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, itemID);
			ps.setString(2, user);
			ps.setString(3, auctionTitle);
			ps.setObject(4, startTime);
			ps.setObject(5, closeTime);
			ps.setDouble(6, initPrice);
			ps.setDouble(7, increment);
			ps.setString(8, auctionDescription);
			ps.setDouble(9, reserve);
			System.out.println(ps.toString());

			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			rs.next();
			int auctionID = rs.getInt(1);
			System.out.println("auctionID: " + auctionID);
			ps.close();
			response.sendRedirect("view_auction.jsp?auctionid=" + auctionID);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.closeConnection(con);
		}
		%>
		


</body>
</html>