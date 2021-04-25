<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="buyMe.*"%>
<%@ page import= "java.io.*,java.util.*,java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

</head>

<body>
	<%
		//Get all data from current auction bid
		int auctionID = Integer.parseInt(request.getParameter("auctionid"));
		String seller = request.getParameter("sellerID");
		String bidder = session.getAttribute("user").toString();
		double sellerInc = Double.parseDouble(request.getParameter("seller_inc"));
		
		//get either starting amount if no bidders or current bid amount				
		double amount = Double.parseDouble(request.getParameter("curr_amt")) == 0 ? Double.parseDouble(request.getParameter("strt_price")) : Double.parseDouble(request.getParameter("curr_amt"));
		
		int bidIncrement = 0;
	    double autoMax = 0.0;
	    double bidAmount = 0.0;
	    int isAuto = -1;
	   
		//System.out.println("bidder: " + bidder);
		//System.out.println("seller: " + seller);
		//System.out.println("Curr Price: " + amount);
		//System.out.println("bidAmount: " + bidAmount);
		//System.out.println("Bid Increment: " + bidIncrement);
		//System.out.println("Max Bid Amt: " + autoMax);
		
		
		
		//check if bid is single or auto	
		if(request.getParameter("bid-amount") == null)
		{
			isAuto = 1;
			bidAmount = Double.parseDouble(request.getParameter("bidAmount"));
			bidIncrement = Integer.parseInt(request.getParameter("bidIncrement"));
			autoMax = Double.parseDouble(request.getParameter("auto_bid_max"));
		}
		else
		{
			isAuto = 0;
			bidAmount = Double.parseDouble(request.getParameter("bid-amount"));
			bidIncrement = 0;
			autoMax = bidAmount;
		}
		
		String url = "jdbc:mysql://localhost:3306/BuyMe";
		Connection conn = null;
		
		try {
			conn = DriverManager.getConnection(url, "root", "cs336SQL");
			Timestamp date = new Timestamp(new java.util.Date().getTime());
			int checker = 0;
			int alertNumber = -1;
			int equalMax = 0;
			
			
			//pull latest bid info by date
			String otherBiddersInfo = "SELECT * from bids_on WHERE auction_id = " + auctionID + " AND email <> \"" + bidder + "\" ORDER BY time_stamp DESC LIMIT 1";
			PreparedStatement otherBidderStmt = conn.prepareStatement(otherBiddersInfo);
			ResultSet otherBidders = otherBidderStmt.executeQuery(otherBiddersInfo);
			
			String addBid = "INSERT INTO bids_on VALUES (?,?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(addBid);

			ps.setInt(1, auctionID);
			ps.setTimestamp(3, date);
			boolean checkBid = otherBidders.next();
			
			
			//check if bidAmount is greater than amount and if bidder is not seller and if there is a previous bid
			if(bidAmount >= (amount + sellerInc) && !seller.equals(bidder) && checkBid)
			{
				checker = 1;
				equalMax = 0;

				//check if there is a prev bidder and compare to current bid
				if(checkBid)
				{
					String oldEmail = otherBidders.getString("email");
					int oldIncr = otherBidders.getInt("increment");
					double oldAmt = otherBidders.getDouble("amount");
					double oldMaxAmt = otherBidders.getDouble("auto_bid_max");	
					int oldIsMax = otherBidders.getInt("is_automatic");
					
					//compare max amount with old max amount
					if(autoMax > oldMaxAmt)
					{
						//check if prev bid is auto (1) is yes
						if(oldIsMax == 1)
						{					
							bidAmount = oldMaxAmt + bidIncrement;
						}
			
						ps.setString(2, bidder);
						ps.setDouble(4, bidAmount);
						ps.setInt(5, isAuto);
						ps.setInt(6, bidIncrement);
						ps.setDouble(7, autoMax);
						//session.setAttribute("msg", "Bid placed successfully!");
						//session.setAttribute("type", "alert-success");
						alertNumber = 0;
						
						// Alert other bidders that they have been outbid
			            Alert.notifyOtherBidders(auctionID, bidder);
					}
					//old autobid is greater than new bid
					else if (bidAmount >= (amount + sellerInc) && !seller.equals(bidder) && autoMax < oldMaxAmt)
					{
						oldAmt = autoMax + oldIncr;
						
						ps.setString(2, oldEmail);
						ps.setDouble(4, oldAmt);
						ps.setInt(5, isAuto);
						ps.setInt(6, oldIncr);
						ps.setDouble(7, oldMaxAmt);
						
						alertNumber = 2;
						
						//session.setAttribute("msg", "You've been outbid!");
						//session.setAttribute("type", "alert-danger");
						//System.out.println("old bidder: " + oldEmail);
						//System.out.println("curr bidder: " + bidder);
						
						Alert.notifyOtherBidders(auctionID, oldEmail);
					}
					//old bid cant bid over its maxAmount because adding its increment will go over max
					else if(((bidAmount + oldIncr) > oldMaxAmt) || (bidAmount >= (amount + sellerInc) && oldMaxAmt == autoMax))
					{
						ps.setString(2, bidder);
						ps.setDouble(4, bidAmount);
						ps.setInt(5, isAuto);
						ps.setInt(6, bidIncrement);
						ps.setDouble(7, autoMax);
						//session.setAttribute("msg", "Bid placed successfully!");
						//session.setAttribute("type", "alert-success");
						alertNumber = 0;
						
						// Alert other bidders that they have been outbid
			            Alert.notifyOtherBidders(auctionID, bidder);
					}
	
				}
				
			}
			//no previous bidders and bid amount is higher
			else if(bidAmount >= amount && !seller.equals(bidder) && !checkBid)
			{
				checker = 1;
				alertNumber = 0;

				ps.setString(2, bidder);
				ps.setDouble(4, bidAmount);
				ps.setInt(5, isAuto);
				ps.setInt(6, bidIncrement);
				ps.setDouble(7, autoMax);
			}
			else
			{
				//System.out.println("bid amount is low");
				alertNumber = 1;
				//session.setAttribute("msg", "Bid amount too low");
				//session.setAttribute("type", "alert-warning");
			}
			
			//
			if(bidAmount >= amount && !seller.equals(bidder) && checker == 1){
				ps.setInt(8, 0); //did win
				int addResultBid = ps.executeUpdate();
			}
			
			String alertMsg = "";
			String alertType = "";
			
			switch(alertNumber){
				case 0:
					alertMsg = "Bid placed Successfully";
					alertType = "alert-success";
					break;
				case 1:
					alertMsg = "Bid placed is too low";
					alertType = "alert-warning";
					break;
				case 2:
					alertMsg = "You have been outbid!";
					alertType = "alert-danger";
					break;
				case 3:
					alertMsg = "Oops, looks like your max bid is similar to another bidder. Try entering a higher amount.";
					alertType = "alert-warning";
					break;
				default:
					alertMsg = "";
					alertType = "";
					break;
			}
			
			session.setAttribute("msg", alertMsg);
			session.setAttribute("type", alertType);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
			response.sendRedirect("view_auction.jsp?auctionid=" + auctionID);
		}
	%>
</body>

</html>