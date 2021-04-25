<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="buyMe.*"%>
<%@ page import= "java.io.*,java.util.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	try {
		int alertid = Integer.parseInt(request.getParameter("alertid"));
		Alert.markRead(alertid);
		response.sendRedirect("user_dashboard.jsp");
	} catch (Exception e) {
		e.printStackTrace();
	}

%>

</body>
</html>