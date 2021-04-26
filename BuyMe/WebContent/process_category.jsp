<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*" %>
    
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		ApplicationDB db = null;
		Connection con = null;
		ResultSet res = null;
		String categoryName = request.getParameter("category-name");
		String subcategoryOf = request.getParameter("subcategory-of");
		if (subcategoryOf.equals("None")) subcategoryOf = null;
		List<String> specs = new ArrayList<String>();
		for (int i = 1; i <= 20; i++) {
			String spec = request.getParameter("spec-" + i);
			if (spec != null && spec != "") {
				specs.add(spec);
			}
		}
		try {
			db = new ApplicationDB();
			con = db.getConnection();
			Statement stmt = con.createStatement();
			StringBuilder insert = new StringBuilder(
					"INSERT INTO category VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			System.out.println(insert.toString());
			PreparedStatement ps = con.prepareStatement(insert.toString());
			ps.setString(1, categoryName);
			ps.setString(2, subcategoryOf);
			for (int i = 0; i < 20; i++) {
				ps.setString(i+3, i < specs.size() ? specs.get(i) : null);
			}
			ps.executeUpdate();
			
		} catch (Exception e) {
			db.closeConnection(con);
			e.printStackTrace();
		}

		response.sendRedirect("post_auction.jsp");
		
	%>
</body>
</html>