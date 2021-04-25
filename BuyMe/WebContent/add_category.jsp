<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*" %>
    
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create new category</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

</head>
<body>
<%@ include file="./includes/navbar.jsp" %>
<% if (session.getAttribute("user") == null) response.sendRedirect("index.jsp");  %>
	<main class="container padding">
		<h1>Add category</h1>
		<%
			ApplicationDB db = null;
			Connection con = null;
			ResultSet res = null;
			try {
				db = new ApplicationDB();
				con = db.getConnection();
				Statement stmt = con.createStatement();
				String s = "SELECT * FROM category WHERE subcategory_of IS NULL";
				res = stmt.executeQuery(s);
				
			} catch (Exception e) {
				db.closeConnection(con);
				e.printStackTrace();
			}
		%>
		
    	<form action="process_category.jsp" method="post" id="specification-types">
    	  <div class="form-group">
		    <label>Category Name:</label>
		    <input type="text" class="form-control" placeholder="Category name" name="category-name">
		  </div>
		  <div class="form-group">
		      <label for="subcategory-select">Subcategory of:</label>
		      <select id="subcategory-select" class="form-control" name="subcategory-of">
		        <option selected>None</option>
		        <% if (res != null) {
		        	while (res.next()) { %>
		        		<option><%= res.getString("name") %></option>
		        	<% }
		        	} %>
		      </select>
    	  </div>
    	  <h1>Add Specification Types</h1>
    	  <h4>i.e. size, color, etc.</h4>
		  <div class="form-group">
		    <label>Specification Type:</label>
		    <input type="text" class="form-control specification" placeholder="Name" id="spec-1" name="spec-1">
		  </div>
		</form>
		<button class="btn btn-primary" id="add-spec" value="1">Add Another Specification (max 20)</button>
		<hr>
		<button type="submit" form="specification-types" class="btn btn-primary" id="submit-category">Submit</button>
	</main>
</body>
<script>
	document.querySelector('#add-spec').addEventListener('click', (e) => {
		const button = e.target
	    const numSpecs = parseInt(e.target.value)
	    console.log(numSpecs)
	    const specContainer = document.querySelector('#specification-types')
	    if (numSpecs >= 20) {
	        console.log("TODO: too many")
	        return;
	    }
	    const newSpec = document.createElement('div')
	    newSpec.className = 'form-group'
	    newSpec.innerHTML = "<div class='form-group'><label>Specification Type: </label><input type='text' class='form-control specification' name='spec-" + (numSpecs + 1) + "' placeholder='Name'>"
	    specContainer.appendChild(newSpec)
	    e.target.value = '' + (numSpecs + 1)
	    console.log(numSpecs)
	})
</script>
</html>