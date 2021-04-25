<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="buyMe.*"%>

<%@ page import="java.io.*, java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// Validate user
	String bidder = (String) session.getAttribute("user");
	if (bidder == null) response.sendRedirect("login.jsp");

	try {
        // Validate ID and amount
        int auctionID = Integer.parseInt(request.getParameter("auctionid"));
        double bidAmount = Double.parseDouble(request.getParameter("bid-amount"));
        if (bidAmount <= 0) { 
        String forwardURL = "view_auction.jsp?auctionid=" + auctionID; %>
            <jsp:forward page="error.jsp">
                <jsp:param name="errorMessage" value="Bid amounts cannot be negative in value"/>
                <jsp:param name="forwardURL" value = "<%=forwardURL %>"/>
                <jsp:param name="forwardMessage" value = "Return to auction"/>
            </jsp:forward>
        <% }
        try {
            // Place bid
            Bid.placeBid(auctionID, bidAmount, bidder);
            // Alert other bidders that they have been outbid
            Alert.notifyOtherBidders(auctionID, bidder);
            response.sendRedirect("view_auction.jsp?auctionid=" + auctionID);
        } catch (Exception e) {
            e.printStackTrace();
        }
    } catch (NumberFormatException e) { %>
            <jsp:forward page="error.jsp">
                <jsp:param name="errorMessage" value="Invalid request parameters, please check your request and try again"/>
            </jsp:forward> <%
        e.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    }
	%>
</body>
</html>