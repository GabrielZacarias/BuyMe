package buyMe;

import java.util.Map;
import java.util.List;
import java.util.HashMap;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.ArrayList;

public class Utils {
	
	public static List<Map<String, Object>> resultSetToList(ResultSet rs) throws SQLException {
		List<Map<String, Object>> res = new ArrayList<Map<String, Object>>();
		ResultSetMetaData md = rs.getMetaData();
		int cols = md.getColumnCount();
	    while (rs.next()) {
	        Map<String, Object> row = new HashMap<String, Object>(cols);
	        for (int i = 1; i <= cols; ++i) {
	        	//System.out.println(md.getColumnName(i));
	            row.put(md.getColumnName(i), rs.getObject(i));
	        }
	        res.add(row);
	    }
	    return res;
	}
	
	public static List<Map<String, Object>> resultSetToListNoNull(ResultSet rs) throws SQLException {
		List<Map<String, Object>> res = new ArrayList<Map<String, Object>>();
		ResultSetMetaData md = rs.getMetaData();
		int cols = md.getColumnCount();
	    while (rs.next()) {
	        Map<String, Object> row = new HashMap<String, Object>(cols);
	        for (int i = 1; i <= cols; ++i) {
	        	if (rs.getObject(i) == null) continue;
	        	//System.out.println(md.getColumnName(i));
	            row.put(md.getColumnName(i), rs.getObject(i));
	        }
	        res.add(row);
	    }
	    return res;
	}
	
	public static double parseDouble(String s) throws IllegalArgumentException {
		if (s == null) throw new IllegalArgumentException("Input was null");
		s = s.replace("$", "");
		double val;
		try {
			val = Double.parseDouble(s);
		} catch (NumberFormatException e) {
			throw new IllegalArgumentException("Input (" + s + ") cannot be parsed to Double");
		}
		if (val < 0) throw new IllegalArgumentException("Input (" + s + ") cannot be negative");
		return val;
	}
	
	public static int parseInt(String s) throws IllegalArgumentException {
		if (s == null) throw new IllegalArgumentException("Input was null");
		s = s.replace("$", "");
		int val;
		try {
			val = Integer.parseInt(s);
		} catch (NumberFormatException e) {
			throw new IllegalArgumentException("Input (" + s + ") cannot be parsed to Integer");
		}
		if (val < 0) throw new IllegalArgumentException("Input (" + s + ") cannot be negative");
		return val;
	}
	
	public static String format(Double num) {
		NumberFormat f = NumberFormat.getCurrencyInstance();
		return f.format(num);
	}
	
	
	

}
