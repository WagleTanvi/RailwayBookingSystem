<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>

<title>Edit Reservations </title>
</head>
<body>
<a style="color: black; text-decoration: none; font-size: 20px;"href="Home.jsp"><button style="background-color: green; position:absolute; top:2%; left: 4%; border-radius: 10px;">Home</button></a>
<a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp"><button style="background-color: red; position:absolute; top:2%; right: 4%; border-radius: 10px;">Logout</button></a>
		   
<h1 style="text-align:center; top:50px;"> Edit Reservation</h1>
	<div style="align:center; text-align:center; " >
	
	<%
		String rid = request.getParameter("v_val"); 
		String change = ""; 
		session.setAttribute("changed", change); 
	%>
			
			<form action = "resPage.jsp?v_rid=<%=rid%>" method= "post">			
				<p><b>Change Ticket Type: </b></p>
				<input type="radio" id="one" name="trip" value="One" checked/>
				<label for="one">One-Way</label>
				<input type="radio" id="two" name="trip" value="Two">
				<label for="two">Round-Trip</label>
				<input type="radio" id="weekly" name="trip" value="Weekly">
				<label for="weekly">Weekly</label> 
				<input type="radio" id="monthly" name="trip" value="Monthly">
				<label for="monthly">Monthly</label>
				  
				<p><b>Change Discount:</b></p>
				<input type="radio" id="normal" name="discount" value="Normal" checked>
				<label for="discount">Normal</label>
				<input type="radio" id="senior/child" name="discount" value="Senior/Child">
				<label for="senior">Senior/Child</label> 
				<input type="radio" id="disabled" name="discount" value="Disabled">
				<label for="disabled">Disabled</label><br>
				  
				<p><b>Change Class:</b></p>
				<input type="radio" id="Business" name="class" value="Business" checked>
				<label for="business">Business</label>
				<input type="radio" id="First" name="class" value="First">
				<label for="First">First</label>
				<input type="radio" id="Economy" name="class" value="Economy">
				<label for="Economy">Economy</label><br><br>
			    <input type="submit" name = "res_change" value = "Update">
				
				<a style="color: black; text-decoration: none;" href="resPage.jsp?v_val=cancel?">
					<button a style="color: black;">Cancel</button></a>
				
				<p><a style="color: black; text-decoration: none;" href = "resPage.jsp?v_rid=<%=rid%>">
					<button a style = "color: black; background-color: red;" name = "res_change" value = "delete">Delete Reservation</button>
				</a></p>
			</form>
			



<%		try{

			//String rid = request.getParameter("val"); 
			
			//connect to database 
			ApplicationDB db = new ApplicationDB(); 
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String og = "SELECT * from reservations r WHERE r.rid = '" + rid + "'"; 
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(og);
			
			ResObj entry = new ResObj();
			
			while(result.next()) {	  
				entry.setRid(result.getString("r.rid")); 
				entry.setResDate(result.getString("r.date_reserved"));
				entry.setBought(result.getString("r.date_ticket"));
				entry.setClass(result.getString("r.class"));
				entry.setCost("$"+ result.getString("r.total_cost")); 
				if(result.getString("r.discount").equals("Normal")){
					entry.setDisc("None"); 
				}
				if(result.getString("r.trip").equals("One")){
					entry.setTrip("One-Way"); 
				} else {
					entry.setTrip(result.getString("r.trip"));
				}
				
				entry.setDest(result.getString("r.destination"));
				entry.setOrigin(result.getString("r.origin"));  
			}

			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
		%>
		
		</div>

</body>
</html>
