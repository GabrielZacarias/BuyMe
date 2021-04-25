<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        
<%@ page import="java.io.*, java.text.SimpleDateFormat, java.util.Date, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String user = (String)session.getAttribute("user");
		String searchType = request.getParameter("searchType");
		//System.out.println("searchType = " + searchType);
		if (searchType.equals("1")){
			//System.out.println("Here");
			response.sendRedirect("browseAuction.jsp");
		} else if (searchType.equals("2")){
			response.sendRedirect("browseUser.jsp");
		} else if (searchType.equals("3")){
			response.sendRedirect("browseItem.jsp");
		}
	%>

</body>
</html>