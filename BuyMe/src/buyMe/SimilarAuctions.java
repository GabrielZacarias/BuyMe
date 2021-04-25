package buyMe;

import java.sql.*;
import java.io.*;
import java.util.*;

public class SimilarAuctions {
	public static int[] getSimilarAuctions(int auctionID, int itemID) {
		System.out.println(auctionID);
		System.out.println(itemID);
		int numAuctions = 0;
		int[] similarAuctions = new int[3];
		ApplicationDB db = null;
		Connection con = null;
		try {
			db = new ApplicationDB();
			con = db.getConnection();
			Statement stmt = con.createStatement();
			ResultSet itemInfo = stmt.executeQuery("SELECT category_name FROM item WHERE item_id = " + itemID);
			itemInfo.next();
			String itemCategory = itemInfo.getString("category_name");
			String query = "SELECT a.auction_id, a.item_id, i.name "
					+ "FROM auction a, item i "
					+ "WHERE a.item_id = i.item_id AND (i.item_id = " + Integer.toString(itemID) + " "
					+ "OR i.category_name = \"" + itemCategory + "\")";
			System.out.println(query);
			ResultSet result = stmt.executeQuery(query);
			
			while(result.next() && numAuctions < 3) {
				similarAuctions[numAuctions] = result.getInt("auction_id");
				numAuctions++;
			}
			return similarAuctions;
		} catch(Exception e) {
			System.out.print(e);
			return similarAuctions;
		}
	}	
}
