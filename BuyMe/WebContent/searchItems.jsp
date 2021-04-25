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
	ApplicationDB db = null;
	try {
		//Get the database connection
		db = new ApplicationDB();	
		Connection con = db.getConnection();		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String category = request.getParameter("category");
		// 
		// Getting any subcategories of category
		//
		ResultSet childCategories = stmt.executeQuery("SELECT DISTINCT name FROM category where subcategory_of = \"" + category + "\""); 
		ArrayList<String> subCategories = new ArrayList<String>();
		while (childCategories.next()){
			subCategories.add(childCategories.getString("name"));
		}

		String queryItem = "SELECT * FROM item WHERE name like \"%" 
						+ request.getParameter("query") + "%\" and (category_name = \"" + category + "\"";
		String queryCount = "SELECT COUNT(*) as c FROM item WHERE name like \"%" 
				+ request.getParameter("query") + "%\" and (category_name = \"" + category + "\"";
		
		// Append any subcategories that can be matched with to the queries
		for (int i = 0; i < subCategories.size(); i++){
			queryItem += " OR category_name = \"" + subCategories.get(i) + "\"";
			queryCount += " OR category_name = \"" + subCategories.get(i) + "\"";
		}
		queryItem += ")";
		queryCount += ")";
		//out.print(queryItem);
	%>
		
		<h1>Returned 
			<% 
				// Printing the number of query results
				ResultSet count = stmt.executeQuery(queryCount);
				int numResults = -1;
				if (count.next()){
					numResults = count.getInt("c");
				}
				if (numResults == 1){
					out.print(numResults);
					out.print(" items ");
				} else if (numResults > 1){
					out.print(numResults);
					out.print(" items ");
				} else if (numResults == 0){
					out.print(" no items ");
				}
				out.print("for <u>" + category + "</u> query \"");
				out.print(request.getParameter("query") + "\".");
			%> 
		</h1>
	<%	
		ArrayList<String> headers = new ArrayList<String>();
		ResultSet sub = stmt.executeQuery("SELECT subcategory_of FROM category WHERE name = \"" + category + "\"");
		sub.next();
		String[] specs = {"spec1", "spec2", "spec3", "spec4", "spec5", "spec6", "spec7", "spec8", "spec9", "spec10",
            "spec11", "spec12", "spec13", "spec14", "spec15", "spec16", "spec17", "spec18", "spec19", "spec20"}; 
		// If category is a subcategory of some parent category, append parent's spec names to front
		String parentCategory = sub.getString("subcategory_of");
		if (parentCategory != null){
			ResultSet parentSpecs = stmt.executeQuery("SELECT * FROM category WHERE name = \"" + parentCategory + "\"");
			parentSpecs.next();
			for (String spec : specs){
				if (parentSpecs.getString(spec) != null){
					headers.add(parentSpecs.getString(spec));
				}
			}
		}
		// Getting the spec names for category
		ResultSet specNames = stmt.executeQuery("SELECT * FROM category WHERE name = \"" + category + "\"");
		specNames.next();

		for (String spec : specs){
			if (specNames.getString(spec) != null){
				headers.add(specNames.getString(spec));
			}
		}

		
	%>
		<table border="10" cellpadding="10" cellspacing="0">
			<tr>  
				<td>Item ID</td>
				<td>Item Name</td>
				<td>Description</td>
				<% 
				for (String spec : headers){
				    out.print("<td>" + spec + "");
				}
				%>
				<td>Set Alert</td>
			</tr>
			<% ResultSet result = stmt.executeQuery(queryItem); %>
			<% while (result.next()) { %>
				<tr> 
					<td><%= result.getInt("item_id") %></td>
					<td><%= result.getString("name") %></td>
					<td><%= result.getString("description") %></td>
					<%
					    for (int i = 0; i < headers.size(); i++){
					    	if (result.getString(specs[i]) != null){
					    		out.print("<td>" + result.getString(specs[i]) + "");
					    	}
					    }
					%>
					<td>
						<form method="get" action="item_Alert.jsp">
							<input type="hidden" name="itemID" value="<%= result.getString("item_id") %>">
							<input type="submit" value="Set alert for Item #<%= result.getString("item_id") %>">
						</form>
					</td>
				</tr>
			<% }
			db.closeConnection(con);
			%>
		</table>	
	<%
	} catch (Exception e) {
		out.print(e);
	}
	%>

</body>
</html>