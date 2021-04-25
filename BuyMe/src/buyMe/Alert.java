package buyMe;

import java.sql.*;
import java.io.*;
import java.util.*;

public class Alert {

	public static void alertWins(String user, Timestamp currTime) {
		String insert = "insert into alerts (user, message, auction_id, timestamp, isRead) " + "select * from "
				+ "(select b.email, \"You've won an auction!\" as message, a.auction_id, a.end_time, 0 as isRead "
				+ "from auction a " + "join bids_on b " + "on a.auction_id = b.auction_id "
				+ "where b.amount = (select max(b.amount) from bids_on b where b.auction_id = a.auction_id) "
				+ "and b.amount > a.min_sale_price " + "and b.email = \"" + user + "\"" + "and a.end_time < \""
				+ currTime + "\") t " + "where t.auction_id not in (" + "select a.auction_id from alerts a join ( "
				+ "select a.auction_id, b.email, b.amount, a.end_time " + "from auction a " + "join bids_on b "
				+ "on a.auction_id = b.auction_id " + "where b.amount = ( "
				+ "select max(b.amount) from bids_on b where b.auction_id = a.auction_id) "
				+ "and b.amount > a.min_sale_price " + "and b.email = \"" + user + "\") t "
				+ "on (a.auction_id = t.auction_id " + "and a.user = t.email) " + "where a.timestamp = t.end_time)";
		ApplicationDB db = null;
		Connection con = null;
		try {
			db = new ApplicationDB();
			con = db.getConnection();
			PreparedStatement ps = con.prepareStatement(insert);
			db = new ApplicationDB();
			con = db.getConnection();
			Statement stmt = con.createStatement();
			stmt.executeUpdate(insert);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.closeConnection(con);
		}
	}

	public static void markRead(int alertid) {
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			String update = "update alerts set isRead = 1 where alertid = " + alertid;
			Statement s = con.createStatement();
			s.executeUpdate(update);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void notifyOtherBidders(int auctionID, String bidder) {
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			String getOtherBidders = "select email from bids_on where auction_id = " + auctionID + " and email <> \"" + bidder + "\"";
			String insertAlerts = "INSERT INTO alerts (user, message, auction_id, timestamp, isRead) values (?,?,?,?,?)";
			Statement otherBiddersStmt = con.createStatement();
			ResultSet otherBidders = otherBiddersStmt.executeQuery(getOtherBidders);
			Timestamp currTime = new java.sql.Timestamp((new java.util.Date()).getTime());

			PreparedStatement ps;
			while (otherBidders.next()) {
				String otherBidder = otherBidders.getString("email");
				ps = con.prepareStatement(insertAlerts);
				ps.setString(1, otherBidder);
				ps.setString(2, "You have been outbid!");
				ps.setInt(3, auctionID);
				ps.setObject(4, currTime);
				ps.setInt(5, 0);
				ps.executeUpdate();
				ps.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public static void checkInterestedItems(String user) {
		ApplicationDB db = null;
		Connection con = null;
		try {
			db = new ApplicationDB();
			con = db.getConnection();
			Statement stmt = con.createStatement();
			ResultSet itemIDquery = stmt.executeQuery("SELECT item_id FROM interested_in WHERE email = \"" + user + "\"");
			ArrayList<Integer> interestedItems = new ArrayList<Integer>();
			
			while (itemIDquery.next()) interestedItems.add(itemIDquery.getInt("item_id"));
			
			int numItems = interestedItems.size();
			if (numItems == 0) return;
				
			String findAuctions = "SELECT * FROM auction WHERE (item_id = ";
			for (int i = 0; i < numItems; i++) {
				findAuctions += String.valueOf(interestedItems.get(i));
				if (i != numItems - 1) findAuctions += " OR item_id = ";
			}
			findAuctions += ") AND user_email != \"" + user + "\"";
			ResultSet maxID = stmt.executeQuery("SELECT MAX(alertid) as m from alerts");
			maxID.next();
			int newAlertID = maxID.getInt("m") + 1;
			ResultSet auctions = stmt.executeQuery(findAuctions);
			Timestamp currTime = new java.sql.Timestamp((new java.util.Date()).getTime());
			ArrayList<Integer> completedItemAlerts = new ArrayList<Integer>();
			
			while (auctions.next()) {
				int itemID = auctions.getInt("item_id");
				PreparedStatement ps = con.prepareStatement("INSERT into alerts VALUES (?,?,?,?,?,?)");
				ps.setInt(1, newAlertID);
				ps.setString(2, user);
				ps.setString(3, "An auction for Item #" + itemID + 
						" is available! To receive future alerts about Item #" + itemID +
						", browse for this item again and re-set an alert.");
				ps.setInt(4, auctions.getInt("auction_id"));
				ps.setObject(5, currTime);
				ps.setInt(6, 0);
				ps.executeUpdate();
				completedItemAlerts.add(interestedItems.remove(interestedItems.indexOf(itemID)));
			}
			for (int itemID : completedItemAlerts) {
				stmt.executeUpdate("DELETE FROM interested_in WHERE item_id = " + 
							String.valueOf(itemID) + " and email = \"" + user + "\"");
			}
		} catch(Exception e) {
			System.out.print(e);
		} finally {
			db.closeConnection(con);
		}
	}

}
