<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="buyMe.*" %>
    
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.*" %>
<%@ page import="java.time.*, java.time.format.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List a new auction</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
<%@ include file="./includes/navbar.jsp" %>

	<% if (session.getAttribute("user") == null) {
		response.sendRedirect("index.jsp");
	}%>
	<%
			ApplicationDB db = null;
			Connection con = null;
			ResultSet rs = null;
			Map<String, List<String>> categorySpecs = new HashMap<String, List<String>>();
			List<Map<String, Object>> res = null;
			try {
				db = new ApplicationDB();
				con = db.getConnection();
				Statement stmt = con.createStatement();
				String s = "SELECT * FROM category";
				rs = stmt.executeQuery(s);
				
				res = Utils.resultSetToList(rs);
				System.out.println(res);
			    // IMPORTANT! - add these to existing JSP's
			    rs.close();				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				db.closeConnection(con);
			}
		%>
	<main class="container padding">
		<h1>Create new listing</h1>
		<form action="process_new_auction.jsp" method="POST">
		<h4>Item details</h4>
		<div class="form-group">
		      <label for="category-select">Category:</label>
		      <select id="category-select" class="form-control" name="category">
		      <option id="default-subcategory-option" disabled selected value> -- select an category -- </option>
		      
		        <!-- Get existing categories -->
		        <% 
		        // add options for each category.. specification types stored in dataset attribute
		        // option ID holds the category key (name)
		        for (Map<String, Object> row : res) {
		        	String name = (String)row.get("name");
		        	if (row.get("subcategory_of") != null) continue;
		        	String sp = "";
		        	for (int i = 1; i <= 20; i++) {
		        		String col = "spec" + i;
		        		if (row.get(col) == null) continue;
		        		String spec = (String)row.get(col);   		
		        		if (spec != null) {
		        			if (i != 1) sp  += ",";
		        			sp += spec;
		        		}
		        	}
		        	
		        	%>
		        	<option class="category-name" <% out.print("id=\"" + row.get("name") + "\""); %> <% if (sp != "") out.print("data-specs=\"" + sp + "\""); %>><%= row.get("name") %></option>
		        	<% 
		        } %>
		      </select>
		      <a href="add_category.jsp">Create a new category</a>
    	</div>
    	<div class="form-group">
		      <label for="subcategory-select">Subcategory (Optional):</label>
		      <select id="subcategory-select" class="form-control" name="subcategory">
		      <option id="default-subcategory-option" disabled selected value> -- select an subcategory -- </option>
		      
		        <% 
		        // add options for all subcategories.. keep hidden untill event listener for category shows them
		        for (Map<String, Object> row : res) {
		        	String name = (String)row.get("name");
		        	if (row.get("subcategory_of") == null) continue;
		        	String sp = "";
		        	for (int i = 1; i <= 20; i++) {
		        		String col = "spec" + i;
		        		if (row.get(col) == null) continue;
		        		String spec = (String)row.get(col);   		
		        		if (spec != null) {
		        			if (i != 1) sp  += ",";
		        			sp += spec;
		        		}
		        	}
		        	
		        	%>
		        	<option style="display: none" class="subcategory-name" <% out.print("data-supercategory=\"" + row.get("subcategory_of") + "\" id=\"" + row.get("name") + "\""); %> <% if (sp != "") out.print("data-specs=\"" + sp + "\""); %>><%= row.get("name") %></option>
		        	<% 
		        } %>
		      </select>
    	</div>

    	<div class="form-group">
			<label for="auction-title">Item name:</label>
			<input class="form-control" required type="text" name="item-name">
		</div>
		<div class="form-group">
			<label for="auction-title">Item Description:</label>
			<input class="form-control" required type="text" name="item-description">
		</div>
		<h4>Item Specifications</h4>
		<div class="specifications">
		<!-- Dynamically Generated -->
		</div>
		
		<h4>Auction details</h4>
		<div class="form-group">
			<label for="auction-title">Auction Title</label>
			<input class="form-control" type="text" name="auction-title">
		</div>
		<div class="form-group">
			<label for="auction-description">Additional auction details:</label>
			<!-- i.e. free shipping, yada yada -->
			<input class="form-control" required type="text" name="auction-description">
		</div>
		<div class="form-group">
			<label for="auction-close">Auction close:</label>
			<%
			LocalDateTime now = LocalDateTime.now();
			DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String date = format.format(now);
			format = DateTimeFormatter.ofPattern("HH:mm");
			String time = format.format(now);
			System.out.println(date + "T" + time);  
			%>
			<input class="form-control" required type="datetime-local" <% out.print("min= \"" + date + "T" + time + "\""); %> name="auction-close">
		</div>
		<div class="form-group">
			<label for="auction-reserve">Reserve:</label>
			<input class="form-control" type="text" name="reserve">
		</div>
		<div class="form-group">
			<label for="start-price">Starting price:</label>
			<input class="form-control" type="text" name="start-price">
		</div>
		<div class="form-group">
			<label for="increment">Increment amount:</label>
			<input class="form-control" type="text" name="increment">
		</div>
		
		
		
		<button type="submit" class="btn btn-primary" id="submit-category">Submit</button>
		
		</form>
	</main>

</body>
<script>
	//TODO:
	// - either add a load function to turn on subcategories if applicable, else have a default category "Please select...:"
	// to handle case when first category has subcategories
	// - need listener for subcategory selection
	// - option to remove subcategory selection after selection
	
	
	window.addEventListener('load', (event) => {
		document.querySelector('#category-select').selectedIndex = 0
		document.querySelector('#subcategory-select').selectedIndex = 0
	});

	document.querySelector('#category-select').addEventListener('change', e => {
        const specsString = e.target.options[e.target.selectedIndex].dataset.specs;
        const rowId = e.target.options[e.target.selectedIndex].id;
        const subCatSelect = document.querySelector('#subcategory-select')
        subCatSelect.selectedIndex = 0
        hideAllSubcategories()
        showSubcategories(rowId)
        const specsContainer = document.querySelector('.specifications')
    	removeAllChildren(specsContainer)
    	if (specsString) {
    		const specs = specsString.split(",")
    		displaySpecs(specs)
    	}
    })
    
    document.querySelector('#subcategory-select').addEventListener('change', e => {
        const specsString = e.target.options[e.target.selectedIndex].dataset.specs
        const specsContainer = document.querySelector('.specifications')
    	removeAllChildren(specsContainer)
    	if (specsString) {
    		const specs = specsString.split(",")
    		displaySpecs(specs)
    	}
    })
    
    const displaySpecs = (specs) => {
    	const specsContainer = document.querySelector('.specifications')
    	removeAllChildren(specsContainer)
    	let i = 1
    	specs.forEach(spec => {
    		const formGroup = document.createElement('div')
    		formGroup.class = 'form-group'
    		formGroup.innerHTML = "<div class='form-group'><label>" + spec + "</label><input class='form-control' type='text' name='spec-" + (i++) + "'>"
    		specsContainer.appendChild(formGroup)
    	})
    }
    
    const removeAllChildren = (parent) => {
    	while (parent.firstChild) {
            parent.removeChild(parent.firstChild);
        }
    }
    
    const showSubcategories = (superCategory) => {
    	const el = document.querySelector('#subcategory-select')
    	Array.from(el.options).forEach(opt => {
    		console.log(opt)
    		if (opt.dataset.supercategory == superCategory) {
    			opt.style.display = 'block'
    		}
    	})
    }
    
    const hideAllSubcategories = () => {
    	const el = document.querySelector('#subcategory-select')
    	let children = el.childNodes;
    	let array = Array.from(children);
    	console.log(array)
    	array.forEach(child => {
    		console.log(child.nodeName)
    		if (child && child.nodeName === 'OPTION' && child.id !== 'default-subcategory-option') child.style.display = 'none'
    	})
    }
</script>
</html>