<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*"%>
    
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>
    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ include file="./includes/navbar.jsp" %>
	<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	int itemID = Integer.valueOf(request.getParameter("itemID"));
	try {
		String user = (String) session.getAttribute("user");
		if (user == null) response.sendRedirect("index.html");
		String insertItemInterest = "INSERT into interested_in VALUES (?,?)";
		PreparedStatement ps = con.prepareStatement(insertItemInterest);
		ps.setInt(1, itemID);
		ps.setString(2, user);
		ps.executeUpdate();
	%>
		<h1>Success! Alert set for Item #<%= itemID %></h1>
		
		Note! This alert is only good to alert for 1 auction for Item #<%= itemID %>,
		and only 1 alert can be set per item per user. To continuously receive alerts
		for Item #<%= itemID %>, you must browse here again to re-set the alert.
	<%
	} catch (SQLIntegrityConstraintViolationException ex){ 
	%>
		<h1>Error occurred while setting alert set for Item #<%= itemID %></h1>
		
		Only 1 alert can be set per item per user at a time. You have already set an alert for this item.

	<%
	} catch (Exception e) {
	%>
		<h1>Error occurred while setting alert set for Item #<%= itemID %></h1>

		An unexpected error occurred while setting this alert. See exception for more details.
		<br>
	<%
		out.print(e);
	} finally {
		db.closeConnection(con);
	}
	%>

</body>
</html>