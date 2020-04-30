<!-- Written By: Vancha Verma vv199 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<head>
<title>Edit Reservations </title>
</head>
<body>
<a style="color: black; text-decoration: none; font-size: 20px;"href="Home.jsp"><button style="background-color: green; position:absolute; top:2%; left: 4%; border-radius: 10px;">Home</button></a>
<a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp"><button style="background-color: red; position:absolute; top:2%; right: 4%; border-radius: 10px;">Logout</button></a>

<h1 style="text-align:center; top:50px;"> Edit Reservation</h1>
	<div style="align:center; text-align:center; " >

	<%
	if(session.getAttribute("user") == null) {
		response.sendRedirect("index.jsp");
	}
		String rid = request.getParameter("v_val");
		String change = "";
		//session.setAttribute("changed", change);
		
		//String rid = request.getParameter("val");
		try{
		//connect to database
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String og = "SELECT tsa.tl_id, r.* from reservations r, train_schedule_assignment tsa WHERE r.rid = '" + rid + "' AND r.schedule_num = tsa.schedule_num";
		System.out.println(og); 
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(og);

		ResObj entry = new ResObj();

		while(result.next()) {
			entry.setRid(result.getString("r.rid"));
			entry.setTransit(result.getString("tsa.tl_id"));
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
		//System.out.println(entry.getDest());
		//System.out.println(entry.getOrigin());
		String time = "select tst.arrival_time, tst.schedule_num"
				+ " from train_schedule_timings tst, train_schedule_assignment tsa"
				+ " where tst.schedule_num = tsa.schedule_num AND tsa.tl_id = '" + entry.getTransit() + "';";
				
		//System.out.print(time); 
					
		result = stmt.executeQuery(time); 
		ArrayList<String> times = new ArrayList<String>(); 
		ArrayList<String> schNum = new ArrayList<String>(); 
		while(result.next()){
			times.add(result.getString("tst.arrival_time")); 
			schNum.add(result.getString("tst.schedule_num"));
		}
		
		String getSt = "SELECT s.name, s.station_id" 
				+ " FROM station s where s.station_id >= " + entry.getOrigin() 
				+ " AND s.station_id <= " + entry.getDest() + ";";  
		result = stmt.executeQuery(getSt); 
		ArrayList<String> st = new ArrayList<String>(); 
		ArrayList<String> st_id = new ArrayList<String>(); 
		
		while(result.next()){
			st.add(result.getString("s.name")); 
			st_id.add(result.getString("s.station_id")); 
		}
		
		%>
		
			<form action = "resPage.jsp?v_rid=<%=rid%>" method= "post">
			
			<p><b>Change Origin: </b>
			<select id="origin" name="origin">
			<% for(int i = 0; i < st.size(); i++){ 
				if(entry.getOrigin().equals(st_id.get(i))){ %>
  					<option id=<%=st_id.get(i)%> name="origin" value=<%=st_id.get(i)%> selected ><%out.print(st.get(i));%></option>
				<% } else { %>
					<option id=<%=st_id.get(i)%> name="origin" value=<%=st_id.get(i)%>><%out.print(st.get(i));%></option>
				<%} 
			}%>
			</select>&nbsp;&nbsp;
			
			<b>Change Destination: </b>
			<select id="dest" name="dest">
			<% for(int i = 0; i < st.size(); i++){ 
				if(entry.getDest().equals(st_id.get(i))){ %>
  					<option id="<%=st_id.get(i)%>" name="dest" value=<%=st_id.get(i)%> selected ><%out.print(st.get(i));%></option>
				<% } else { %>
					<option id=<%=st_id.get(i)%> name="dest" value=<%=st_id.get(i)%>><%out.print(st.get(i));%></option>
				<%} 
			}%>
			</select> 
			
			<p><b>Change Time: </b>
			<select id="schNum" name="schNum">
			<% for(int i = 0; i < times.size(); i++){ %>
  				<option id=<%=schNum.get(i)%> name="schNum" value=<%=schNum.get(i)%>><%out.print(times.get(i));%></option>
			<% } %>
			</select></p>
		
			<p><b>Change Ticket Type: </b></p>
			<input type="radio" id="one" name="trip" value="One" checked/>
			<label for="one">One-Way</label>
			<input type="radio" id="two" name="trip" value="Round">
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
			<button a style = "color: white; background-color: red;" name = "res_change" value = "delete">Delete Reservation</button>
			</a></p>
			</form>
			
			<%

		db.closeConnection(con);
	} catch (Exception e) {
		out.print(e);
	}
	
	
	%>
</div>
</body>
</html>
