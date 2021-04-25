package buyMe;

import java.sql.*;

public class Bid {
	public static boolean placeBid(int auctionID, double bidAmount, String bidder) throws Exception {
		// Validate ID and amount
		int isAuto = 0;
		int didWin = 0; // THIS IS PROB UNNECESSARY

		String auctionSelect = "select a.auction_id, a.user_email, a.start_time, a.end_time, a.start_price, a.increment, ( "
		+ "select max(b.amount) " + "from bids_on b " + "join auction a on a.auction_id = b.auction_id "
		+ "where a.auction_id = " + auctionID + ") curr_max " + "from auction a " + "where a.auction_id = "
		+ auctionID;

		//second to last in insertBid should be the same as the single bid amount
		String insertBid = "insert into bids_on values (?,?,?,?,?,?,?, ?)";

		ApplicationDB db = null;
		Connection con = null;
		ResultSet res = null;

		try {
			db = new ApplicationDB();
			con = db.getConnection();
			Statement stmt = con.createStatement();
			res = stmt.executeQuery(auctionSelect);

			if (res.next()) {
				double currMax = res.getDouble("curr_max") == 0 ? res.getDouble("start_price") : res.getDouble("curr_max");
				Timestamp currTime = new java.sql.Timestamp((new java.util.Date()).getTime());
				Timestamp startTime = res.getTimestamp("start_time");
				Timestamp closeTime = res.getTimestamp("end_time");
				double increment = res.getDouble("increment") == 0 ? .01 : res.getDouble("increment");
				String seller = res.getString("user_email");

				if (bidAmount >= currMax + increment && currTime.compareTo(startTime) >= 0 && currTime.compareTo(closeTime) < 0 && !seller.equals(bidder)) {
					PreparedStatement ps = con.prepareStatement(insertBid, Statement.RETURN_GENERATED_KEYS);
					ps.setInt(1, auctionID);
					ps.setString(2, bidder);
					ps.setObject(3, currTime);
					ps.setDouble(4, bidAmount);
					ps.setInt(5, isAuto);
					ps.setInt(6, 0);//increment amount for single bids
					ps.setDouble(7, bidAmount); //changed from autoMax to bidAmount
					ps.setInt(8, didWin);
					ps.executeUpdate();
					ps.close();
				}
			}
			res.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			db.closeConnection(con);

		}
		return true;
		
	}

}
